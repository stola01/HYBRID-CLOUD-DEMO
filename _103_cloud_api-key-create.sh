#!/bin/bash

source ./.env

if [ "${CCCLUSTER}" = "" ]
then
	echo ">>> ERROR - please set CCCLUSTER in the .env file"
	exit 1
fi

echo ">>> Creating API Key for cluster ${CCCLUSTER}"
ccloud api-key create --resource ${CCCLUSTER} --description "Cluster wide key"
echo
echo ">>> Set CCAPIKEY and CCAPIKEYSECRET in the .env file"
