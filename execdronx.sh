#!/bin/bash
#Executable Area
: ${DIALOG_OK=0}
: ${DIALOG_CANCEL=1}
: ${DIALOG_HELP=2}
: ${DIALOG_EXTRA=3}
: ${DIALOG_ITEM_HELP=4}
: ${DIALOG_ESC=255}
#Code
cd $HOME
exec 3>&1
menuvars=$( dialog \
    --backtitle "Execute Andronix Distros" \
    --title "Run-a-Distro" \
    --menu "Pick a Distro of Your choice, If the distro is not installed/Wiped because of pure stupidity, then this output  will crash." 25 45 4 \
    "1" "Debian 10 (ARMv7)" \
    "2" "Ubuntu 20 (ARMv7)" \
    2>&1 1>&3 \
  )
exitval=$?
exec 3>&-
case $exitval in 
  $DIALOG_CANCEL)
  dialog --infobox "Please Run main.sh again manually"
  sleep 3
  exit
  ;;
esac
case $menuvars in 
  1)
  ./start-debiam.sh
  ;;
  2)
  ./start-ubuntu.sh 
  ;;
esac