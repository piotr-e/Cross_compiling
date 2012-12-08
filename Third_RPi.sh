#!/bin/bash

echo "Hello $USER."
echo "This is script, which it installs your kernel."
echo "Plug your pendrive with your kernel to Raspberry Pi."
echo "Give my path to your pendrive:"
read pendrive
cp $pendrive/kernel.img /boot/
echo "Kernel file (kernel.img) installed."
echo "Start linux kernel files copying to Raspbian, it may takes several minutes."
cp $pendrive/linux.tar.gz /usr/src/
cd /usr/src
tar -xzf linux.tar.gz
rm linux.tar.gz
echo "Kernel linux files copied to Raspbian."
cd /usr/src/linux
echo "Modules are installing."
make ARCH=arm CROSS_COMPILE=/cross/bin/arm-linux-gnueabihf- modules_install INSTALL_MOD_PATH=/
echo "Modules installed."
echo "Done."
echo "Kernel and modules installed."
uname -a



