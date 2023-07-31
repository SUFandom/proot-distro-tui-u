#!/bin/bash
# 2.4-unstable-akane
# This really took some time
# 

# early function Library
function msg () {
    # Standard
    echo "$1"
}
function msg-fl () {
    # Same as standard but accepts - string but as one liner only , like -ne
    echo $1 "$2"
}

function barrier () {
    msg " "
    msg "=============================================="
    msg " "
}

function datetime () {
    # Just VERBOSE stuff
    MONTH_DATE_YEAR=$(date +%m-%d-%y)
    TIMECOUNT=$(date +%T)
    msg "$MONTH_DATE_YEAR $TIMECOUNT"
}


# Variable loading
VERSION_ID="2.4-unstable-akane"
MAIN="PRoot-distro-tui-u"

# COLORS!
# setaf - foreground
# setab - background
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
RESET=$(tput sgr0)

# TXT
BOLD=$(tput bold)
ULINE=$(tput smul)

# CURSORS
CIVIS=$(tput civis)
CNORM=$(tput cnorm)

# Changeable Variable

TIMER=0
P_SH="/data/data/com.termux/files/usr/etc/proot-distro"
P_DSTS="/data/data/com.termux/files/usr/var/lib/proot-distro"
P_DSTS_INST="/data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs"


# Checker
clear
barrier
msg "       Checking Packages"
barrier 
package=("dialog" "tput" "proot" "proot-distro" "fakeroot")
for pkg in "${package[@]}" ; do 
    msg "[  ${CYAN}Checking${RESET}  ] : ${BOLD}$(datetime)${RESET}${CNORM} : Checking if the package $pkg is Present in your Termux session."
    sleep 1
    path=$(command -v "$pkg" 2>/dev/null)
    if [ -n "$path" ]; then 
        msg "[  ${GREEN}${BOLD}PRESENT${RESET}${CNROM}  ] : ${BOLD}$(datetime)${RESET}${CNORM} : Package $pkg exists, Located at $path"
    else 
        msg "[  ${RED}${BOLD}NOT INSTALLED${RESET}${CNORM}  ] : ${BOLD}$(datetime)${RESET}${CNORM} : Package $pkg does not exist, please install it via apt..."
        barrier
        sleep 3
        exit 1
    fi 
done 
clear 

## PREPARATION

function infobox () {
    dialog --backtitle "$1" --title "$2" --infobox "$3" 0 0 
}

function msgbox () {
    dialog --backtitle "$1" --title "$2" --msgbox "$3"  0 0
}

function yesno () {
    dialog --backtitle "$1" --title "$2" --yes-label "$3" --no-label "$4" --yesno "$5" 0 0
}

function gen () {
    touch .i
}

function check_info_dev () {
    # Check your device info
    msg "\nName of the user: $(whoami)\n"
    msg "Device Machine Architecture: $(uname -m)\n"
    msg "Device Operating System: $(uname -o)\n"
}


function errorlog () {
    if [ "$4" == "-nc" ]; then 
        msg " "
    else 
        clear
    fi  
    barrier
    msg "${RED}ERROR${CNORM}${RESET}"
    barrier 
    msg "[${BOLD}${RED}ERROR${CNORM}${RESET}] : ${BOLD}$(datetime)${CNORM}${RESET} : ERROR: $1 : Failed Task Job: $2 : Reverting to Menu in $3 seconds..."
    msg "[${CYAN}NOTE${CNORM}${RESET}] : ${BOLD}$(datetime)${CNORM}${RESET} : Please Report the issue please"
    barrier 
    VR="$2"
    sleep $3
    menu "$VR"
}

function distrocheck () {
    # This function is not implemented, maybe in senko rel
    ARC=$1
    if [ -d $P_DSTS/$ARC ]; then
        msg "\n$ARC INSTALLED AND PRESENT IN:\n\n$ARC"
    else 
        msg "Not installed"
    fi
}

