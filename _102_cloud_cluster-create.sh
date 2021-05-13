#!/bin/bash

source ./.env

if [ "${CCCLUSTERNAME}" = "" ]
then
	echo ">>> ERROR - please set CCCLUSTERNAME in the .env file"
	exit 1
fi

echo ">>> Creating cluster ${CCCLUSTERNAME} (${CCCLUSTERTYPE}, ${CCCLUSTERAZ}) in ${CCCLOUD} region ${CCREGION}"
ccloud kafka cluster create ${CCCLUSTERNAME} \
    --cloud "${CCCLOUD}" \
    --region "${CCREGION}" \
    --availability "${CCCLUSTERAZ}" \
    --type "${CCCLUSTERTYPE}" 
echo
echo ">>> Set CCCLUSTER to the ID and CCBS to the bootstrap host (just the host, no protocol or port) of the cluster ${CCCLUSTERNAME} in the .env file"
