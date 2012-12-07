Cross compiling through pendrive.
==================================

There are three scripts for cross compilation of Raspbian kernel on PC computer for Ubuntu and its family.

First_RPi.sh is script for first run on Raspberry Pi after plug in pendrive. This script prepare Raspian for kernel
cross compilation and it copies .config file to the pendrive.   

Second_PC.sh is script for second run on PC computer after plug in the pendrive with the configuration file. This
script prepare PC computer for kernel cross compilation and it compiles. Then all copy to pendrive.

Third_RPi.sh is script for third run on Raspberry Pi after plug in the pendrive with the compiled kernel and modules.
This script installs the kernel and modules for Raspbian.