function proot_call () {
    clear
    msg "Pay Attention to the Terminal since this process is verbose"
    msg "Starting in 5 Seconds"
    sleep 5
    if [ "$1" == "--install" ]; then 
        barrier
        msg "INSTALLING $2"
        barrier 
        msg " "
        msg "Installing Specified Distro: ${CYAN}${BOLD}$2${RESET}${CNORM}"
        barrier 
        msg "Calling PRoot-distro"
        barrier 
        msg "LOG: "
        msg " "
        sleep 3
        msg "[${YELLOW}${BOLD}PRoot-Distro Call Function${RESET}${CNORM}] : ${BOLD}$(datetime)${CNORM}${RESET} :[ ${BOLD}STATUS${CNORM}${RESET} ] : Calling PRoot-distro to install the following $2"
        msg "[${YELLOW}${BOLD}PRoot-Distro Call Function${RESET}${CNORM}] : ${BOLD}$(datetime)${CNORM}${RESET} : [ ${BOLD}VERBOSE${CNORM}${RESET} ] : proot-distro install $2 -> SEND"
        barrier
        proot-distro install $2
        FETCH=$?
        if [ $FETCH -eq 0 ]; then 
            barrier 
            msg "[${YELLOW}${BOLD}PRoot-Distro Call Function${RESET}${CNORM}] : ${BOLD}$(datetime)${CNORM}${RESET} : [ ${BOLD}${GREEN}INSPECT${CNORM}${RESET} ] : Checking Distro Existence in the system..."
            sleep 2
                 if [ -d $P_DSTS_INST/"$2" ]; then 
                    msg "[${YELLOW}${BOLD}PRoot-Distro Call Function${RESET}${CNORM}] : ${BOLD}$(datetime)${CNORM}${RESET} : [ ${BOLD}${GREEN}DONE${CNORM}${RESET} ] : $2 Found in: $P_DSTS_INST/$2"
                    msg "[${YELLOW}${BOLD}PRoot-Distro Call Function${RESET}${CNORM}] : ${BOLD}$(datetime)${CNORM}${RESET} : [ ${BOLD}VERBOSE${CNORM}${RESET} ] : Ending Process..."
                    barrier 
                    read -n 1 -t 100 -p "PRESS ANY KEY TO END FUNCTION" RPS
                        if [[ -n $RPS ]]; then 
                            menu 
                        else 
                            menu 
                        fi 
                else   
                    msg "[${YELLOW}${BOLD}PRoot-Distro Call Function${RESET}${CNORM}] : ${BOLD}$(datetime)${CNORM}${RESET} : [ ${BOLD}${RED}ERROR${CNORM}${RESET} ] : Could Not find Distro that you want to install..."
                    msg "[${YELLOW}${BOLD}PRoot-Distro Call Function${RESET}${CNORM}] : ${BOLD}$(datetime)${CNORM}${RESET} : [ ${BOLD}VERBOSE${CNORM}${RESET} ] : Ending Process..."
                    sleep 3
                    read -n 1 -t 100 -p "PRESS ANY KEY TO END FUNCTION" RPS
                    errorlog "ins_ $2 _dir" "Install $2 failed due to Failure to find the directory" 5 -nc 
                fi
        else 
            msg "[${YELLOW}${BOLD}PRoot-Distro Call Function${RESET}${CNORM}] : ${BOLD}$(datetime)${CNORM}${RESET} : [ ${BOLD}${RED}ERROR${CNORM}${RESET} ] : PRoot-distro Reported an ERROR, Probably an issue during fetching of $2, Please Restart your termux."
            msg "[${YELLOW}${BOLD}PRoot-Distro Call Function${RESET}${CNORM}] : ${BOLD}$(datetime)${CNORM}${RESET} : [ ${BOLD}VERBOSE${CNORM}${RESET} ] : Ending Process..."
            sleep 3
            read -n 1 -t 100 -p "PRESS ANY KEY TO END FUNCTION" RPS
            errorlog "ins_ $2 _dir" "Install $2 failed due to Issues at import or Internet Connection" 5 -nc
        fi 
    fi 
    if [ "$1" == "--run" ]; then 
        barrier
        msg "RUNNING $2"
        barrier 
        msg " "
        msg "Running Specified Distro: ${CYAN}${BOLD}$2${RESET}${CNORM}"
        barrier 
        msg "Calling PRoot-distro"
        barrier 
        msg "LOG: "
        msg " "
        sleep 3
        msg "[${YELLOW}${BOLD}PRoot-Distro Call Function${RESET}${CNORM}] : ${BOLD}$(datetime)${CNORM}${RESET} : [ ${BOLD}STATUS${CNORM}${RESET} ] : Calling PRoot-distro to run the following $2"
        msg "[${YELLOW}${BOLD}PRoot-Distro Call Function${RESET}${CNORM}] : ${BOLD}$(datetime)${CNORM}${RESET} : [ ${BOLD}VERBOSE${CNORM}${RESET} ] : proot-distro login $2 $3 -> SEND"
        barrier
        proot-distro login $2 $3
        FETCH=$?
            if [ $FETCH -eq "0" ]; then 
                msg "[${YELLOW}${BOLD}PRoot-Distro Call Function${RESET}${CNORM}] : ${BOLD}$(datetime)${CNORM}${RESET} : [ ${BOLD}STATUS${CNORM}${RESET} ] : Exit Detected..."
                msg "[${YELLOW}${BOLD}PRoot-Distro Call Function${RESET}${CNORM}] : ${BOLD}$(datetime)${CNORM}${RESET} : [ ${BOLD}VERBOSE${CNORM}${RESET} ] : Exiting Process"
                barrier
                sleep 5
                menu 
            else 
                msg "[${YELLOW}${BOLD}PRoot-Distro Call Function${RESET}${CNORM}] : ${BOLD}$(datetime)${CNORM}${RESET} : [ ${BOLD}${RED}ERROR${CNORM}${RESET} ] : PRoot-distro Reported an ERROR, Probably an issue during fetching of $2 or $3, Please refer to Official Termux Documentations, or unless you are using arch based distro which it usually set exit as 1 by logging out"
                msg "[${YELLOW}${BOLD}PRoot-Distro Call Function${RESET}${CNORM}] : ${BOLD}$(datetime)${CNORM}${RESET} : [ ${BOLD}VERBOSE${CNORM}${RESET} ] : Ending Process..."
                sleep 3
                read -n 1 -t 100 -p "PRESS ANY KEY TO END FUNCTION" RPS
                errorlog "str_$2 _dir" "Logging in to $2 failed due to Issues at Launch, potentially a $3 EOR" 5 -nc
            fi
    fi 
    if [ "$1" == "--remove" ]; then 
        barrier 
        msg "PRoot-distro Cleaner"
        barrier 
        msg "Preparing to Remove..."
        msg "[${YELLOW}${BOLD}PRoot-Distro Call Function${RESET}${CNORM}] : ${BOLD}$(datetime)${CNORM}${RESET} : [ ${BOLD}STATUS${CNORM}${RESET} ] : Preparing to remove: $2, from $P_DSTS/$2"
        msg "[${YELLOW}${BOLD}PRoot-Distro Ensure Function${RESET}${CNORM}] : ${BOLD}$(datetime)${CNORM}${RESET} : [ ${BOLD}CHECK${CNORM}${RESET} ] : Checking the string operation request..."
        # FIX: Archlinux tends to ignore rm requests, so the solution is to force remove it to proot-distro
        if [ "$2" == "archlinux" ] || [ "$2" == "manjaro-aarch64" ] ; then
            msg "[${RED}${BOLD}PRoot-Distro REDIR${RESET}${CNORM}] : ${BOLD}$(datetime)${CNORM}${RESET} : [ ${BOLD}FALLBACK${CNORM}${RESET} ] :  $2 Detected to be removed. Fallback to request proot-distro to remove files associated with $2..."
            msg "[${YELLOW}${BOLD}PRoot-Distro Call Function${CNORM}${RESET}]: ${BOLD}$(datetime)${CNORM}${RESET} : [ ${BOLD}MESSAGE${CNORM}${RESET} ] : Some Distros' content are tend to be stuck at read-only, this mitigation helps completely remove the distro"
            sleep 5
            barrier 
            proot-distro remove $2
            # This area checks if it still exists...
                if [ ! -d "$P_DSTS_INST/$2" ]; then 
                    msg "[${YELLOW}${BOLD}PRoot-Distro Call Function${RESET}${CNORM}] : ${BOLD}$(datetime)${CNORM}${RESET} : [ ${GREEN}${BOLD}COMPLETE${CNORM}${RESET} ] : Distro $2 Removed..."
                    msg "[${YELLOW}${BOLD}PRoot-Distro Call Function${RESET}${CNORM}] : ${BOLD}$(datetime)${CNORM}${RESET} : [ ${BOLD}STATUS${CNORM}${RESET} ] : Exiting Process"
                    sleep 3
                    read -n 1 -t 100 -p "PRESS ANY KEY TO END FUNCTION" RPS
                    menu 
                else 
                    msg "[${GREEN}${BOLD}PRoot-Distro Call Function${RESET}${CNORM}] : ${BOLD}$(datetime)${CNORM}${RESET} : [ ${RED}${BOLD}ERROR${RESET}${CNORM} ] : PRoot-distro Failed to delete $2, please restart termux and try again, or please forcefully clear all data, if strictly necessary..."
                    read -n 1 -t 100 -p "PRESS ANY KEY TO END FUNCTION" RPS
                    errorlog "rm_$2 m2" "$(datetime) : Removing $2 from $P_DSTS_INST with the call failed, there is still a reminant of $2 in the directory..." 5 -nc
                fi
        fi
        msg "[${YELLOW}${BOLD}PRoot-Distro Call Function${RESET}${CNORM}] : ${BOLD}$(datetime)${CNORM}${RESET} : [ ${BOLD}VERBOSE${CNORM}${RESET} ] : rm -rfv $P_DSTS/$2 -> SEND"
        sleep 2
        rm -rfv ${P_DSTS_INST:?}/$2
        if [ ! -d "$P_DSTS_INST/$2" ]; then 
            msg "[${YELLOW}${BOLD}PRoot-Distro Call Function${RESET}${CNORM}] : ${BOLD}$(datetime)${CNORM}${RESET} : [ ${GREEN}${BOLD}COMPLETE${CNORM}${RESET} ] : Distro $2 Removed..."
            msg "[${YELLOW}${BOLD}PRoot-Distro Call Function${RESET}${CNORM}] : ${BOLD}$(datetime)${CNORM}${RESET} : [ ${BOLD}STATUS${CNORM}${RESET} ] : Exiting Process"
            read -n 1 -t 100 -p "PRESS ANY KEY TO END FUNCTION" RPS
            menu 
        else 
            msg "[${YELLOW}${BOLD}PRoot-Distro Call Function${RESET}${CNORM}] : ${BOLD}$(datetime)${CNORM}${RESET} : [ ${RED}${BOLD}ERROR${CNORM}${RESET} ] : Could not Remove the distro, Permission Error to execute..."
            msg "[${YELLOW}${BOLD}PRoot-Distro Call Function${RESET}${CNORM}] : ${BOLD}$(datetime)${CNORM}${RESET} : [ ${BOLD}MSG${CNORM}${RESET} ] : PLEASE MAKE SURE THAT PERMISSIONS ARE SET TO r+w"
            sleep 3
            read -n 1 -t 100 -p "PRESS ANY KEY TO END FUNCTION" RPS
            errorlog "rm_ $2 _dir" "Removing $2 from $P_DSTS_INST Failed, Probably Permission Issues..." 5 -nc
        fi 
    fi 
}




