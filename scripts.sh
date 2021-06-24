# Start novnc + websockify
singularity exec -B /run:/run novnc.sif /opt/novnc/utils/launch.sh --vnc localhost:5901

# Forward port to puhti
ssh -L 5901:localhost:5901 puhti-login1.csc.fi

# Local installation on turbovnc
export TURBOVNC_VERSION=2.2.6
wget https://sourceforge.net/projects/turbovnc/files/${TURBOVNC_VERSION}/turbovnc-${TURBOVNC_VERSION}.x86_64.rpm 
rpm2cpio turbovnc-2.2.6.x86_64.rpm | cpio -idmv

# Start vnc server and set DISPLAY, number might change if several are running. 
./opt/TurboVNC/bin/vncserver && export DISPLAY=:1

# Stop vnc server
./opt/TurboVNC/bin/vncserver -kill :1
