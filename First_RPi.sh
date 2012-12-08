#!/bin/bash

echo "Hello $USER."
echo "This is script, which it prepares Raspbian for kernel cross-compile."
echo "Give me path to your pendrive, please:"
read pendrive
cd /usr/src
echo "Firmware is updating, it may takes several minutes."
git clone --depth 1 git://github.com/raspberrypi/firmware.git
cd firmware/boot
cp fixup.dat bootcode.bin start.elf start_cd.elf fixup_cd.dat kernel_cutdown.img kernel_emergency.img /boot/
echo "Firmware updated."
zcat /proc/config.gz > $pendrive/.config
echo "Config file copied to pendrive."
apt-get install -y make gcc libncurses5-dev
echo "Old linux source is removing."
rm -r $pendrive/linux
echo "Old linux source removed."
echo "Necessary tools are dowloading."
cd /usr/src
git clone --depth 1 git://github.com/raspberrypi/tools.git
cd tools/arm-bcm2708
echo "Necessary tools downloaded."
echo "Cross-Compiler is preparing."
cp -r gcc-linaro-arm-linux-gnueabihf-raspbian /
cd /
mv arm-bcm2708hardfp-linux-gnueabi cross
echo "Cross-Compiler prepared."
echo "Cleaning."
rm -r /usr/src/tools
rm -r /usr/src/firmware
echo "Done."
echo "You can compile kernel on PC by running Second_PC.sh. "
echo "Good luck."
