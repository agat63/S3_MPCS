#!/bin/sh
export	PWD=`readlink -f .`

cd ramdisk-l700
chmod 744 sbin/lkflash
chmod 744 sbin/checkv
chmod 744 sbin/checkt
chmod 750 init* charger
chmod 644 default.prop
chmod 640 fstab.tuna
chmod 644 ueventd*
cd ..

echo "making ramdisk"
./mkbootfs ramdisk-l700 | gzip > ramdisk.gz
echo "making boot.img"
# packs the ramdisk together with the zImage at the proper locations and makes the boot.img
./mkbootimg --cmdline 'no_console_suspend=1 console=null' --kernel $pwd/zImage --ramdisk $pwd/ramdisk.gz -o $pwd/boot.img 
rm ramdisk.gz
