#!/bin/bash

echo " "
echo "Hello $USER."
echo "This is script, which it prepares PC to cross compiling of Raspbian kernel."
echo "Plug in your Raspbian SD card to PC and mount both partition of SD card."
echo "Give my full path direct to Raspbian file system partition:"
read sd_card_root
echo "Give my full path direct to Raspbian boot partition:"
read sd_card_boot
echo "Give my number of cores which it want to use:"
read cores
cd /usr/src
git clone --depth git://github.com/raspberrypi/linux.git
zcat $sd_card_root/proc/config.gz > /usr/src/linux/.config
apt-get install -y make gcc libncurses5-dev
apt-get -y install gcc-arm-linux-gnueabihf
apt-get -y install ia32-libs
cd /usr/src
git clone --depth 1 git://github.com/raspberrypi/tools.git
cd tools/arm-bcm2708
cp -r arm-bcm2708hardfp-linux-gnueabi /
cd /
mv arm-bcm2708hardfp-linux-gnueabi raspbian
cd /usr/src/linux
make -j"$cores" -k ARCH=arm CROSS_COMPILE=/raspbian/bin/arm-bcm2708hardfp-linux-gnueabi- menuconfig
make -j"$cores" -k ARCH=arm CROSS_COMPILE=/raspbian/bin/arm-bcm2708hardfp-linux-gnueabi-
cd /usr/src
mkdir modules
make ARCH=arm CROSS_COMPILE=/cross/bin/arm-bcm2708hardfp-linux-gnueabi- modules_install INSTALL_MOD_PATH=/usr/src/modules
cd /usr/src/tools/mkimage
./imagetool-uncompressed.py /usr/src/linux/arch/arm/boot/zImage
cp kernel.img $sd_card_boot/

echo "Done."
echo "You can plug SD card to Raspberry Pi and running. "
echo "Good luck."
