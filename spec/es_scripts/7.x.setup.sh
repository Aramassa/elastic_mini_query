#!/bin/bash

curl -H 'Content-Type: application/json' -XPUT http://localhost:9200/shakespeare -d '
{
  "mappings": {
    "properties": {
    "speaker": {"type": "keyword"},
    "play_name": {"type": "keyword"},
    "line_id": {"type": "integer"},
    "speech_number": {"type": "integer"}
    }
  }
}'

curl -H 'Content-Type: application/json' -XPUT http://localhost:9200/logstash-2015.05.18 -d '
{
  "mappings": {
    "properties": {
      "geo": {
        "properties": {
          "coordinates": {
            "type": "geo_point"
          }
        }
      }
    }
  }
}'

curl -H 'Content-Type: application/json' -XPUT http://localhost:9200/logstash-2015.05.19 -d '
{
  "mappings": {
    "properties": {
      "geo": {
        "properties": {
          "coordinates": {
            "type": "geo_point"
          }
        }
      }
    }
  }
}'

curl -H 'Content-Type: application/json' -XPUT http://localhost:9200/logstash-2015.05.20 -d '
{
  "mappings": {
    "properties": {
      "geo": {
        "properties": {
          "coordinates": {
            "type": "geo_point"
          }
        }
      }
    }
  }
}'

