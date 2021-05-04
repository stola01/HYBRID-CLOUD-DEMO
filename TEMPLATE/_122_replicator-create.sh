#!/bin/bash

curl -s -X POST -H "Content-Type: application/json" --data "@connector_ReplicatorSourceConnector_CloudToOnPrem_config.json" http://localhost:8083/connectors | jq .

