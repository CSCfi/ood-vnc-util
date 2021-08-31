#!/bin/bash

# Turn off screensaver (this may not exist at all)
gsettings set org.mate.screensaver idle-activation-enabled false

# Disable gnome-keyring-daemon
gsettings set org.mate.session gnome-compat-startup "['smproxy']"

# Remove any preconfigured monitors
if [[ -f "${HOME}/.config/monitors.xml" ]]; then
  mv "${HOME}/.config/monitors.xml" "${HOME}/.config/monitors.xml.bak"
fi

# Set background to CSC background
gsettings set org.mate.background picture-filename '/background.jpg'

# Disable useless services on autostart
AUTOSTART="$XDG_CONFIG_HOME/autostart"
rm -fr "${AUTOSTART}"    # clean up previous autostarts
mkdir -p "${AUTOSTART}"
for service in "gnome-keyring-pkcs11" "gnome-keyring-secrets" "gnome-keyring-ssh" "mate-volume-control-applet" "polkit-mate-authentication-agent-1" "spice-vdagent" "print-applet" "mate-power-manager" "mate-screensaver"; do
  cat "/etc/xdg/autostart/${service}.desktop" <(echo "X-MATE-Autostart-enabled=false") > "${AUTOSTART}/${service}.desktop"
done

dconf write /org/mate/terminal/profiles/default/login-shell true

mate-session