# The Whole script's actions are here
# Yeah you heard me

function welcome () {
    infobox "$MAIN - $VERSION_ID" "Welcome" "Welcome $(whoami)! \n$MAIN - $VERSION_ID"
    sleep 3
    license_agreement
}

function license_agreement () {
    if [ -e .i ]; then 
            msg "Skip!"
            menu
        else 
            yesno "USER LICENSE AGREEMENT - USER END AREA - $MAIN - $VERSION_ID" "License Agreement (User End)" "Agree" "Exit" "$(cat assets/LC.txt)" 0 0
            ARM=$?
            case $ARM in 
                0)
                    gen
                    menu
                    ;;
                1)
                    clear 
                    exit 
                    ;;
            esac 
    fi 
}

function menu () {
    ERROR_FETCH="$1"
    if [ -z "${ERROR_FETCH}"  ]; then
        VAR="\nProcess are Okay, No Error"
    else 
        VAR="\n$ERROR_FETCH"
    fi 
    MENU=$(dialog \
            --backtitle "Main Menu - $MAIN - $VERSION_ID" \
            --title "Main Menu" \
            --menu "THIS WARNING SHOULDN'T BE HERE BUT, SINCE THERE'S PEOPLE WHO CANT UNDERSTAND CHROOT AND PROOT\nREAD sylirre's (Termux Core Dev) STATEMENT:\nDon't be confused by terms Chroot and Proot. They are entirely different things.\nChroot, if we talk about Linux utility/feature and not proot or equivalent, always run directly on hardware. It is not virtualizer or emulator but a Linux function for switching the root file system. The chroot is essential feature of Linux that is being used by all standard Linux distribution installations with initramfs.\nIt is being used internally by switch_root or pivot_root utility when system changes its root file system from initramfs to disk partition.\n That said, a typical 'Ubuntu desktop on PC' will always run in chroot. It's funny, isn't it?,\n\nChoose what actions do you wanna perform?\n\nSYSTEM INFO (PROVIDED BY check_info_dev): $(check_info_dev)\nWarnings: $VAR" 0 0 0 \
            "Distro Manager" "Manage your Distro, Obviously"\
            "Perma-configure" "Coming soon" \
            "Configure" "This is an alternative to Perma-configure Temporarily" \
            "Help and About" "Says in the title" \
            2>&1 >/dev/tty)
    ARR=$? 
    case $ARR in 
        1)
            clear
            exit 
            ;;
    esac 
    case $MENU in 
        "Distro Manager")
            distro_manager 
            ;;
        "Perma-configure")
            msgbox "Sorry - $MAIN - $VERSION_ID" "Coming Soon" "This feature is temporarily unavailable, Please wait while i cry because i cant seem to import valuables from a file to a session script"
            menu 
            ;;
        "Configure")
            configure 
            ;;
        "Help and About")
            help_and_about
            ;;
    esac

}

function distro_manager () {
    MENU=$(dialog \
            --backtitle "Distro Manager - $MAIN - $VERSION_ID" \
            --title "Distro Manager" \
            --menu "Pick an Option, whether to Install, Run or Remove" 0 0 0 \
            "Install" "Install Distros" \
            "Run" "Run Distros" \
            "Uninstall" "Uninstall Distros" \
            "Backup" "Backup Distros" \
            "Restore" "Restore Distros" \
            2>&1 >/dev/tty)
    ARM=$?
    case $ARM in
        1)
            menu 
            ;;
    esac 
    case $MENU in 
        "Install")
            case $(uname -m) in
                x86_64)
                    install_amd64
                    ;;
                i686)
                    install_i686
                    ;;
                armv7a|armv7l|armv8l)
                    install_arm32
                    ;;
                aarch64)
                    install_arm64
                    ;;
                *)
                    errorlog "noarch" "Identifying the Architecture of the device could not reach the ultimatium. CLI Software 'uname' gave us an unsupported Architecture: $(uname -m) which is not supported on termux." 5
                    ;;
            esac 
            ;;
        "Run")
            case $(uname -m) in 
                x86_64)
                    run_amd64
                    ;;
                i686)
                    run_i686
                    ;;
                armv7a|armv7l|armv8l)
                    run_arm32
                    ;;
                aarch64)
                    run_arm64
                    ;;
                *)
                    errorlog "noarch" "Identifying the Architecture of the device could not reach the ultimatium. CLI Software 'uname' gave us an unsupported Architecture: $(uname -m) which is not supported on termux." 5
                    ;;
            esac 
            ;;
        "Uninstall")
            case $(uname -m) in 
                x86_64)
                    remove_amd64
                    ;;
                i686)
                    remove_i686
                    ;;
                armv7a|armv7l|armv8l)
                    remove_arm32
                    ;;
                aarch64)
                    remove_arm64
                    ;;
                *)
                    errorlog "noarch" "Identifying the Architecture of the device could not reach the ultimatium. CLI Software 'uname' gave us an unsupported Architecture: $(uname -m) which is not supported on termux." 5
                    ;;
            esac 
            ;;
        "Backup")
            backup_tar
            ;;
        "Restore")
            restore_tar
            ;;
    esac
}

