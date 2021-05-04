#!/bin/bash

source .env

docker-compose exec broker kafka-consumer-groups --bootstrap-server ${CCBS}:9092 --command-config /tmp/SCRIPT//ccloud.client.properties --delete --group ReplicatorSourceConnector_CloudToOnPrem

