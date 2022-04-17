#!/bin/bash
house=$HOME
cd $house
curl https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/repo-fix.sh > repo.sh && chmod +x repo.sh && bash repo.sh && wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Uninstall/Ubuntu20/UNI-ubuntu20.sh && chmod +x UNI-ubuntu20.sh && bash UNI-ubuntu20.sh
