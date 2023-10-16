
       

        



echo ""
echo "  WARNING !!"
echo ""
echo "  ARE YOU RUNNING THIS SCRIPT FOR THE VERY FIRST TIME IN THIS MACHINE ?" 
echo ""
echo "  If not, then running this script can result in loss of previous data and may cause serious affects to already mounted ADDITIONAL VOLUME."
echo ""
read -p "  Are you sure you want to Continue running this script (y/n)?" choice
case "$choice" in 
  y|Y ) 
  
        echo ""
        echo ""
        echo "============================================================================="
        echo "====================== DOWNLOAD FABRIC BINARIES ============================="
        echo "============================================================================="
        echo ""
        echo ""

        set -eo pipefail



        echo "cd /home/$USER/ && curl -sSL https://bit.ly/2ysbOFE | bash -s" > /home/$USER/fabric-download.sh

        sleep 3

        echo ""
        echo ""
        echo "============================================================================="
        echo "====================== DOWNLOADING =========================================="
        echo "============================================================================="
        echo ""
        echo ""

        chmod +x /home/$USER/fabric-download.sh

        sleep 3

        /home/$USER/fabric-download.sh


        echo ""
        echo ""
        echo "============================================================================="
        echo "====================== ADDING FABRIC BINARIRES PATH ========================="
        echo "============================================================================="
        echo ""
        echo ""

        set -eo pipefail

        sudo /bin/sh -c 'echo "

        PATH="/home/ubuntu/fabric-samples/bin:$PATH"

        " >> /home/ubuntu/.profile'

        sleep 3

        set -eo pipefail

        source ~/.profile

        sleep 3



        echo ""
        echo ""
        echo "============================================================================="
        echo "====================== MOUNT ADDITIONAL VOLUME =============================="
        echo "============================================================================="
        echo ""
        echo ""

        set -eo pipefail

        df -h

        set -eo pipefail

        lsblk

        sleep 2

        echo ""
        echo ""
        echo "============================================================================="
        echo "====================== CHECKING THE FILE SYSTEM ============================="
        echo "============================================================================="
        echo ""
        echo ""

        set -eo pipefail

        sudo file -s /dev/xvdb

        sleep 2 

        echo ""
        echo ""
        echo "============================================================================="
        echo "====================== FORMAT THE DISK======================================="
        echo "============================================================================="
        echo ""
        echo ""

        set -eo pipefail

        sudo mkfs -t xfs /dev/xvdb

        sleep 2

        echo ""
        echo ""
        echo "============================================================================="
        echo "====================== CHECKING THE FILE SYSTEM ============================="
        echo "============================================================================="
        echo ""
        echo ""

        set -eo pipefail

        sudo file -s /dev/xvdb

        sleep 2

        echo ""
        echo ""
        echo "============================================================================="
        echo "====================== CREATING DIRECTORY===================================="
        echo "============================================================================="
        echo ""
        echo ""

        set -eo pipefail

        sudo mkdir -p /hlf-volume

        sleep 2

        echo ""
        echo ""
        echo "============================================================================="
        echo "====================== MOUNTING VOLUME ======================================"
        echo "============================================================================="
        echo ""
        echo ""

        set -eo pipefail

        sudo mount /dev/xvdb /hlf-volume

        sleep 2

        echo ""
        echo ""
        echo "============================================================================="
        echo "====================== CHANGING OWNERSHIP OF DIRECTORY ======================"
        echo "============================================================================="
        echo ""
        echo ""

        set -eo pipefail

        sudo chown ubuntu:ubuntu -R /hlf-volume

        sleep 2


  ;;

  n|N ) 
        echo ""
        echo "EXIT SUCCESSFULLY"
        echo ""
  ;;
  * )   echo "INVALID INPUT";;
esac
