# [Unstable] proot-distro-TUI

### Banners/Badges

![codename](https://img.shields.io/badge/codename-Shino-magenta?style=for-the-badge&logo=appveyor) ![updm](https://img.shields.io/website?down_color=red&down_message=Update%20Service%20Checkers%20offline&style=for-the-badge&up_color=blue&up_message=Update%20Service%20Checkers%20Online&url=https%3A%2F%2Fpastebin.com%2Fraw%2Fwt2xyCxH) ![rel](https://img.shields.io/badge/release-unstable-red?style=for-the-badge&logo=appveyor)

![banner](img-src/banner.png)

## Warning! This is an Unstable Release, this area is just a preparation to push towards main update. and to reduce bugs of course.

A Bug Report is necessary when using this version so please report if there's an issue


## A better tool to Start your Distro on Termux!

A Neat TUI Filled with Necessary Options

![main](img-src/sel_src01.jpg)

## The Script can now be updated Easily here

![mainmenu](img-src/main_sel_src02.jpg)

Updating this script has never been easier. Good Job

## Run GLXGEARS in the Environment with Andronix Support!

![glx-preview](img-src/glx.jpg)

*Running Debian 10 with LLVMPIPE support, thanks by `tigervnc-xorg-extension`*

This one has OpenGL 3.0 and OpenGL ES 3.0 Support too. (Vulkan Not confirmed) Although you need a VNC and yes, it won't work properly for Temux:X11 App

## Information about your Distro available!

![ubuntu_info](img-src/desc_dis.jpg)

Each Distro is given information about themselves..

## Run this Code!

``` 

chmod +x onetime.sh && ./onetime.sh 

```

## License

This Repo is under GPL 3.0. Anyone Can Have a Copy and customize, but Users have to Stick it to GPL 3.0

## Problems

Check Issues Page. Spam there..

## Updates!🔧

2.0-unstable has:

- New! Support on Andronix Installation

    I've Recently Discovered that proot-distro's installation and execution method binds with termux too much, that it defeats the purpose to use the installed distro if its just try to find library in the termux directory.
    
    With this support available, means that debian is isolated and only work whats available inside its modules, not using other modules that wasnt supposed to be there in the first place
    
    Sadly you are going to use an outdated Debian 10 and Ubuntu 20, but its for the performance benefits
    
    **AND IF YOU'RE THINKING, THAT THIS SCRIPT WILL GIVE YOU ACCESS TO ANDRONIX MODDED ARM64 DISTRO, YOU'RE WRONG, BECAUSE IT ONLY INSTALLS FREE VERSIONS, THIS ALSO TO AVOID LEGAL TROUBLE AND TO KILL YOUR EXPECTATIONS RIGHT ON THE SPOT.. CHECK SOURCE CODE FOR MORE**
    
    
    
## Available Andronix Library:

- Debian (Only ARMv7)
- Ubuntu (Only ARMv7)

## Help! Wanted

Have an AARCH64 or x86 CPU in your device? then can you share us some Andronix ARM64 / x86 Installation Strings to make it possible here? For right now only ARMv7 are supported.

## SUGGESTIONS

[**XSDL BY PELYA**](https://play.google.com/store/apps/details?id=x.org.server)

When Attempting to use X11, use XSDL with Pulseaudio support for better Experience


To activate LLVMPIPE:
```
sudo apt install tigervnc tigervnc-xorg-extension -y
```
Tigervnc works together with LLVMPIPE than XSDL, idk why about that but meh.

## Notice

Updates may be getting slower soon, Heads up! Because of the Ramadan Season.