function install_amd64 () {
    # Install page (1)
    menu=$(dialog \
            --backtitle "Install Distro Repositories" \
            --title "Choose a Supported Distro" \
            --menu "Choose architectures that are supported onboard:\nRemember to choose right" 0 0 0 \
            "Alpine Linux" "The Bleeding Edge of Distro" \
            "Debian Linux" "A rock stable distro" \
            "Fedora Linux" "Perry the Linux Distro!" \
            "OpenSUSE Linux" "Gecko Linux" \
            "Pardus Linux" "Turkish Linux" \
            "Ubuntu Linux" "Snap sucks" \
            "Void Linux" "Void" \
            2>&1 >/dev/tty)
    AA=$?
    case $AA in 
        1)
            distro_manager
            ;;
    esac 
    case $menu in 
        "Alpine Linux")
            yesno "Alpine Linux" "Alpine Linux" "Yes, Install" "Back" "Do you want to install Alpine Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/ALPINE.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install alpine
                    ;;
                1)
                    install_amd64
                    ;;
            esac 
            ;;
        "Debian Linux")
            yesno "Debian Linux" "Debian Linux" "Yes, Install" "Back" "Do you want to install Debian Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/DEBIAN.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install debian
                    ;;
                1)
                    install_amd64
                    ;;
            esac 
            ;;
        "Fedora Linux")
            yesno "Fedora Linux" "Fedora Linux" "Yes, Install" "Back" "Do you want to install Fedora Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/FEDORA.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install fedora
                    ;;
                1)
                    install_amd64
                    ;;
            esac 
            ;;
        "OpenSUSE Linux")
            yesno "OPenSUSE Linux" "OpenSUSE Linux" "Yes, Install" "Back" "Do you want to install OpenSUSE Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/OPENSUSE.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install opensuse
                    ;;
                1)
                    install_amd64
                    ;;
            esac 
            ;;
        "Pardus Linux")
            yesno "Pardus Linux" "Pardus Linux" "Yes, Install" "Back" "Do you want to install Pardus Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/PARDUS.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install pardus
                    ;;
                1)
                    install_amd64
                    ;;
            esac 
            ;;
        "Ubuntu Linux")
            yesno "Ubuntu Linux" "Ubuntu Linux" "Yes, Install" "Back" "Do you want to install Ubuntu Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/UBUNTU.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install ubuntu
                    ;;
                1)
                    install_amd64
                    ;;
            esac 
            ;;
        "Void Linux")
            yesno "Void Linux" "Void Linux" "Yes, Install" "Back" "Do you want to install Void Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/VOID.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install void
                    ;;
                1)
                    install_amd64
                    ;;
            esac 
            ;;
    esac
}

function install_i686 () {
    # Install page (2)
    menu=$(dialog \
            --backtitle "Install Distro Repositories" \
            --title "Choose a Supported Distro" \
            --menu "Choose architectures that are supported onboard:\nRemember to choose right" 0 0 0 \
            "Alpine Linux" "The Bleeding Edge of Distro" \
            "Debian Linux" "A rock stable distro" \
            "OpenSUSE Linux" "Gecko Linux" \
            "Pardus Linux" "Turkish Linux" \
            "Ubuntu Linux" "Snap sucks" \
            "Void Linux" "Void" \
            2>&1 >/dev/tty)
    AA=$?
    case $AA in 
        1)
            distro_manager
            ;;
    esac 
    case $menu in 
        "Alpine Linux")
            yesno "Alpine Linux" "Alpine Linux" "Yes, Install" "Back" "Do you want to install Alpine Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/ALPINE.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install alpine
                    ;;
                1)
                    install_i686
                    ;;
            esac 
            ;;
        "Debian Linux")
            yesno "Debian Linux" "Debian Linux" "Yes, Install" "Back" "Do you want to install Debian Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/DEBIAN.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install debian
                    ;;
                1)
                    install_i686 
                    ;;
            esac 
            ;;
        "OpenSUSE Linux")
            yesno "OPenSUSE Linux" "OpenSUSE Linux" "Yes, Install" "Back" "Do you want to install OpenSUSE Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/OPENSUSE.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install opensuse
                    ;;
                1)
                    install_i686
                    ;;
            esac 
            ;;
        "Pardus Linux")
            yesno "Pardus Linux" "Pardus Linux" "Yes, Install" "Back" "Do you want to install Pardus Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/PARDUS.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install pardus
                    ;;
                1)
                    install_i686 
                    ;;
            esac 
            ;;
        "Ubuntu Linux")
            yesno "Ubuntu Linux" "Ubuntu Linux" "Yes, Install" "Back" "Do you want to install Ubuntu Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/UBUNTU.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install ubuntu
                    ;;
                1)
                    install_i686 
                    ;;
            esac 
            ;;
        "Void Linux")
            yesno "Void Linux" "Void Linux" "Yes, Install" "Back" "Do you want to install Void Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/VOID.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install void 
                    ;;
                1)
                    install_i686 
                    ;;
            esac 
            ;;
    esac
}

function install_arm32 () {
    # Install page (3)
    menu=$(dialog \
            --backtitle "Install Distro Repositories" \
            --title "Choose a Supported Distro" \
            --menu "Choose architectures that are supported onboard:\nRemember to choose right" 0 0 0 \
            "Alpine Linux" "The Bleeding Edge of Distro" \
            "Arch Linux" "I Use Arch BTW moment" \
            "Debian Linux" "A rock stable distro" \
            "OpenSUSE Linux" "Gecko Linux" \
            "Pardus Linux" "Turkish Linux" \
            "Ubuntu Linux" "Snap sucks" \
            "Void Linux" "Void" \
            2>&1 >/dev/tty)
    AA=$?
    case $AA in 
        1)
            distro_manager
            ;;
    esac 
    case $menu in 
        "Alpine Linux")
            yesno "Alpine Linux" "Alpine Linux" "Yes, Install" "Back" "Do you want to install Alpine Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/ALPINE.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install alpine
                    ;;
                1)
                    install_arm32 
                    ;;
            esac 
            ;;
        "Arch Linux")
            yesno "Arch Linux" "Arch Linux" "Yes, Install" "Back" "Do you want to install Arch Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/ARCH.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install archlinux
                    ;;
                1)
                    install_arm32
                    ;;
            esac 
            ;;
        "Debian Linux")
            yesno "Debian Linux" "Debian Linux" "Yes, Install" "Back" "Do you want to install Debian Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/DEBIAN.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install debian
                    ;;
                1)
                    install_arm32 
                    ;;
            esac 
            ;;
        "OpenSUSE Linux")
            yesno "OpenSUSE Linux" "OpenSUSE Linux" "Yes, Install" "Back" "Do you want to install OpenSUSE Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/OPENSUSE.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install opensuse
                    ;;
                1)
                    install_arm32
                    ;;
            esac 
            ;;
        "Pardus Linux")
            yesno "Pardus Linux" "Pardus Linux" "Yes, Install" "Back" "Do you want to install Pardus Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/PARDUS.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install pardus
                    ;;
                1)
                    install_arm32 
                    ;;
            esac 
            ;;
        "Ubuntu Linux")
            yesno "Ubuntu Linux" "Ubuntu Linux" "Yes, Install" "Back" "Do you want to install Ubuntu Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/UBUNTU.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install ubuntu
                    ;;
                1)
                    install_arm32
                    ;;
            esac 
            ;;
        "Void Linux")
            yesno "Void Linux" "Void Linux" "Yes, Install" "Back" "Do you want to install Void Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/VOID.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install void 
                    ;;
                1)
                    install_arm32
                    ;;
            esac 
            ;;
    esac
}

