#!/bin/bash
#This Area is Experimental and may not work Properly
: ${DIALOG_OK=0}
: ${DIALOG_CANCEL=1}
: ${DIALOG_HELP=2}
: ${DIALOG_EXTRA=3}
: ${DIALOG_ITEM_HELP=4}
: ${DIALOG_ESC=255}
#Code
exec 3>&1
menuvar=$( dialog \
    --backtitle "Andronix Uninstall Distro Area" \
    --menu "Unnstall your Andronix Distro" \
    --clear \
    --menu "Uninstall Distro that you Really Don't want!" 25 45 6 \
    "1" "Debian 10 (ARMv7)" \
    "2" "Ubuntu 20 (ARMv7)" \
    2>&1 1>&3 \
  )
exitsnif=$?
exec 3>&-
case $exitsnif in
 $DIALOG_CANCEL)
 ./main.sh
 ;;
 $DIALOG_ESC)
 exit 1
 ;;
esac
case $menuvar in
    1)
    if ( dialog --backtitle "Debian 10" --title "Debian Andronix 10" --yes-label "Uninstall" --no-label "Stop" --yesno "Do you wish to agree uninstalling Debian Andronix 10?" 0 0 )
    then
    ./runtime/andronix-undistro/debian.sh
    else
    ./remdronx.sh
    fi
    ;;
    2)
    if ( dialog --backtitle "Ubuntu 20" --title "Ubuntu Andronix 20" --yes-label "Uninstall" --no-label "Stop" --yesno "Do you want to uninstall Ubuntu 20?" 0 0 )
    then
    ./runtime/andronix-undistro/ubuntu.sh
    else
    ./godronx.sh 
    fi
    ;;
    esac
