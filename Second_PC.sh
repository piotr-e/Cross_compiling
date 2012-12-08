#!/bin/bash

echo "Hello $USER."
echo "This is script, which it compiles your Raspbian kernel."
echo "Plug your pendrive with .config file to your PC."
echo "Give my path to your pendrive, please:"
read pendrive
echo "Give my number of cores, which you want to use for compilation:"
read cores
apt-get -y install make gcc git libncurses5-dev
cd /usr/src
echo "Start linux kernel source downloading, it may takes several minutes."
git clone --depth 1 git://github.com/raspberrypi/linux.git
echo "Linux kernel source downloaded."
cp $pendrive/.config /usr/src/linux/
echo "Configuration file (.config) copied to linux kernel source."
echo "Start tools downloading and installing."
cd /usr/src
git clone --depth 1 git://github.com/raspberrypi/tools.git
apt-get -y install gcc-arm-linux-gnueabihf
apt-get -y install ia32-libs
echo "Tools downloaded and installed."
echo "Cross-Compiler is installing."
cd tools/arm-bcm2708
cp -r arm-bcm2708hardfp-linux-gnueabi /
cd /
mv arm-bcm2708hardfp-linux-gnueabi cross
echo "Cross-Compiler installed."
echo "Kernel is compilling."
cd /usr/src/linux
make ARCH=arm CROSS_COMPILE=/cross/bin/arm-bcm2708hardfp-linux-gnueabi- menuconfig
make -j"$cores" ARCH=arm CROSS_COMPILE=/cross/bin/arm-bcm2708hardfp-linux-gnueabi-
echo "Kernel compiled."
echo "Modules are compilling."
make modules -j"$cores" ARCH=arm CROSS_COMPILE=/cross/bin/arm-bcm2708hardfp-linux-gnueabi-
echo "Modules compiled."
echo "Kernel is preparating for use."
cd /usr/src/tools/mkimage
./imagetool-uncompressed.py /usr/src/linux/arch/arm/boot/zImage
cp kernel.img $pendrive
echo "Kernel file (kernel.img) copied to pendrive."
echo "Modules are copying to pendrive, it may takes long time"
cd /usr/src
tar czfv $pendrive/linux.tar.gz linux/
echo "Modules copied. :-)"
echo "Cleaning."
rm -r /cross
rm -r /usr/src/tools
echo "Done."
echo "You can install kernel and modules on Raspbian now."
echo "Good luck."




