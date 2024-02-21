#!/bin/bash

export XDG_CONFIG_HOME="$HOME/Desktop/.config"
export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DATA_HOME="$HOME/Desktop/.local/share"
export XDG_RUNTIME_DIR="$TMPDIR/xdg_runtime"

export XDG_DATA_DIRS="/appl/opt/ood/$SLURM_OOD_ENV/share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"
export XDG_CONFIG_DIRS="/appl/opt/ood/$SLURM_OOD_ENV/share/.config:${XDG_CONFIG_DIRS:-/etc/xdg}"

export PS1='(CONTAINER)[\u@\h \W]\$ '

# Remove any preconfigured monitors
if [[ -f "${HOME}/.config/monitors.xml" ]]; then
  mv "${HOME}/.config/monitors.xml" "${HOME}/.config/monitors.xml.bak"
fi

# Copy over default panel if doesn't exist, otherwise it will prompt the user
PANEL_CONFIG="$XDG_CONFIG_HOME/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml"
if [[ ! -e "${PANEL_CONFIG}" ]]; then
  mkdir -p "$(dirname "${PANEL_CONFIG}")"
  cp "/etc/xdg/xfce4/panel/default.xml" "${PANEL_CONFIG}"
fi

# Disable startup services
xfconf-query -c xfce4-session -p /startup/ssh-agent/enabled -n -t bool -s false
xfconf-query -c xfce4-session -p /startup/gpg-agent/enabled -n -t bool -s false

# Setting XDG_DESKOP_DIR only doesn't work, need to run xdg-user-dirs-update
xdg-user-dirs-update --set DESKTOP "$XDG_DESKTOP_DIR"

# Disable useless services on autostart
AUTOSTART="$XDG_CONFIG_HOME/autostart"
rm -fr "${AUTOSTART}"    # clean up previous autostarts
mkdir -p "${AUTOSTART}"
for service in "pulseaudio" "rhsm-icon" "spice-vdagent" "tracker-extract" "tracker-miner-apps" "tracker-miner-user-guides" "xfce4-power-manager" "xfce-polkit" "xfce4-screensaver"; do
  echo -e "[Desktop Entry]\nHidden=true" > "${AUTOSTART}/${service}.desktop"
done

# Run Xfce4 Terminal as login shell (sets proper TERM)
TERM_CONFIG="$XDG_CONFIG_HOME/xfce4/terminal/terminalrc"
if [[ ! -e "${TERM_CONFIG}" ]]; then
  mkdir -p "$(dirname "${TERM_CONFIG}")"
  sed 's/^ \{4\}//' > "${TERM_CONFIG}" << EOL
    [Configuration]
    CommandLoginShell=TRUE
EOL
else
  sed -i \
    '/^CommandLoginShell=/{h;s/=.*/=TRUE/};${x;/^$/{s//CommandLoginShell=TRUE/;H};x}' \
    "${TERM_CONFIG}"
fi

# launch dbus first through eval becuase it can conflict with a conda environment
# see https://github.com/OSC/ondemand/issues/700
eval $(dbus-launch --sh-syntax)

xfconf-query -c xfce4-screensaver -n -t bool -p /saver/idle-activation/enabled -s false
xfconf-query -c xfce4-screensaver -n -t bool -p /lock/enabled -s false

# Start up xfce desktop (block until user logs out of desktop)
xfce4-session
