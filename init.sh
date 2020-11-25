#!/bin/bash

# based on https://ashley.geek.nz/2020/05/02/dual-screen-on-a-raspberry-pi-with-hdmi-goodtft-gpio-touchscreens/

#1
sudo apt update && sudo apt upgrade -VV

#2
rm -rf ./LCD-show
git clone https://github.com/goodtft/LCD-show.git

#3
sudo cp ./LCD-show/usr/tft35a-overlay.dtb /boot/overlays/
sudo cp ./LCD-show/usr/tft35a-overlay.dtb /boot/overlays/tft35a.dtbo

#4
LCD35_default_rotation=90
desired_rotation=360
new_rotate_value=$((($LCD35_default_rotation + $desired_rotation) % 360))

#5
sudo apt-get install xserver-xorg-input-evdev

#6
sudo cp -rf ./usr/99-calibration.conf-35-$new_rotate_value /usr/share/X11/xorg.conf.d/99-calibration.conf

#7
sudo sed -i '4i        Driver          “evdev”' /usr/share/X11/xorg.conf.d/99-calibration.conf

# #-----------------------------
# #1
# #3
# sudo echo "# Added for goodtft MPI3501 / LCD35" >> /boot/config.txt
# sudo echo "dtoverlay=tft35a:rotate=$new_rotate_value" >> /boot/config.txt
# sudo echo "enable_uart=1" >> /boot/config.txt

# #2
# sudo sed -i s/console=serial0,115200 ?// /boot/cmdline.txt

# #6, #7
# sudo cp -rf ./usr/99-fturbo.conf /usr/share/X11/xorg.conf.d/99-fturbo.conf

# sudo echo '' >> /usr/share/X11/xorg.conf.d/99-fturbo.conf
# sudo echo 'Section "Device"' >> /usr/share/X11/xorg.conf.d/99-fturbo.conf
# sudo echo 'Identifier "Goodtft"' >> /usr/share/X11/xorg.conf.d/99-fturbo.conf
# sudo echo 'Driver "fbturbo"' >> /usr/share/X11/xorg.conf.d/99-fturbo.conf
# sudo echo 'Option "fbdev" "/dev/fb1"' >> /usr/share/X11/xorg.conf.d/99-fturbo.conf
# sudo echo 'Option "SwapbuffersWait" "true"' >> /usr/share/X11/xorg.conf.d/99-fturbo.conf
# sudo echo 'EndSection' >> /usr/share/X11/xorg.conf.d/99-fturbo.conf

#5
echo "reboot now"
sudo reboot