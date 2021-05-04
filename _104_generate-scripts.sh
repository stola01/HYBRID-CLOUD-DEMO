#!/bin/bash

source ./.env

for f in `ls ${TEMPLATEDIR}`
do
	cat ${TEMPLATEDIR}/${f} | sed \
		-e "s/XXX-CCBS-XXX/${CCBS}/g" \
		-e "s/XXX-CCAPIKEY-XXX/${CCAPIKEY}/g" \
		-e "s@XXX-CCAPISECRET-XXX@${CCAPISECRET}@g" \
	> ${f}
	
done
