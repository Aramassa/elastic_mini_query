## srch v71

```json
{
	"size": 0,
	"track_total_hits": true,
	"query":{
		"range": {
			"unixtime": {
				"gte": "now-28d/d"
			}
		}
	}
}
```

## agg v71

```json
{
	"size": 0,
	"track_total_hits": true,
	"query":{
		"range": {
			"unixtime": {
				"gte": "now-28d/d"
			}
		}
	},
	"aggs": {
        "by_day": {
          "date_histogram": {
            "field": "unixtime",
            "interval": "hour",
            "format": "yyyy-MM-dd-HH",
						"order" : {"_key": "desc"}
          },
          "aggs":{
        	"USDJPY_avg": {
        		"avg": {"field": "USDJPY_avg"}
        	},
        	"USDJPY_max": {
        		"max": {"field": "USDJPY_avg"}
        	},
        	"USDJPY_min": {
        		"min": {"field": "USDJPY_avg"}
        	}
          }
        }
	}
}
```
