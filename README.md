# OOD VNC

OOD interactive app that launches a VNC inside a container with apps from the module system available.
The app is based on the normal bc_desktop app but modified to run inside a container.

The app requires [ood-util](https://github.com/CSCfi/ood-util) and [ood-initializers](https://github.com/CSCfi/ood-initializers) to work.

The user can select either *xfce*, *mate* or *single application* as the desktop environment.
When xfce or mate is selected the user will have icons on the desktop to launch some applications that we support.
When *single application* is selected we only launch xfwm and the selected application.

### Apps
The overall structure is based on the bc_desktop app included in OOD.
We execute different scripts to setup the application depending on the desktop environment chosen.
In addition to that we have similar scripts for each supported application.

For launching applications that need to run inside their own container, such as QGIS, we ssh to localhost with the correct environment variables set and launch the application.

### Desktop shortcuts
We utilize OODs Ruby template functionality to create a directory with desktop shortcuts inside the OOD app data root.
That way we isolate the OOD app from interfering with other possible OOD VNC apps and also make it possible to add additional desktop shortcuts without rebuilding the VNC containers.


# Deploying

- `applications` => `/appl/opt/ood/$SLURM_OOD_ENV/share/applications`
- `icons` => `/appl/opt/ood/$SLURM_OOD_ENV/desktop_icons`
- Create symlinks `/appl/opt/ood/$SLURM_OOD_ENV/share/icons/hicolor/{48x48,scalable}/apps` => `../../../../desktop_icons`
- `menus` => `/appl/opt/ood/$SLURM_OOD_ENV/share/.config/menus`
