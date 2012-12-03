#!/bin/bash

echo "Hello $USER."
echo "This is script, which it installs your kernel."
echo "Plug your pendrive with your kernel to Raspberry Pi."
echo "Give my path to your pendrive:"
read pendrive
cp $pendrive/kernel.img /boot
echo "Kernel file (kernel.img) was  installed."
echo "Start linux kernel files copying to Raspbian."
cp -r $pendrive/linux /usr/src
echo "Kernel linux files wad copied to Raspbian."
cd /usr/src/linux
echo "Modules are installing."
make ARCH=arm CROSS_COMPILE=/cross/bin/arm-bcm2708hardfp-linux-gnueabi- modules_install INSTALL_MOD_PATH=/
echo "Done."
echo "Kernel and modules were installed."
uname -a



