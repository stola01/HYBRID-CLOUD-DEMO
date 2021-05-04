#!/bin/bash

source ./.env
ccloud connector delete ${CCDGUSERSID}
ccloud connector delete ${CCDGPAGEVIEWSID}

