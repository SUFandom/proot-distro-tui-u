#!/bin/bash
house=$HOME
cd $house
curl https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/repo-fix.sh > repo.sh && chmod +x repo.sh && bash repo.sh && wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Uninstall/Debian/UNI-debian.sh && chmod +x UNI-debian.sh && bash UNI-debian.sh