function install_arm64 () {
    # Install Page
    menu=$(dialog \
            --backtitle "Install Distro Repositories" \
            --title "Choose a Supported Distro" \
            --menu "Choose Distros that are supported onboard:\nRemember to choose right" 0 0 0 \
            "Alpine Linux" "The Bleeding Edge of Distro" \
            "Arch Linux" "I use Arch BTW" \
            "Debian Linux" "A rock stable Distro" \
            "Fedora Linux" "Perry the Linux Distro!" \
            "Manjaro Linux" "Somehow, why everyone hates this guy?" \
            "OpenSUSE Linux" "Gecko Linux" \
            "Pardus Linux" "Turkish Linux" \
            "Ubuntu Linux" "Snap sucks" \
            "Void Linux" "Void" \
            2>&1 >/dev/tty)
    AA=$?
    case $AA in 
        1)
            distro_manager
            ;;
    esac 
    case $menu in
        "Alpine Linux")
            yesno "Alpine Linux" "Alpine Linux" "Yes, Install" "Back" "Do you want to install Alpine Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/ALPINE.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install alpine
                    ;;
                1)
                    install_arm64
                    ;;
            esac 
            ;;
        "Arch Linux")
            yesno "Arch Linux" "Arch Linux" "Yes, Install" "Back" "Do you want to install Arch Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/ARCH.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install archlinux
                    ;;
                1)
                    install_arm64
                    ;;
            esac 
            ;;
        "Debian Linux")
            yesno "Debian Linux" "Debian Linux" "Yes, Install" "Back" "Do you want to install Debian Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/DEBIAN.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install debian
                    ;;
                1)
                    install_arm64 
                    ;;
            esac 
            ;;
        "Manjaro Linux")
            yesno "Manjaro AArch64" "Manjaro" "Yes, Install" "Back" "Do you want to install Manjaro Linux?\n\nIf its already Installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/MANJARO.txt)"
            FETCH=$?
            case $FETCH in
                0)
                    proot_call --install manjaro-aarch64
                    ;;
                1)
                    install_arm64
                    ;;
            esac
            ;;
        "OpenSUSE Linux")
            yesno "OpenSUSE Linux" "OpenSUSE Linux" "Yes, Install" "Back" "Do you want to install OpenSUSE Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/OPENSUSE.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install opensuse
                    ;;
                1)
                    install_arm64
                    ;;
            esac 
            ;;
        "Pardus Linux")
            yesno "Pardus Linux" "Pardus Linux" "Yes, Install" "Back" "Do you want to install Pardus Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/PARDUS.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install pardus
                    ;;
                1)
                    install_arm64
                    ;;
            esac 
            ;;
        "Ubuntu Linux")
            yesno "Ubuntu Linux" "Ubuntu Linux" "Yes, Install" "Back" "Do you want to install Ubuntu Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/UBUNTU.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install ubuntu
                    ;;
                1)
                    install_arm64
                    ;;
            esac 
            ;;
        "Void Linux")
            yesno "Void Linux" "Void Linux" "Yes, Install" "Back" "Do you want to install Void Linux?\n\nIf its installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/VOID.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --install void 
                    ;;
                1)
                    install_arm64
                    ;;
            esac 
            ;;
    esac
}

# Install Ends
# Run area

function run_amd64 () {
    # Run page
    menu=$(dialog \
            --backtitle "Run Distro Repositories" \
            --title "Choose a Supported Distro" \
            --menu "Choose distros that are supported onboard:\nRemember to choose right" 0 0 0 \
            "Alpine Linux" "The Bleeding Edge of Distro" \
            "Debian Linux" "A rock stable distro" \
            "Fedora Linux" "Perry the Linux Distro!" \
            "OpenSUSE Linux" "Gecko Linux" \
            "Pardus Linux" "Turkish Linux" \
            "Ubuntu Linux" "Snap sucks" \
            "Void Linux" "Void" \
            2>&1 >/dev/tty)
    AA=$?
    case $AA in 
        1)
            distro_manager
            ;;
    esac 
    case $menu in 
        "Alpine Linux")
            yesno "Alpine Linux" "Alpine Linux" "Run" "Back" "Do you want to run Alpine Linux?\n\nIf it's not installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/ALPINE.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run alpine
                    ;;
                1)
                    run_amd64
                    ;;
            esac 
            ;;
        "Debian Linux")
            yesno "Debian Linux" "Debian Linux" "Run" "Back" "Do you want to run Debian Linux?\n\nIf its not installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/DEBIAN.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run debian
                    ;;
                1)
                    run_amd64
                    ;;
            esac 
            ;;
        "Fedora Linux")
            yesno "Fedora Linux" "Fedora Linux" "Run" "Back" "Do you want to run Fedora Linux?\n\nIf its not installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/FEDORA.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run fedora
                    ;;
                1)
                    run_amd64
                    ;;
            esac 
            ;;
        "OpenSUSE Linux")
            yesno "OPenSUSE Linux" "OpenSUSE Linux" "Run" "Back" "Do you want to run OpenSUSE Linux?\n\nIf its not installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/OPENSUSE.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run opensuse
                    ;;
                1)
                    run_amd64
                    ;;
            esac 
            ;;
        "Pardus Linux")
            yesno "Pardus Linux" "Pardus Linux" "Run" "Back" "Do you want to run Pardus Linux?\n\nIf its not installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/PARDUS.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run pardus
                    ;;
                1)
                    run_amd64
                    ;;
            esac 
            ;;
        "Ubuntu Linux")
            yesno "Ubuntu Linux" "Ubuntu Linux" "Run" "Back" "Do you want to run Ubuntu Linux?\n\nIf its not installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/UBUNTU.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run ubuntu
                    ;;
                1)
                    run_amd64
                    ;;
            esac 
            ;;
        "Void Linux")
            yesno "Void Linux" "Void Linux" "Run" "Back" "Do you want to run Void Linux?\n\nIf its not installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/VOID.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run void
                    ;;
                1)
                    run_amd64
                    ;;
            esac 
            ;;
    esac
}

function run_i686 () {
    # Run page
    menu=$(dialog \
            --backtitle "Run Distro Repositories" \
            --title "Choose a Supported Distro" \
            --menu "Choose architectures that are supported onboard:\nRemember to choose right" 0 0 0 \
            "Alpine Linux" "The Bleeding Edge of Distro" \
            "Debian Linux" "A rock stable distro" \
            "OpenSUSE Linux" "Gecko Linux" \
            "Pardus Linux" "Turkish Linux" \
            "Ubuntu Linux" "Snap sucks" \
            "Void Linux" "Void" \
            2>&1 >/dev/tty)
    AA=$?
    case $AA in 
        1)
            distro_manager
            ;;
    esac 
    case $menu in 
        "Alpine Linux")
            yesno "Alpine Linux" "Alpine Linux" "Run" "Back" "Do you want to run Alpine Linux?\n\nIf it's not installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/ALPINE.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run alpine
                    ;;
                1)
                    run_i686
                    ;;
            esac 
            ;;
        "Debian Linux")
            yesno "Debian Linux" "Debian Linux" "Run" "Back" "Do you want to run Debian Linux?\n\nIf its not installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/DEBIAN.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run debian
                    ;;
                1)
                    run_i686 
                    ;;
            esac 
            ;;
        "OpenSUSE Linux")
            yesno "OpenSUSE Linux" "OpenSUSE Linux" "Run" "Back" "Do you want to Run OpenSUSE Linux?\n\nIf its not installed, then please use the 'Run Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/OPENSUSE.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run opensuse
                    ;;
                1)
                    run_i686
                    ;;
            esac 
            ;;
        "Pardus Linux")
            yesno "Pardus Linux" "Pardus Linux" "Run" "Back" "Do you want to Run Pardus Linux?\n\nIf its not installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/PARDUS.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run pardus
                    ;;
                1)
                    run_i686 
                    ;;
            esac 
            ;;
        "Ubuntu Linux")
            yesno "Ubuntu Linux" "Ubuntu Linux" "Run" "Back" "Do you want to Run Ubuntu Linux?\n\nIf its not installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/UBUNTU.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run ubuntu
                    ;;
                1)
                    run_i686 
                    ;;
            esac 
            ;;
        "Void Linux")
            yesno "Void Linux" "Void Linux" "Run" "Back" "Do you want to run Void Linux?\n\nIf its not installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/VOID.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run void 
                    ;;
                1)
                    run_i686 
                    ;;
            esac 
            ;;
    esac
}

