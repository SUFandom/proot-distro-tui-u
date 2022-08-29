#!/bin/bash

# Ubuntu

if [ "$1" == "--ubuntu" ]
then
if (find $PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu)
then 
rm -rf "$PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu"
echo "REMOVED UBUNTU"
./main.sh
else
echo "Ubuntu isnt installed in the directory"
./rm.sh
fi
fi 

# Debian

if [ "$1" == "--debian" ]
then
if (find $PREFIX/var/lib/proot-distro/installed-rootfs/debian)
then 
rm -rf "$PREFIX/var/lib/proot-distro/installed-rootfs/debian"
echo "REMOVED DEBIAN"
./main.sh
else
echo "Debian is not installed"
./main.sh
fi
fi

# ArchLinux

if [ "$1" == "--archlinux" ]
then
if (find $PREFIX/var/lib/proot-distro/installed-rootfs/archlinux)
then
rm -rf "$PREFIX/var/lib/proot-distro/installed-rootfs/archlinux"
echo "REMOVED ARCHLINUX"
./main.sh
else
echo "ArchLinux is not Installed"
./main./sh
fi
fi 

# Alpine

if [ "$1" == "--alpine" ]
then
if (find $PREFIX/var/lib/proot-distro/installed-rootfs/alpine)
then
rm -rf "$PREFIX/var/lib/proot-distro/installed-rootfs/alpine"
echo "REMOVED ALPINE"
./main.sh 
else 
echo "Alpine is not Installed"
./main.sh
fi 
fi 

# Fedora 

if [ "$1" == "--fedora" ]
then 
if (find $PREFIX/var/lib/proot-distro/installed-rootfs/fedora)
then
rm -rf "$PREFIX/var/lib/proot-distro/installed-rootfs/fedora"
echo "REMOVED FEDORA"
./main.sh
else
echo "Fedora is not Installed"
./main.sh 
fi 
fi 

# Manjaro 

if [ "$1" == "--manjaro" ]
then 
if (find $PREFIX/var/lib/proot-distro/installed-rootfs/manjaro-aarch64)
then 
rm -rf "$PREFIX/var/lib/proot-distro/installed-rootfs/manjaro-aarch64"
echo "REMOVED MANJARO"
./main.sh
else 
echo "Manjaro AARCH64 is not installled"
./main.sh 
fi 
fi 

# OpenSuse 

if [ "$1" == "--opensuse" ]
then
if (find $PREFIX/var/lib/proot-distro/installed-rootfs/opensuse)
then
rm -rf "$PREFIX/var/lib/proot-distro/installed-rootfs/opensuse"
echo "REMOVED OPENSUSE"
./main.sh
else
echo "Opensuse is not installed"
./main.sh 
fi 
fi

# VOID

if [ "$1" == "--void" ]
then (find $PREFIX/var/lib/proot-distro/installed-rootfs/void)
then
rm -rf "$PREFIX/var/lib/proot-distro/installed-rootfs/void"
echo "REMOVED VOID"
./main.sh
else
echo "Void is not installed"
./main.sh 
fi 
fi