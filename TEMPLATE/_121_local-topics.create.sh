#!/bin/bash
docker-compose exec broker kafka-topics --bootstrap-server localhost:9092 --create --topic users --partitions 1 --replication-factor 1
docker-compose exec broker kafka-topics --bootstrap-server localhost:9092 --create --topic pageviews --partitions 1 --replication-factor 1