function run_arm32 () {
    # Run page
    menu=$(dialog \
            --backtitle "Install Distro Repositories" \
            --title "Choose a Supported Distro" \
            --menu "Choose architectures that are supported onboard:\nRemember to choose right" 0 0 0 \
            "Alpine Linux" "The Bleeding Edge of Distro" \
            "Arch Linux" "I Use Arch BTW moment" \
            "Debian Linux" "A rock stable distro" \
            "OpenSUSE Linux" "Gecko Linux" \
            "Pardus Linux" "Turkish Linux" \
            "Ubuntu Linux" "Snap sucks" \
            "Void Linux" "Void" \
            2>&1 >/dev/tty)
    AA=$?
    case $AA in 
        1)
            distro_manager
            ;;
    esac 
    case $menu in 
        "Alpine Linux")
            yesno "Alpine Linux" "Alpine Linux" "Run" "Back" "Do you want to run Alpine Linux?\n\nIf its not installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/ALPINE.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run alpine
                    ;;
                1)
                    run_arm32 
                    ;;
            esac 
            ;;
        "Arch Linux")
            yesno "Arch Linux" "Arch Linux" "Run" "Back" "Do you want to Run Arch Linux?\n\nIf its not installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/ARCH.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run archlinux
                    ;;
                1)
                    run_arm32
                    ;;
            esac 
            ;;
        "Debian Linux")
            yesno "Debian Linux" "Debian Linux" "Run" "Back" "Do you want to Run Debian Linux?\n\nIf its not installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/DEBIAN.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run debian
                    ;;
                1)
                    run_arm32 
                    ;;
            esac 
            ;;
        "OpenSUSE Linux")
            yesno "OpenSUSE Linux" "OpenSUSE Linux" "Run" "Back" "Do you want to Run OpenSUSE Linux?\n\nIf its not installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/OPENSUSE.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run opensuse
                    ;;
                1)
                    run_arm32
                    ;;
            esac 
            ;;
        "Pardus Linux")
            yesno "Pardus Linux" "Pardus Linux" "Run" "Back" "Do you want to run Pardus Linux?\n\nIf its not installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/PARDUS.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run pardus
                    ;;
                1)
                    run_arm32 
                    ;;
            esac 
            ;;
        "Ubuntu Linux")
            yesno "Ubuntu Linux" "Ubuntu Linux" "Run" "Back" "Do you want to run Ubuntu Linux?\n\nIf its not installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/UBUNTU.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run ubuntu
                    ;;
                1)
                    run_arm32
                    ;;
            esac 
            ;;
        "Void Linux")
            yesno "Void Linux" "Void Linux" "Run" "Back" "Do you want to run Void Linux?\n\nIf its not installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/VOID.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run void 
                    ;;
                1)
                    run_arm32
                    ;;
            esac 
            ;;
    esac
}

function run_arm64 () {
    # Run Page
    menu=$(dialog \
            --backtitle "Install Distro Repositories" \
            --title "Choose a Supported Distro" \
            --menu "Choose Distros that are supported onboard:\nRemember to choose right" 0 0 0 \
            "Alpine Linux" "The Bleeding Edge of Distro" \
            "Arch Linux" "I use Arch BTW" \
            "Debian Linux" "A rock stable Distro" \
            "Fedora Linux" "Perry the Linux Distro!" \
            "Manjaro Linux" "Somehow, why everyone hates this guy?" \
            "OpenSUSE Linux" "Gecko Linux" \
            "Pardus Linux" "Turkish Linux" \
            "Ubuntu Linux" "Snap sucks" \
            "Void Linux" "Void" \
            2>&1 >/dev/tty)
    AA=$?
    case $AA in 
        1)
            distro_manager
            ;;
    esac 
    case $menu in
        "Alpine Linux")
            yesno "Alpine Linux" "Alpine Linux" "Run" "Back" "Do you want to run Alpine Linux?\n\nIf its not installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/ALPINE.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run alpine
                    ;;
                1)
                    run_arm64
                    ;;
            esac 
            ;;
        "Arch Linux")
            yesno "Arch Linux" "Arch Linux" "Run" "Back" "Do you want to run Arch Linux?\n\nIf its not installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/ARCH.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run archlinux
                    ;;
                1)
                    run_arm64
                    ;;
            esac 
            ;;
        "Debian Linux")
            yesno "Debian Linux" "Debian Linux" "Run" "Back" "Do you want to run Debian Linux?\n\nIf its not installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/DEBIAN.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run debian
                    ;;
                1)
                    run_arm64 
                    ;;
            esac 
            ;;
        "Manjaro Linux")
            yesno "Manjaro AArch64" "Manjaro" "Run" "Back" "Do you want to run Manjaro Linux?\n\nIf its already Installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/MANJARO.txt)"
            FETCH=$?
            case $FETCH in
                0)
                    proot_call --run manjaro-aarch64
                    ;;
                1)
                    run_arm64
                    ;;
            esac
            ;;
        "OpenSUSE Linux")
            yesno "OpenSUSE Linux" "OpenSUSE Linux" "Run" "Back" "Do you want to run OpenSUSE Linux?\n\nIf its not installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/OPENSUSE.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run opensuse
                    ;;
                1)
                    run_arm64
                    ;;
            esac 
            ;;
        "Pardus Linux")
            yesno "Pardus Linux" "Pardus Linux" "Run" "Back" "Do you want to run Pardus Linux?\n\nIf its not installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/PARDUS.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run pardus
                    ;;
                1)
                    run_arm64
                    ;;
            esac 
            ;;
        "Ubuntu Linux")
            yesno "Ubuntu Linux" "Ubuntu Linux" "Run" "Back" "Do you want to run Ubuntu Linux?\n\nIf its not installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/UBUNTU.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run ubuntu
                    ;;
                1)
                    run_arm64
                    ;;
            esac 
            ;;
        "Void Linux")
            yesno "Void Linux" "Void Linux" "Run" "Back" "Do you want to install Void Linux?\n\nIf its not installed, then please use the 'Install Distro' area instead\n\nSynopsis: $(cat assets/DISTRO_SYNOPSIS/VOID.txt)"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --run void 
                    ;;
                1)
                    run_arm64
                    ;;
            esac 
            ;;
    esac
}

