# [Unstable] proot-distro-tui

### Banners/Badges:

![codename](https://img.shields.io/badge/codename-Akane-blue?style=for-the-badge&logo=GNUBash&logoColor=white) ![rel](https://img.shields.io/badge/release-development-red?style=for-the-badge&logo=visualstudiocode)

---

[![banner](img-src/proot-dists-lgo-ustable-akane.png)](img-src/COPYRIGHT)
*tbh i wanna add linus meme to akane's face rn*



## Table of Contents


0. [Warning](#warning)
   
1. [Welcome](#welcome)
   
   1.1 [WHATS NEW](#whats-new)

2. [Features Removed](#features-removed)
3. [Roadmaps](Roadmap.md)



## Warning! 

This is an Unstable Release, this area is just a preparation to push towards main update. and to reduce bugs of course.

A Bug Report is strictly necessary when using this version, if you have issues using this, please report if there's an issue

Otherwise Visit the [Stable Version](https://github.com/SUFandom/proot-distro-tui)



## Welcome 

Do you want to use a tool that would exactly make launching Distro on your Phone so easy?

proot-distro-tui is your friend that would gladly make your distro launching so easy!!!

Want to launch distros on an older architecture? You can do that on this unstable version!



## What's NEW?!!



Some Termux Binary packages like `dialog` , `proot`, `proot-distro` are minimally required to make this work, in which i will recommend that **YOU** should install it

The script wont try to install it for you for security and ensuring stability reasons. I prefer you should do your own here to install packages. **Don't be lazy**.

Also this unstable version will finally have [Pardus](https://en.wikipedia.org/wiki/Pardus_(operating_system)), a Turkish Government Linux Distribution added to catalog (x64 Devices only, `arm64`, `intel64:i686`, and `amd64`)



*Check older releases via [Releases](https://github.com/SUFandom/proot-distro-tui-u/releases), then its source zip. But if you can't find it, you can grab it on history.*



## Features Removed:

Features that were removed in here due to some troubles, or security purposes, or just a bloat



- In `2.2-unstable_shino` - Andronix Support, that once supported in `2.1-unstable_shino` had been thrown down due to potential issues with them, as using their materials could lead me liable for potential damage on their end.

- In `2.3-unstable_shogun`, Update Features are now been taken down as the mechanisms of it are leaving garbage that the update script sometimes fail to clean, it may have to do with the formatting, but i would rather remove that since no one is using it anyways. Please Refer to Update the Repo manually.
- Removed `runtime/` due to changes in `2.3-unstable_shogun`. Runtime is supposed to be an intializer for distros, but the code sadly is now considered to be bloated. And the abilities have been transfered to `$(pwd)/main.sh` via a `function` call.
- OpenSUSE and Void are not supported, yet on `2.3-unstable_shogun` due to using function: `run_proot_cmd`, i decide to not including it for security purposes. They will come back soon tho, don't worry. 
- In this version `2.3-unstable_shogun`, some utilities that were once required; Termux:API will no longer be a part of the project as it is counted as a useless feature. And to ensure the experience would be a less of a hassle. *(Also with less bloat on your end.)*
- Uninstallers are removed in `2.3-unstable_shogun` as the user can just delete the folder themselves. And to ensure that the other files won't be accidentally deleted. (*Pre-release version Moment*)
- I realized, adding custom script libraries are next to impossible to complete as this state of manpower (im the only one developing) so skipping `2.3-unstable_shogun` and straight to `2.4-unstable-akane`
- The version will be skipped entirely from `2.3-unstable_shogun` to `2.4-unstable-akane` because the goals were changed, instead creating each script files to install distros that are cross-compatible with the architecture, i decided to just fully rely on the proot-distro's own libraries instead... which now you cannot install a Distro that is 32 bit on a 64 bit native machine... The Efforts can be seen at [`proot-distro-tui/old_deprecated`](old_deprecated) instead... (the names are like that to prevent having issues with my vscode, the linting plugin is annoying sometimes)
- Ability to import your own script has been removed due to complications in the code...


## Soon Implemented

Features that will soon be here in the unstable version



- Support for ARMv9 (ARM64 ONLY ISA)
  
  As of now, i don't have a clue what's `uname -m` call of ARMv9 Devices, but i also think i should not implement this for now since ARMv9 Devices ain't have a considerable size at the moment. SInce `ARMv8` is still up and main

---
## Script access

People should always know what the script does on your devices



- **Access to your storage Device**
  
  These are the directories that the script wants to access:

   - <!> **TERMUX STORAGE**

        `/data/data/com.termux/files/usr/etc/proot-distro`

        `/data/data/com.termux/files/usr/var/lib/proot-distro`

        `/data/data/com.termux/files/home/`
  
   - Your Device Info
      
      - Architecture of your device (Using `uname -m`)

   - <!> **Modify User Configuration**

      - To properly operate within the system