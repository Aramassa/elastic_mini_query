#!/bin/bash

TMP_DIR=/tmp/elastic

mkdir -p ${TMP_DIR}
cd ${TMP_DIR}

curl -O https://download.elastic.co/demos/kibana/gettingstarted/7.x/shakespeare.json
curl -O https://download.elastic.co/demos/kibana/gettingstarted/7.x/accounts.zip
curl -O https://download.elastic.co/demos/kibana/gettingstarted/7.x/logs.jsonl.gz

unzip accounts.zip
gunzip logs.jsonl.gz

/bin/bash /es_scripts/7.x.setup.sh

curl -H 'Content-Type: application/x-ndjson' -XPOST 'localhost:9200/bank/account/_bulk?pretty' --data-binary @accounts.json
curl -H 'Content-Type: application/x-ndjson' -XPOST 'localhost:9200/shakespeare/_bulk?pretty' --data-binary @shakespeare.json
curl -H 'Content-Type: application/x-ndjson' -XPOST 'localhost:9200/_bulk?pretty' --data-binary @logs.jsonl

