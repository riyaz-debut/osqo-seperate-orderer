
echo""
echo""
echo "============================================================"
echo "CREATING CHANNEL"
echo "============================================================"
echo""
echo""

sleep 2

set -eo pipefail

./scratch/create-channel.sh

sleep 2

echo""
echo""
echo "============================================================"
echo "CHANNEL CREATION DONE"
echo "============================================================"
echo""
echo""

sleep 2


echo""
echo""
echo "============================================================"
echo "ZIPPING CHANNEL-ARTIFACTS"
echo "============================================================"
echo""
echo""

sleep 2

./scratch/zip-channel-block.sh

sleep 2

echo""
echo""
echo "============================================================"
echo "ZIPPING DONE"
echo "============================================================"
echo""
echo""

sleep 2




