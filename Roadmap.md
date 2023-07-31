[< Back to README](README.md)

---

# Roadmap

The PRoot-distro-tui-u Series Roadmap Releases

This Page Highlights the Roadmap of the Project

### Disclaimers

Some info may be marked as `NA` due to records being lost

### Legend

- `NA` - Not Available
- `TBA` - To Be Announced
- `REL` - Has been Released
- `X` - Abandoned/Not Released
- `CONF` - Confidential info/reasons


### PRoot Distro Table Chart and Releases (Past, Current and Next)


| ID     | Versions              | Fixes                                                                                                              | Removed                                                                                             | Added                                                                                                                           | Channel        | Status |
|--------|-----------------------|--------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------|----------------|--------|
| **NA** | 2.0-unstable          | **NA**                                                                                                             | **NA**                                                                                              | Added Andronix support                                                                                                          | Nino (Unstable, Clone)         | REL    |
| **NA** | 2.1-unstable          | Fixed Naming of Labels                                                                                             | **NA**                                                                                              | Added Isolation Features                                                                                                        | Shino          | REL    |
| 2.2    | 2.2-unstable          | **NA**                                                                                                             | Removed Andronix Support, Isolation Features                                                        | Added Execution Feature                                                                                                         | Shino          | REL    |
| **NA** | 2.3-unstable_shogun   | Follow up to PRoot-Distro's Update                                                                                 | Most Files Revised/Rewritten, Removed access to install distros that require to use `run_proot_cmd` on custom scripts | Added Custom Support for installation scripts, Added Userspace Simulation (Cross arch support; i686 distro on an amd64 machine) | Raiden Shogun  | X      |
| **NA** | 2.3.1-unstable_shogun | Codebase Rewritten                                                                                                 | **NA**                                                                                              | **NA**                                                                                                                          | Raiden Shogun  | X      |
| 2.4    | 2.4-unstable-akane    | Codebase Rewritten, Fixed archlinux and its related distros failing to remove from the system after using `rm -rfv` | Removed support for userspace emulation, due to its complexity                                      | **NA**                                                                                                                          | Kurokawa Akane | REL      |
| 2.5    | 2.5-unstable-senko    | **TBA**                                                                                                            | **TBA**                                                                                             | **TBA**                                                                                                                         | Senko-san      |        |

*This table is always updated with next official git push*

As of now, there's some versions that are not released and skipped, because of the difficulty implemeting a feature that i, (SUFandom) can do

## Codename

Codenames (at least here) are labeled to in order to differentiate package releases, and yes, i named them after characters in the series

- Nino (Series: The Quintessal Quints)
    - Just a cloned copy of final stable release
    - Bloated Mess
- Shino (Series: Kanojo mo Kanojo)
    - Achieved using Andronix as another Source of Images, and later removed at final due to potential issues
    - Fixed Naming Schemes
- Raiden Shogun (Unreleased) (Series: Genshin Impact)
    - Removing the Updaters/Uninstallers/Installers as they prove to destroy user's data during the process. Which is irreversible.
    - Code Rework, implementing `function` as it's modules to efficiently achieve Semi-monolithic status. (`Relies on run.sh (unfinished/abandoned) to run`)
    - Adding Option to Run a Userspace Tarball via a customised script, while not allowing `run_proot_cmd` temporarily due to a potential issues
    - Recleaning/Revising the mechanism
    - Adding Feature to Modify certain cached variables
- Akane (Kurokawa Akane) (Series: Oshi No Ko/My Star)
    - Removed the Userspace Implementation
    - Added Verbose Announcement, this will make bug fixing to be fixed in a short period of time. (If the User explains in detail)
    - Uses `proot-distro` to remove arch-based distros, due to its permission set to read only in `${ARCH_SYSDIR_ROOT}/etc/*`

    ### WARNING!

  This part is uncertain that such features would come bundled in.


- Senko-san (Series: The Helpful Fox, Senko-san!)
    - Implementing Majorly Monolithic Status, but still relies on proot-distro as a backend
    - Perma-configure should be Available in Public Beta
    - The Script should be Able to know if a certain distros are installed
    - [Testing] New format `.sh` library to take Distros, which means experimenting installing Debian-based only tar packs with no help from `proot-distro` , and not including arch based distros due to its nature of read-only `/etc/`
    - Backup and Restore Feature will be partly operational
    - [Testing] Sysprep Feature will be coming soon
- Stelle (Series:Honkai: Star Rail)
   - Achieve .deb status to termux (and hopefully to be added in the repo)
   - Ending Public Beta 2, and transitioning to Beta 3, in which the script would no longer have to rely on proot-distro
   - Move Project to the main [Proot-Distro-TUI](https://github.com/SUFandom/proot-distro-tui) to declare it Public Stable and name it: March 7th
