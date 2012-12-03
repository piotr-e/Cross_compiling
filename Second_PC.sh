#!/bin/bash

echo "Hello $USER."
echo "This is script, which it compiles your Raspbian kernel."
echo "You must log as superuser."
echo "Plug your pendrive with .config file to your PC."
echo "Give my path to your pendrive, please:"
read pendrive
echo "Give my number of cores, which you want to use to compilation:"
read cores
apt-get -y update
apt-get -y upgrade
apt-get -y install make gcc git libncurses5-dev
cd $pendrive
echo "Start linux kernel source downloading."
git clone --depth 1 git://github.com/raspberrypi/linux.git
cp $pendrive/.config $pendrive/linux
echo "Linux kernel source downloaded."
echo "Configuration file (.config) copied to linux kernel source."
echo "Start tools downloading."
cd /usr/src
git clone --depth 1 git://github.com/raspberrypi/tools.git
apt-get -y install gcc-arm-linux-gnueabihf
apt-get -y install ia32-libs
echo "Tools downloaded."
cd tools/arm-bcm2708
cp -r arm-bcm2708hardfp-linux-gnueabi /
cd /
mv arm-bcm2708hardfp-linux-gnueabi raspbian
echo "Cross-Compilator installed."
cd $pendrive/linux
make ARCH=arm CROSS_COMPILE=/raspbian/bin/arm-bcm2708hardfp-linux-gnueabi- menuconfig
make -j"$cores" ARCH=arm CROSS_COMPILE=/raspbian/bin/arm-bcm2708hardfp-linux-gnueabi-
echo "Kernel - done."
make modules -j"$cores" ARCH=arm CROSS_COMPILE=/raspbian/bin/arm-bcm2708hardfp-linux-gnueabi-
echo "Modules - done."
echo "Kernel preparation."
cd /usr/src/tools/mkimage
./imagetool-uncompressed.py /usr/src/linux/arch/arm/boot/zImage
cp kernel.img $pendrive
echo "Kernel file (kernel.img) copied to pendrive."
echo "Cleaning"
rm -r $pendrive/linux
rm -r /raspbian
rm -r /usr/src/tools
echo "Done"
echo "You can install kernel and modules on Raspbian now."
echo "Good luck."




