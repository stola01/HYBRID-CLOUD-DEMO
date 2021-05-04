#!/bin/bash

source ./.env

if [ "${CCCLUSTERNAME}" = "" ]
then
	echo ">>> ERROR - please set CCCLUSTERNAME in the .env file"
	exit 1
fi

echo ">>> Creating cluster ${CCCLUSTERNAME}"
ccloud kafka cluster create ${CCCLUSTERNAME} \
    --cloud "aws" \
    --region "eu-west-1" \
    --availability "single-zone" \
    --type "basic" 
echo
echo ">>> Set CCCLUSTER to the ID and CCBS to the bootstrap host (just the host, no protocol or port) of the cluster ${CCCLUSTERNAME} in the .env file"
