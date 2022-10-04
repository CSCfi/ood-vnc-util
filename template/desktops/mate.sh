#!/bin/bash

export PS1='(CONTAINER)[\u@\h \W]\$ '
# Turn off screensaver (this may not exist at all)
echo "DEBUG: $XDG_RUNTIME_DIR"
ls $XDG_RUNTIME_DIR
find $XDG_RUNTIME_DIR
echo "DEBUG END"
gsettings set org.mate.screensaver idle-activation-enabled false

# Disable gnome-keyring-daemon
gsettings set org.mate.session gnome-compat-startup "['smproxy']"

# Remove any preconfigured monitors
if [[ -f "${HOME}/.config/monitors.xml" ]]; then
  mv "${HOME}/.config/monitors.xml" "${HOME}/.config/monitors.xml.bak"
fi
# Set background to CSC background
echo "DEBUG SETTING BACKGROUND"
gsettings set org.mate.background picture-filename '/background.jpg'

echo "DEBUG SETTING DESKTOP"
# Setting XDG_DESKOP_DIR only doesn't work, need to run xdg-user-dirs-update
xdg-user-dirs-update --set DESKTOP "$XDG_DESKTOP_DIR"

# Copy over the user's icons
cp -n "$HOME/Desktop"/* "$XDG_DESKTOP_DIR"

# Disable useless services on autostart
AUTOSTART="$XDG_CONFIG_HOME/autostart"
rm -fr "${AUTOSTART}"    # clean up previous autostarts
mkdir -p "${AUTOSTART}"
for service in "gnome-keyring-pkcs11" "gnome-keyring-secrets" "gnome-keyring-ssh" "mate-volume-control-applet" "polkit-mate-authentication-agent-1" "spice-vdagent" "print-applet" "mate-power-manager" "mate-screensaver"; do
  cat "/etc/xdg/autostart/${service}.desktop" <(echo "X-MATE-Autostart-enabled=false") > "${AUTOSTART}/${service}.desktop"
done

dconf write /org/mate/terminal/profiles/default/login-shell true

mate-session
