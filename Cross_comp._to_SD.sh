#!/bin/bash

echo "\n"
if [ "root" != $USER ]
then
echo "Witaj &USER.\nPotrzebujesz uprawnień administratora."
exit 1
fi
echo "\n\nHello $USER."
echo "To jest skrypt, który przygotowuje PC i kroskompiluje kernel Raspbian'a."
echo "Podlacz swoja karte SD do PC'ta i zamontuj obie partycje, startowa i systemowa."
echo "Podaj pelna sciezke dostepu do systemu plikow:"
read sd_card_root
echo "Podaj pelna sciezke dostepu do partycji startowej:"
read sd_card_boot
echo "Podaj sciezke dostepu do pliku .config:"
read config_file
echo "Podaj liczbe rdzeni procesora, które chcesz uzyc do kompilacji:"
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
echo "Done."
echo "You can plug in SD card to Raspberry Pi and running. "
echo "Good luck."
