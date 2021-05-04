#!/bin/bash

source .env

docker-compose exec broker kafka-consumer-groups --bootstrap-server ${CCBS}:9092 --command-config /tmp/SCRIPT/ccloud.client.properties --group ReplicatorSourceConnector_CloudToOnPrem --reset-offsets --to-earliest --execute --all-topics

