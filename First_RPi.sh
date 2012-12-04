#!/bin/bash

echo "Hello $USER."
echo "This is script, which it prepares Raspbian for kernel cross-compile."
echo "Give me path to your pendrive, please:"
read pendrive
cd /usr/src
git clone git://github.com/raspberrypi/firmware.git
cd firmware/boot
cp fixup.dat bootcode.bin loader.bin start.elf start_cd.elf fixup_cd.dat kernel_cutdown.img kernel_emergency.img /boot/
echo "Firmware was updated."
zcat /proc/config.gz > $pendrive/.config
echo "Config file was copied to pendrive."
apt-get install -y make gcc libncurses5-dev
rm -r $pendrive/linux
echo "Old linux source was removed."
git clone git://github.com/raspberrypi/tools.git
cd tools/arm-bcm2708
echo "Cross-Compiler is preparing."
cp -r arm-bcm2708hardfp-linux-gnueabi /
cd /
mv arm-bcm2708hardfp-linux-gnueabi cross
echo "Cleaning."
rm -r /usr/src/tools
rm -r /usr/src/firmware
echo "Done."
echo "You can compile kernel on PC."
echo "Good luck."
