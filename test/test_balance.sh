#!/usr/bin/env bash
set -euo pipefail

# Run student solution
result=$(OPENSSL_CONF=./test/openssl.cnf bash ./solution/run_balance.sh | tail -n 1)
echo "$result"

# Check against expected list of valid balances
if grep -Fxq "$result" ./test/wallet_balances.txt; then
  echo "PASS"
else
  echo "FAIL"
  exit 1
fi
