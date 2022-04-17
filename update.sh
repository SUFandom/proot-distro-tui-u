#!/bin/env bash
#This Script May be Useful Later on..

echo -ne 'Grabbing Update Database \r'
sleep .1
echo -ne 'Grabbing Update Database. \r'
sleep .1
clear
wget https://pastebin.com/raw/wt2xyCxH
cat AgDhMRQD 
sleep 5
clear

if (grep -i "Version:2.0-unstable" wt2xyCxH)
then
clear
rm -rf "wt2xyCxH"
echo "$(tput setaf 34) Proot-distro TUI Package Up-to-date.. $(tput sgr0)"
sleep 3
exit 0
else
rm -rf "wt2xyCxH"
echo "$(tput setaf 196)Script Outdated.. starting update script to grab update..But if Cat and Grep Says the file was missing, that means theres no proper connection or just report to the Dev at GitHub.$(tput sgr0)"
sleep 5
./utils/upd-phs1.sh
fi