# Remove area

function remove_amd64 () {
   # Remove page
    menu=$(dialog \
            --backtitle "Delete Distro Repositories" \
            --title "Choose Distros to be deleted" \
            --menu "Choose distros that will be deleted\n\nWARNING!\nDeleting Distros is an irreversible action and YOU ARE AGREEING THAT ANY MESSED UP IS 100% CERTAIN TO BE YOURS" 0 0 0 \
            "Alpine Linux" "The Bleeding Edge of Distro" \
            "Debian Linux" "A rock stable distro" \
            "Fedora Linux" "Perry the Linux Distro!" \
            "OpenSUSE Linux" "Gecko Linux" \
            "Pardus Linux" "Turkish Linux" \
            "Ubuntu Linux" "Snap sucks" \
            "Void Linux" "Void" \
            2>&1 >/dev/tty)
    AA=$?
    case $AA in 
        1)
            distro_manager
            ;;
    esac 
    case $menu in 
        "Alpine Linux")
            yesno "Alpine Linux" "Alpine Linux" "Delete" "Back" "Do you want to Delete Alpine Linux?\n\nANY DATA CANNOT BE RECOVERED AFTER DELETING"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --remove alpine
                    ;;
                1)
                    remove_amd64
                    ;;
            esac 
            ;;
        "Debian Linux")
            yesno "Debian Linux" "Debian Linux" "Delete" "Back" "Do you want to Delete Debian Linux?\n\nANY DATA CANNOT BE RECOVERED AFTER DELETING"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --remove debian
                    ;;
                1)
                    remove_amd64
                    ;;
            esac 
            ;;
        "Fedora Linux")
            yesno "Fedora Linux" "Fedora Linux" "Delete" "Back" "Do you want to Delete Fedora Linux?\n\nANY DATA CANNOT BE RECOVERED AFTER DELETING"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --remove fedora
                    ;;
                1)
                    remove_amd64
                    ;;
            esac 
            ;;
        "OpenSUSE Linux")
            yesno "OpenSUSE Linux" "OpenSUSE Linux" "Delete" "Back" "Do you want to Delete OpenSUSE Linux?\n\nANY DATA CANNOT BE RECOVERED AFTER DELETING"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --remove opensuse
                    ;;
                1)
                    remove_amd64
                    ;;
            esac 
            ;;
        "Pardus Linux")
            yesno "Pardus Linux" "Pardus Linux" "Delete" "Back" "Do you want to Delete Pardus Linux?\n\nANY DATA CANNOT BE RECOVERED AFTER DELETING"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --remove pardus
                    ;;
                1)
                    remove_amd64
                    ;;
            esac 
            ;;
        "Ubuntu Linux")
            yesno "Ubuntu Linux" "Ubuntu Linux" "Delete" "Back" "Do you want to run Ubuntu Linux?\n\nANY DATA CANNOT BE RECOVERED AFTER DELETING"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --remove ubuntu
                    ;;
                1)
                    remove_amd64
                    ;;
            esac 
            ;;
        "Void Linux")
            yesno "Void Linux" "Void Linux" "Delete" "Back" "Do you want to run Void Linux?\n\nANY DATA CANNOT BE RECOVERED AFTER DELETING"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --remove void
                    ;;
                1)
                    remove_amd64
                    ;;
            esac 
            ;;
    esac
}

function remove_arm64 () {
    # Run Page
    menu=$(dialog \
            --backtitle "Remove Installed Distro " \
            --title "Choose a Distro to be Deleted" \
            --menu "Choose Distros that will be Deleted:\nRemember to back up first then delete!" 0 0 0 \
            "Alpine Linux" "The Bleeding Edge of Distro" \
            "Arch Linux" "I use Arch BTW" \
            "Debian Linux" "A rock stable Distro" \
            "Fedora Linux" "Perry the Linux Distro!" \
            "Manjaro Linux" "Somehow, why everyone hates this guy?" \
            "OpenSUSE Linux" "Gecko Linux" \
            "Pardus Linux" "Turkish Linux" \
            "Ubuntu Linux" "Snap sucks" \
            "Void Linux" "Void" \
            2>&1 >/dev/tty)
    AA=$?
    case $AA in 
        1)
            distro_manager
            ;;
    esac 
    case $menu in
        "Alpine Linux")
            yesno "Alpine Linux" "Alpine Linux" "Delete" "Back" "Do you want to remove Alpine Linux?\n\nANY DATA CANNOT BE RECOVERED AFTER DELETING"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --remove alpine
                    ;;
                1)
                    remove_arm64
                    ;;
            esac 
            ;;
        "Arch Linux")
            yesno "Arch Linux" "Arch Linux" "Delete" "Back" "Do you want to remove Arch Linux?\n\nANY DATA CANNOT BE RECOVERED AFTER DELETING"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --remove archlinux
                    ;;
                1)
                    remove_arm64
                    ;;
            esac 
            ;;
        "Debian Linux")
            yesno "Debian Linux" "Debian Linux" "Delete" "Back" "Do you want to remove Debian Linux?\n\nANY DATA CANNOT BE RECOVERED AFTER DELETING"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --remove debian
                    ;;
                1)
                    remove_arm64 
                    ;;
            esac 
            ;;
        "Fedora Linux")
            yesno "Fedora Linux" "Fedora" "Delete" "Back" "Do you want to remove Fedora Linux?\n\nANY DATA CANNOT BE RECOVERED"
            FETCH=$?
            case $FETCH in
                0)
                    proot_call --remove fedora
                    ;;
                1)
                    remove_arm64
                ;;
            esac
            ;;
        "Manjaro Linux")
            yesno "Manjaro AArch64" "Manjaro" "Delete" "Back" "Do you want to remove Manjaro Linux?\n\nANY DATA CANNOT BE RECOVERED AFTER DELETING"
            FETCH=$?
            case $FETCH in
                0)
                    proot_call --remove manjaro-aarch64
                    ;;
                1)
                    remove_arm64
                    ;;
            esac
            ;;
        "OpenSUSE Linux")
            yesno "OpenSUSE Linux" "OpenSUSE Linux" "Delete" "Back" "Do you want to remove OpenSUSE Linux?\n\nANY DATA CANNOT BE RECOVERED AFTER DELETING"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --remove opensuse
                    ;;
                1)
                    remove_arm64
                    ;;
            esac 
            ;;
        "Pardus Linux")
            yesno "Pardus Linux" "Pardus Linux" "Run" "Back" "Do you want to remove Pardus Linux?\n\nANY DATA CANNOT BE RECOVERED AFTER DELETING"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --remove pardus
                    ;;
                1)
                    remove_arm64
                    ;;
            esac 
            ;;
        "Ubuntu Linux")
            yesno "Ubuntu Linux" "Ubuntu Linux" "Run" "Back" "Do you want to remove Ubuntu Linux?\n\nANY DATA CANNOT BE RECOVERED AFTER DELETING"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --remove ubuntu
                    ;;
                1)
                    remove_arm64
                    ;;
            esac 
            ;;
        "Void Linux")
            yesno "Void Linux" "Void Linux" "Remove" "Back" "Do you want to remove Void Linux?\n\nANY DATA CANNOT BE RECOVERED AFTER DELETING"
            FETCH=$?
            case $FETCH in 
                0)
                    proot_call --remove void 
                    ;;
                1)
                    remove_arm64
                    ;;
            esac 
            ;;
    esac
}

