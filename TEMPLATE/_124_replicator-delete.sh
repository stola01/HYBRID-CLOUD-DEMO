#!/bin/bash

curl -s -X DELETE http://localhost:8083/connectors/ReplicatorSourceConnector_CloudToOnPrem | jq .
