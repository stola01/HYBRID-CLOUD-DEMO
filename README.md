# Confluent Cloud Hybrid Demo

## Pre-requsits
- docker, docker-compose
- curl, jq (optional)
- Confluent Cloud account

### 1. Set up the CLI

```
# Check if the CLI is installed
ccloud version

# If ccloud is installed, then update
ccloud update

# If ccloud is not installed, then install (if necessary add location to path)
# Can also install from a tarbarll - see here: https://docs.confluent.io/current/quickstart/cloud-quickstart/index.html#tarball-installation
curl -L --http1.1 https://cnfl.io/ccloud-cli | sh -s -- -b /usr/local/bin

# Optional - enable autocompletio
apt-get install bash-completion
ccloud completion bash > /etc/bash_completion.d/ccloud
source /etc/bash-completion # Also set this in bashrc etc for other sessions to pick up

```


### 2. Login to Confluent Cloud
```
ccloud login --save
```



### 3. Set up Confluent Cloud - Environemt, Cluster, API Key

```
# Edit .env, and set names for the Environment (CCENVNAME), and Cluster (CCCLUSTERNAME)
# Optionally, change the values for the cloud vendor, region, cluster type and availability choice
# Note: if you use a cluster type other than basic, edit the cluster creation script to add additional arguments
-> Edit .env
```

#### Env

```
# Check if an environment already exists
ccloud environment list

# If not create one
./_101_cloud_env-create.sh

# Set CCENV in the .env file to the ID of the new environment
-> Edit .env

# Set to use the environment, and check that we are using the correct one (check the *)
source ./.env
ccloud environment use ${CCENV}
ccloud environment list
```


#### Cluster

```
# Check if the cluster exists
ccloud kafka cluster list

# If not create one
./_102_cloud_cluster-create.sh

# Set CCCLUSTER to the ID, and CCBS to bootstrap host, of the cluster in the .env file
# (if using an existing cluster, use ccloud kafka cluster describe to get the CCBS)
-> Edit .env

# Set to use the cluster, and check that we are using the correct one (check the *)
source ./.env
ccloud kafka cluster use ${CCCLUSTER}
ccloud kafka cluster list
```


#### API Key

```
# Create an API Key (or if you have an existing API Key and Secret skip this step)
./_103_cloud-api-key-create.sh

# Set CCAPIKEY and CCAPIKEYSECRET in the .env file
-> Edit .env

# Set to use this API Key and check we are using the right one (check the *)
source ./.env
ccloud api-key use \${CCAPIKEY} --resource \${CCCLUSTER}
ccloud api-key list --resource \${CCCLUSTER}
```



### 4. Generate the scripts from the templates
```
# If you get errors, check your key for the "@" symbol and edit the sed statement to avoid it (use a delimiter that is not in the key)
./_104_generate-scripts.sh
```



### 5. Create the users and pageviews topics in the cloud
```
./_111_cloud-topics-create.sh
```



### 6. Create the datagen connectors for users and pageviews and consume the output
```
# Create the connector
./_112_cloud-create-dg-connectos.sh

# Record the id of both connectors in the .env file CCDGUSERSID, CCDGPAGEVIEWSID
-> Edit .env

# Consume using the cloud cli
ccloud kafka topic consumer --from-beginning user
ccloud kafka topic consumer --from-beginning pageviews

# Or with kafka-console-consumer
source .env
docker-compose exec broker kafka-console-consumer --bootstrap-server ${CCBS}:9092 --consumer.config /tmp/SCRIPT/ccloud.client.properties --from-beginning --topic user
docker-compose exec broker kafka-console-consumer --bootstrap-server ${CCBS}:9092 --consumer.config /tmp/SCRIPT/ccloud.client.properties --from-beginning --topic pageviews
```

### 7. Stop the connectors (optional)
```
./_113_cloud-delete-dg-connectors.sh
```



### 8. Start the local environment
```
docker-compose up -d
```



### 9. Create the local topics
```
./_121_local-topics.create.sh
```



### 10. Start the replicator
```
# Either
./_122_replicator-create.sh

# Or, if you have jq installed, format the output
./_122_replicator-create.sh | jq .

# Also, see script:
#   123 Get replicator status
#   124 Delete the replicator
#   125 Delete the replicator consumer group
#   126 Remove the offsets from the replicator consumer group
```



### 11. Consume local topics
```
source .env
docker-compose exec broker kafka-console-consumer --bootstrap-server localhost:9092 --from-beginning --topic users
docker-compose exec broker kafka-console-consumer --bootstrap-server localhost:9092 --from-beginning --topic pageviews
```



### 12. Create the ksqlDB streams and tables
```
# Create pageviews stream
docker-compose exec -T ksqldb-cli ksql http://ksqldb-server:8088 < ./_131_ksql-create-pageview-stream.sql

# Create users table
docker-compose exec -T ksqldb-cli ksql http://ksqldb-server:8088 < ./_132_ksql-create-users-table.sql

# Join pageviews to users to create pageviews_enriched stream
docker-compose exec -T ksqldb-cli ksql http://ksqldb-server:8088 < ./_133_ksql-create-pageviews_enriched-stream.sql

# Create a copy of pageviews\_enriched that is registered with the Schema Registry (pageviews_enriched_avro)
docker-compose exec -T ksqldb-cli ksql http://ksqldb-server:8088 < ./_134_ksql-create-pageviews_enriched_avro-stream.sql
```



### 13. Consume the data via the console consumer
```
docker-compose exec schema-registry kafka-avro-console-consumer --bootstrap-server broker:29092 --from-beginning --topic pageviews_enriched_avro
```



### 14. Explore the data flow
```
-> Point a brower at http://localhost:9091
```

