#!/bin/bash

source .env

ccloud connector create --config connector_datagen_users.json
ccloud connector create --config connector_datagen_pageviews.json
