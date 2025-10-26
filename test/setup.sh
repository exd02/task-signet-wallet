wget https://bitcoincore.org/bin/bitcoin-core-29.0/bitcoin-29.0-x86_64-linux-gnu.tar.gz
tar -xzvf bitcoin-29.0-x86_64-linux-gnu.tar.gz
ln -s $PWD/bitcoin-29.0/bin/* /usr/local/bin/

# Sync up to block 300
bitcoind -daemon -signet -signetchallenge=0014bdec02fe5ec499cc2cb52dc160230643a84dd118 -stopatheight=310 -addnode=185.215.164.89:38333

# Start node with no connections
bitcoind -daemon -signet -signetchallenge=0014bdec02fe5ec499cc2cb52dc160230643a84dd118 -blocksonly=1 -noconnect

while true; do
  blockcount=$(bitcoin-cli -signet getblockcount)
  if [[ $blockcount -ge 300 ]]; then
    echo "blocks: $blockcount"
    break
  else
    sleep 1
  fi
done
