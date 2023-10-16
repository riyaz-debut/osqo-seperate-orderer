

echo ""
echo "  WARNING !!"
echo ""
echo "  ARE YOU RUNNING THIS SCRIPT FOR THE VERY FIRST TIME IN THIS MACHINE ?" 
echo ""
echo "  If not, then running this script can result in loss of previous data"
echo ""
read -p "  Are you sure you want to Continue running this script (y/n)?" choice
case "$choice" in 
  y|Y ) 
  
        echo ""
        echo ""


        sudo apt-get update

        sleep 3


        echo ""
        echo ""
        echo "============================================================================"
        echo "====================== INSTALL CURL ========================================"
        echo "============================================================================"
        echo ""
        echo ""

        set -eo pipefail

        sudo apt install curl -y

        sleep 3

        echo ""
        echo ""
        echo "============================================================================"
        echo "====================== INSTALL JQ =========================================="
        echo "============================================================================"
        echo ""
        echo ""

        set -eo pipefail

        sudo apt install jq -y

        sleep 3


        echo ""
        echo ""
        echo "============================================================================"
        echo "====================== INSTALL ZIP ========================================="
        echo "============================================================================"
        echo ""
        echo ""

        set -eo pipefail

        sudo apt install zip -y

        sleep 3

        set -eo pipefail

        sudo apt-get install unzip -y

        sleep 3

        echo ""
        echo ""
        echo "============================================================================="
        echo "====================== INSTALL NODE JS ======================================"
        echo "============================================================================="
        echo ""
        echo ""

        set -eo pipefail

        sudo apt install nodejs -y

        sleep 3


        echo ""
        echo ""
        echo "============================================================================="
        echo "====================== INSTALL NPM =========================================="
        echo "============================================================================="
        echo ""
        echo ""

        set -eo pipefail

        sudo apt install npm -y

        sleep 3
  

        echo ""
        echo ""
        echo "============================================================================="
        echo "====================== INSTALL DOCKER ======================================="
        echo "============================================================================="
        echo ""
        echo ""

        set -eo pipefail

        sudo apt install docker.io -y

        sleep 3

        echo ""
        echo ""
        echo "============================================================================="
        echo "====================== INSTALL DOCKER COMPOSE ==============================="
        echo "============================================================================="
        echo ""
        echo ""

        set -eo pipefail

        sudo apt install docker-compose -y

        sleep 3


        echo ""
        echo ""
        echo "============================================================================="
        echo "====================== ENABLE DOCKER SERVICE ================================"
        echo "============================================================================="
        echo ""
        echo ""

        set -eo pipefail

        sudo apt install docker-compose -y

        sleep 3


        echo ""
        echo ""
        echo "============================================================================="
        echo "====================== ADDING USER TO DOCKER GROUP =========================="
        echo "============================================================================="
        echo ""
        echo ""

        set -eo pipefail

        sudo usermod -a -G docker $USER

        echo ""
        echo ""
        echo "============================================================================="
        echo "====================== APPLY NEW GROUP MEMBERSHIP ==========================="
        echo "============================================================================="
        echo ""
        echo ""

        set -eo pipefail

        sudo su - ${USER}

        sleep 3
  ;;

  n|N ) 
        echo ""
        echo "Exit Successfully without running"
        echo ""
  ;;
  * )   echo "INVALID INPUT";;
esac
