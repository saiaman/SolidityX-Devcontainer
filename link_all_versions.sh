#!/bin/sh

HARDHAT_PATH_CACHE="/root/.cache/hardhat-nodejs/compilers-v2/linux-amd64/"
mkdir -p $HARDHAT_PATH_CACHE
wget https://binaries.soliditylang.org/linux-amd64/list.json -O "${HARDHAT_PATH_CACHE}list.json"

for solcfile in `cat "${HARDHAT_PATH_CACHE}list.json" | jq -r '.releases[]'`
do
    DESTINATION_FILE="${HARDHAT_PATH_CACHE}${solcfile}"
    if [ -f "$DESTINATION_FILE" ]; then
        echo "$DESTINATION_FILE allready exists."
    else 
        ln -s /SolidityX/build/solc/solc ${DESTINATION_FILE}
    fi
done

exec "$@"
