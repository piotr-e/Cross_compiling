#!/bin/bash

echo "\n"
if [ "root" != $USER ]
then
echo "Hello &USER.\nYou need root permission."
exit 1
fi
echo "\n\nHello $USER."
echo "This is script, which it prepares PC to cross compiling of Raspbian kernel."
echo "Plug in your Raspbian SD card to PC and mount both partition of SD card."
echo "Give my full path direct to Raspbian file system partition:"
read sd_card_root
echo "Give my full path direct to Raspbian boot partition:"
read sd_card_boot
echo "Give my path to .config file:"
read config_file
echo "Give my number of cores which you want to use:"
read cores
cd /usr/src
git clone --depth 1 git://github.com/raspberrypi/linux.git
cp $config_file/.config linux/
apt-get install -y make gcc libncurses5-dev
apt-get -y install gcc-arm-linux-gnueabihf
apt-get -y install ia32-libs
cd /usr/src
git clone --depth 1 git://github.com/raspberrypi/tools.git
cd /usr/src/linux
make -j"$cores" -k ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabihf- menuconfig
make -j"$cores" -k ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabihf-
cd /usr/src
mkdir modules
cd /usr/src/linux
make ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabihf- modules_install INSTALL_MOD_PATH=/usr/src/modules
cd /usr/src/tools/mkimage
./imagetool-uncompressed.py /usr/src/linux/arch/arm/boot/zImage
cp kernel.img $sd_card_boot/
rm -r $sd_card_root/lib/firmware
rm -r $sd_card_root/lib/modules
cp -r /usr/src/modules/lib/firmware $sd_card_root/lib/
cp -r /usr/src/modules/lib/modules $sd_card_root/lib/
cd /usr/src/
tar czfz $sd_card_root/usr/src/linux.tar.gz linux/
echo "Cleaning."
rm -r /usr/src/modules
rm -r /usr/src/tools
rm -r /usr/src/linux
echo "Done."
echo "You can plug in SD card to Raspberry Pi and running. "
echo "Good luck."
