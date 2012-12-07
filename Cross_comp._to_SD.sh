#!/bin/bash

echo " "
echo "Hello $USER."
echo "This is script, which it prepares PC to cross compiling of Raspbian kernel."
echo "Plug in your Raspbian SD card to PC."
echo "Give my full path direct to Raspbian file system:"
read sd_card
cd /usr/src
git clone --depth git://github.com/raspberrypi/linux.git
zcat $sd_card/proc/config.gz > /usr/src/.config
apt-get install -y make gcc libncurses5-dev
cd /usr/src
git clone --depth 1 git://github.com/raspberrypi/tools.git
cd tools/arm-bcm2708
cp -r arm-bcm2708hardfp-linux-gnueabi /
cd /
mv arm-bcm2708hardfp-linux-gnueabi cross
rm -r /usr/src/tools
echo "Done."
echo "You can plug SD card to Raspberry Pi and running. "
echo "Good luck."
