#!/bin/bash
#Executable Area
: ${DIALOG_OK=0}
: ${DIALOG_CANCEL=1}
: ${DIALOG_HELP=2}
: ${DIALOG_EXTRA=3}
: ${DIALOG_ITEM_HELP=4}
: ${DIALOG_ESC=255}
#Code
if ( dialog --backtitle "Warning" --title "Are you sure?" --yes-label "Yes, I am sure" --no-label "Go Back" --yesno "Do you wish to execute Distro but separating the termux Framework just like divorce and go live with it? You may having some issues soon with accessibility with your SDCard Directory, as you may need to install gftp and start ftp in your device. Proceed?" 0 0)
then
  clear
  termux-toast
else
./main.sh 
fi
exec 3>&1
divorce=$( dialog \
    --backtitle "Isolation Mode" \
    --title "Select a Distro" \
    --menu "Select who you want to divorce with Termux and your distro (Andronix Distros Not Included). Make sure your distro is already installed or this won't work" 25 45 5 \
    "1" "Alpine Linux" \
    "2" "Arch Linux (AAAAAAAAARCH!!!)" \
    "3" "Debian" \
    "4" "Fedora (Perry the Platypus~~)" \
    "5" "Manjaro(AARCH64)" \
    "6" "Open(ඞ)SUSe" \
    "7" "Ubuntu (Hey did you know, that there is an anime waifu named Ubunchu?)" \
    "8" "Void" \
    2>&1 1>&3 \
  )
exis=$?
exec 3>&-
case $exis in
 $DIALOG_CANCEL)
        ./main.sh
        ;;
esac
#Function
function alpines () {
  termux-toast -g top "Alpine is now Divorced"
  proot-distro login alpine --isolated 
  clear
  dialog --infobox "Marrying them again"
  sleep 3
  termux-toast "Done"
  ./main.sh
}
function arrrch () {
  termux-toast -g top "Arch is now Divorced"
    proot-distro login archlinux --isolated 
    clear
    dialog --infobox "Marrying them again"
    sleep 3
    termux-toast "Done"
    ./main.sh
}
function debiann () {
  termux-toast -g top "Debian is now Divorced"
  proot-distro login debian --isolated 
  clear
  dialog --infobox "Marrying them again"
  sleep 3
  termux-toast "Done"
  ./main.sh
}
function agent_p () {
  termux-toast -g top "Fedora is now Divorced"
  proot-distro login fedora --isolated 
  clear
  dialog --infobox "Marrying them again"
  sleep 3
  termux-toast "Done"
  ./main.sh
}
function manjaroo () {
  termux-toast -g top "Manjaro64 is now Divorced"
  proot-distro login manjaro-aarch64 --isolated 
  clear
  dialog --infobox "Marrying them again"
  sleep 3
  termux-toast "Done"
  ./main.sh
}
function sus_amogus () {
  termux-toast -g top "OpenSus is now Divorced"
  proot-distro login opensuse --isolated 
  clear
  dialog --infobox "Marrying them again"
  sleep 3
  termux-toast "Done"
  ./main.sh
}
function ubunchuu () {
  termux-toast -g top "Ubuntu is now Divorced"
  proot-distro login ubuntu --isolated 
  clear
  dialog --infobox "Marrying them again"
  sleep 3
  termux-toast "Done"
  ./main.sh
}
function black_hole () {
  termux-toast -g top "Void is now Divorced"
  proot-distro login void --isolated 
  clear
  dialog --infobox "Marrying them again"
  sleep 3
  termux-toast "Done"
  ./main.sh
}
case $divorce in
  1) alpines ;;
  2) arrrch ;;
  3) debiann ;:
  4) agent_p ;;
  5) manjaroo ;;
  6) sus_amogus ;;
  7) ubunchuu ;;
  8) black_hole ;;
esac
