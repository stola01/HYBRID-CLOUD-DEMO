#!/bin/bash

source ./.env

if [ "${CCENVNAME}" = "" ]
then
	echo ">>> ERROR - please set CCENVNAME in the .env file"
	exit 1
fi

echo ">>> Creating environment ${CCENVNAME}"
ccloud environment create "${CCENVNAME}"
echo
echo ">>> Set CCENV in the .env file to the ID of the environment ${CCENVNAME}"
