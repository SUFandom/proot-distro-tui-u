#!/bin/bash

# Debian
if [ $1 == "--debian" ]
then
if (find $PREFIX/var/lib/proot-distro/installed-rootfs/debian)
then
proot-distro login debian
else
proot-distro install debian
proot-distro login debian
fi
fi

# Ubuntu
if [ "$1" == "--ubuntu" ]
then
if (find $PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu)
then 
proot-distro login ubuntu
else
proot-distro install ubuntu 
proot-distro login ubuntu
fi 
fi 

# Manjaro
if [ "$1" == "--manjaro" ]
then
if (find $PREFIX/var/lib/proot-distro/installed-rootfs/manjaro-aarch64)
then 
proot-distro login manjaro-aarch64
else
proot-distro install manjaro-aarch64 
proot-distro login manjaro-aarch64
fi 
fi 

# OpenSuse
if [ "$1" == "--opensuse" ]
then
if (find $PREFIX/var/lib/proot-distro/installed-rootfs/opensuse)
then 
proot-distro login opensuse 
else
proot-distro install opensuse 
proot-distro login opensuse
fi 
fi

# Alpine 
if [ "$1" == "--alpine" ]
then 
if (find $PREFIX/var/lib/proot-distro/installed-rootfs/alpine)
then 
proot-distro login alpine 
else 
proot-distro install alpine 
proot-distro login alpine
fi 
fi 

# Arch Linux
if [ "$1"  == "--archlinux" ]
then 
if (find $PREFIX/var/lib/proot-distro/installed-rootfs/archlinux)
then 
proot-distro login alpinelinux
else 
proot-distro install archlinux
proot-distro login archlinux
fi
fi 

# Void
if [ "$1" == "--void" ]
then 
if (find $PREFIX/var/lib/proot-distro/installed-rootfs/void)
then 
proot-distro login void 
else 
proot-distro install void 
proot-distro login void 
fi
fi

# Fedora
if [ "$1" == "--fedora" ]
then 
if (find $PREFIX/var/lib/proot-distro/installed-rootfs/fedora)
then
proot-distro login fedora 
else 
proot-distro install fedora
proot-distro login fedora 
fi 
fi 