function backup_tar () {
    msgbox "Backup" "Coming Soon" "This Feature is coming soon, check the Roadmap.md for more info"
    menu
}

function restore_tar () {
    msgbox "Restore" "Coming soon" "This feature is coming soon, check the Roadmap.md for more info"
    menu 
}

function configure () {
    # Config
    menu=$(dialog \
            --backtitle "Configure[TEMPORARY] - $MAIN - $VERSION_ID" \
            --title "Configure Menu" \
            --menu "This is the Configuration menu\nConfigure cached Configuration Defaults\n\nWARING: IMPROPERLY CONFIGURING CACHED VARIABLES CAN DESTROY TERMUX!\n\n <!> Means DANGER\n\nAlso changing P_SH isnt there yet, maybe soon" 0 0 0 \
            "<!>Change P_DSTS Variable" "(Change where proot-distro is located in) Current: $P_DSTS" \
            "<!>CHANGE P_DSTS_INST Variable" "(Change where proot-distro's installed rootfs is located in) Current: $P_DSTS_INST" \
            "<!>Chnage P_SH Variable" "(Change where script installs are located) Current: $P_SH" \
            2>&1 >/dev/tty)
        AIMS=$?
        case $AIMS in
            1)
                menu 
                ;;
        esac
        case $menu in
            "<!>Change P_DSTS Variable")
                P_DSTS_CHANGE
                ;;
            "<!>CHANGE P_DSTS_INST Variable")
                P_DSTS_INST_CHANGE
                ;;
            "<!>Change P_SH Variable")
            #wip
                P_SH_CHANGE
                ;;
        esac
}

function P_DSTS_CHANGE () {
    VAR=$(dialog --backtitle "Changing Distro Variable" \
                --title "Changing P_DSTS Variable" \
                --inputbox "WARNING: CASE SENSITIVE \nInput what directory do you want to change with it\n\nRemember to put '\ \' when there's spaces in the path, and make sure it works alongside with proot-distro's dir\n\nThis Feature is supposed to be for custom proot-distro code that referring to use a different directory." 0 0 $P_DSTS \
                2>&1 >/dev/tty)
    ARVMA=$?
    case $ARVMA in 
        1)
            configure 
            ;;
    esac 
    if [ ! -n "$VAR" ];
        then
            msgbox "ERROR" "NO INPUT DETECTED!" "Please try to enter dir again..."
            P_DSTS_CHANGE
        else 
            if [ -d "$VAR" ] && [ -r "$VAR" ] && [ -w "$VAR" ]; then
                P_DSTS_OLD="$P_DSTS"
                sleep 5
                P_DSTS="$VAR"
                infobox "Variable Changed" "Variable changed" "The P_DSTS Variable has sucesfully changed from $P_DSTS_OLD to $P_DSTS\n\nExiting in 10 Seconds to Main Menu"
                sleep 10
                menu 
            else 
                msgbox "ERROR" "DIRECTORY DOES NOT EXIST!" "The Directory that you mantioned: $VAR, doesn't exist in your termux. Please make sure its there...\n\nOr if its there, then make sure its read and writeable"
                P_DSTS_CHANGE
            fi 
        fi 
}

function P_DSTS_INST_CHANGE () {
    VAR=$(dialog --backtitle "Changing Distro Variable" \
                --title "Changing P_DSTS_INST Variable" \
                --inputbox "WARNING: CASE SENSITIVE \nInput what directory do you want to change with it\n\nRemember to put '\ \' when there's spaces in the path, and make sure it works alongside with proot-distro's tarball extraction dir\n\nThis Feature is supposed to be for custom proot-distro code that referring to use a different directory." 0 0 $P_DSTS_INST \
                2>&1 >/dev/tty)
    ARVMA=$?
    case $ARVMA in 
        1)
            configure 
            ;;
    esac 
    if [ ! -n "$VAR" ];
        then
            msgbox "ERROR" "NO INPUT DETECTED!" "Please try to enter dir again..."
            P_DSTS_CHANGE
        else 
            if [ -d "$VAR" ] && [ -r "$VAR" ] && [ -w "$VAR" ]; then
                P_DSTS_INST_OLD="$P_DSTS_INST"
                sleep 5
                P_DSTS_INST="$VAR"
                infobox "Variable Changed" "Variable changed" "The P_DSTS Variable has sucesfully changed from $P_DSTS_INST_OLD to $P_DSTS_INST\n\nExiting in 10 Seconds to Main Menu"
                sleep 10
                menu 
            else 
                msgbox "ERROR" "DIRECTORY DOES NOT EXIST!" "The Directory that you mantioned: $VAR, doesn't exist in your termux. Please make sure its there...\n\nOr if its there, then make sure its read and writeable"
                P_DSTS_CHANGE
            fi 
        fi 
}

function P_SH_CHANGE () {
    msgbox "Coming Soon" "Sorry" "Since this line string is not used, yet. The modification of P_SH is blocked until further updates are psuhed"
    configure
}

function help_and_about () {
    MENU=$(dialog \
            --backtitle "Help and About" \
            --title "Help and About" \
            --menu "Pick what you want" 0 0 0 \
            "About" "About Page" \
            "Help" "Help Page" \
            2>&1 >/dev/tty)
    ARVMA=$?
    case $ARVMA in 
        1)
            menu 
            ;;
    esac
    case $MENU in 
        "About")
            msgbox "About Page" "About" "$(cat assets/PAGES/ABOUT.txt)\n\nReleases: \n$(cat assets/PAGES/RELEASE.txt)"
            menu 
            ;;
        "Help")
            help_page
            ;;
    esac
}

function help_page () {
    MENU=$(dialog \
            --backtitle "Help Page" \
            --title "Help Page: PRoot-distro-tui" \
            --menu "Pick anything that you need to understand" 0 0 0 \
            "Mesa Support" "Mesa Support Docs" \
            "Comparison between Chroot and Proot" "A lenghty detail by ChatGPT on what's Chroot and PROot" \
            "Changing Variables" "Changing Variables in the script" \
            2>&1 >/dev/tty)
    ARVMA=$?
    case $ARVMA in
        1)
            help_and_about
            ;;
    esac 
    case $MENU in 
        "Mesa Support")
            msgbox "Help Page: Mesa" "Mesa Help" "$(cat assets/PAGES/MESA.txt)"
            help_page
            ;;
        "Comparison between Chroot and Proot")
            msgbox "Help Page: Comparison between Chroot and Proot" "Comparisons between Chroot and Proot" "$(cat assets/PAGES/COMPARISON.txt)"
            help_page
            ;;
        "Changing Variables")
            msgbox "Help Page: Changing Variables" "Changing cached variables" "$(cat assets/PAGES/CHANGING_VAR.txt)"
            help_page
            ;;
    esac 
}




# Init AREA
# Do not add anything here other than welcome

welcome