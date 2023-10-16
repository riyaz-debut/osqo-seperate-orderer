
echo""
echo""
echo "============================================================"
echo "    GENERATE NETWORK CERTIFICATES FOR ORGS"
echo "============================================================"
echo""
echo""

sleep 2

set -eo pipefail

./scratch/generate-msp.sh re-generate 

sleep 2

echo""
echo""
echo "============================================================"
echo "    CERTIFICATES GENERATION DONE"
echo "============================================================"
echo""
echo""

sleep 2


echo""
echo""
echo "============================================================"
echo "    GENERATE NETWORK CONFIGS FILES FOR NODES "
echo "============================================================"
echo""
echo""

sleep 2

set -eo pipefail

./scratch/generate-peer-base.sh hlf

sleep 2

set -eo pipefail

./scratch/generate-network-files.sh

echo""
echo""
echo "============================================================"
echo "    NETWORK FILES GENERATION DONE"
echo "============================================================"
echo""
echo""

sleep 2

echo""
echo""
echo "============================================================"
echo "    GENERATING GENESIS BLOCK AND CHANNEL TX FILE"
echo "============================================================"
echo""
echo""

sleep 2

set -eo pipefail

./scratch/genesis.sh

sleep 2

echo""
echo""
echo "============================================================"
echo "    GENESIS BLOCK GENERATION DONE"
echo "============================================================"
echo""
echo""

sleep 2


echo""
echo""
echo "============================================================"
echo "    GENERATING CONNECTION FILES"
echo "============================================================"
echo""
echo""

sleep 2

set -eo pipefail

./scratch/ccp-generate.sh

sleep 2

echo""
echo""
echo "============================================================"
echo "    CONNECTION FILES GENERATION DONE"
echo "============================================================"
echo""
echo""

sleep 2


echo""
echo""
echo "============================================================"
echo "    GENERATING ZIP FOR CERTIFICATES, GENESIS, CHANNEL FILES"
echo "============================================================"
echo""
echo""

sleep 2

set -eo pipefail

./scratch/zip-certificate-data.sh

sleep 2

echo""
echo""
echo "============================================================"
echo "    ZIPPING CERTIFICATE FILES DONE"
echo "============================================================"
echo""
echo""

sleep 2



echo""
echo""
echo "============================================================"
echo "    GENERATING ZIP FILE FOR SDK DATA"
echo "============================================================"
echo""
echo""

sleep 2

set -eo pipefail

./scratch/zip-sdk-data.sh

sleep 2

echo""
echo""
echo "============================================================"
echo "    ZIPPING SDK FILES DONE"
echo "============================================================"
echo""
echo""

sleep 2

echo""
echo""
echo "============================================================"
echo "    GENERATING ZIP FILE FOR EXPLORER DATA"
echo "============================================================"
echo""
echo""

sleep 2

set -eo pipefail

./scratch/zip-explorer-data.sh

sleep 2

echo""
echo""
echo "============================================================"
echo "    ZIPPING EXPLORER FILES DONE"
echo "============================================================"
echo""
echo""

sleep 2