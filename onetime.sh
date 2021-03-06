#!/bin/env bash
#Gradient test is just to test for developers how terminal interacts with color
tput civis
echo "Gradient Test"
sleep 3
clear
color(){
    for c; do
        printf '\e[48;5;%dm%03d' $c $c
    done
    printf '\e[0m \n'
}

IFS=$' \t\n'
color {0..15}
for ((i=0;i<6;i++)); do
    color $(seq $((i*36+16)) $((i*36+51)))
done
color {232..255}
sleep 3
clear
echo "$(tput setaf 2) Running One Time Script..."
echo "$(tput setaf 1) Run this script one time only when necessary, if theres any issue, Report to the Developer. If you're wondering what does it do? well it just try to raise permission access of the script for usability.$(tput sgr0)"

sleep 3

echo -ne '[                  ] [000%] \r'
chmod +x *.sh
sleep .5
echo -ne '[####              ] [037%] \r'
chmod +x runtime/distro/*.sh
chmod +x runtime/undistro/*.sh
chmod +x runtime/andronix-distro/*.sh
chmod +x runtime/andronix-undistro/*.sh
sleep .5
echo -ne '[#############     ] [078%] \r'
chmod +x utils/*.sh
#i added them manually because they tend to have issues.
chmod +x utils/upd-true.sh
chmod +x utils/unins-phs1.sh
chmod +x utils/unins-true.sh
chmod +x utils/upd-true.sh
echo -ne '[################  ] [097%] \r'
clear
echo "Finalizing"
apt update
apt install bash dialog proot-distro termux-api termux-services -y
apt install coreutils -y
clear
sleep 1
echo   "[##################] [100%]"
echo "$(tput setaf 2)Complete..., If there's errors, Try to check manually and report. , Next Run you can only execute : ./main.sh to continue using the tool. (Suggest also now installing Termux:API on README.md$(tput sgr0)"
sleep 5
tput cnorm
clear
./main.sh
