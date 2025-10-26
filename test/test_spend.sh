#!/usr/bin/env bash
set -euo pipefail

result=$(OPENSSL_CONF=./test/openssl.cnf bash ./solution/run_spend.sh)
tx1=$(echo "$result" | tail -n 2 | head -n 1)
tx2=$(echo "$result" | tail -n 1)

# Run first test
out1=$(bitcoin-cli -signet testmempoolaccept "[\"$tx1\"]" | jq -r '.[0].allowed')

if [[ "$out1" == "true" ]]; then
  # TX1 was accepted. Now test TX1 + TX2 together
  out2=$(bitcoin-cli -signet testmempoolaccept "[\"$tx1\",\"$tx2\"]" | jq -r '.[1].allowed')
  if [[ "$out2" == "true" ]]; then
    echo "PASS"
  else
    echo "FAIL ❌ TX2 rejected"
    exit 1
  fi
else
  echo "FAIL ❌ TX1 rejected"
  exit 1
fi

