#!/bin/env bash
#Dialog
BT="Proot-Distro TUI"
WIDTH=0
HEIGHT=0
prox=$PID
name=$(whoami)
#Randomizer
ram=$( shuf -i  1-11 -n 1 )
#ExitVars

: ${DIALOG_OK=0}
: ${DIALOG_CANCEL=1}
: ${DIALOG_HELP=2}
: ${DIALOG_EXTRA=3}
: ${DIALOG_ITEM_HELP=4}
: ${DIALOG_ESC=255}

#DefaultMsgbx
display_src() {
  dialog --backtitle "$BT" \
  --title "$1" \
  --no-collapse \
  --msgbox "$output" 0 0 
}

#Code
tput civis
termux-notification --priority max --ongoing -i 013 -t "Proot-Distro-TUI-U is Running\!" -c "Proot-Distro-TUI-U is running at Process ID: $prox" --button1 "End Process" --button1-action bash kill $prox 
clear
dialog -- backtitle "Proot-distro-tui-u [UNSTABLE 2.1]" --title "Hello, $name" --infobox "$( sed -n $ram\p splash/splash.txt ) " 0 0
sleep 6
exec 3>&1
menu=$( dialog \
  --backtitle "$BT" \
  --title "Main Menu" \
  --menu "Proot-Distro TUI Menu." 25 45 10 \
  "1" "Install/Run Distro"  \
  "2" "Uninstall Distro"  \
  "3" "Help"  \
  "4" "Update Script" \
  "5" "Uninstall Script"  \
  "6" "About" \
  2>&1 1>&3 \
  )
exitvalue=$?
exec 3>&-
case $exitvalue in
 $DIALOG_CANCEL)
 dialog --backtitle "$BT" --title "Abort" --infobox "Aborting..." 0 0
 sleep 3
 tput cnorm
 exit 1
 ;;
 $DIALOG_HELP)
 tput cnorm
 ./help.sh 
 ;;
 $DIALOG_ESC)
 clear
 echo "$(tput setaf 1)Hard Exit Attempted.. Exiting..$(tput sgr0)"
 sleep .9
 exit 255
esac
case $menu in
 1)
 tput cnorm
 ./go.sh
 ;;
 2)
 tput cnorm
 ./rm.sh
 ;;
 3)
 tput cnorm 
 ./help.sh 
 ;;
 4)
 tput cnorm
 ./update.sh
 ;;
 5)
 tput cnorm
 ./uninstall.sh
 ;;
 6)
 #Hey Forker! Change this to your info. but at help/about.text, only type the fields recommend there
 output=$(echo "Version 2.1-unstable, Under GPL 3.0. \
   It Perfectly Runs on Dialog \
   Author: SUFandom \
   Creator: SUFandom \
   Link (YT): https://bit.ly/BlzYT_SUF \
   Reddit: https://reddit.com/u/itsfreepizza " )
 display_src "About"
 ./main.sh
 ;;
 esac
