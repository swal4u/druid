# Container Druid

## How to use the image

To start the container

```bash
docker run -d --rm -p 8888:8888 -p 8082:8082 --name druid swal4u/druid:v0.15.1.3
```

To stop the container

```bash
docker stop druid
```

If you want to have data persistence, you must declare volume folder.

## How to have exact COUNT Distinct without approximation

My new file runtime.properties contains additional lines at the end of original file.

```bash
# SQL properties
druid.sql.planner.useApproximateCountDistinct=false
```

I add this file in my dockerfile to modify the default configuration.

## How to query Druid

```bash
cd query
curl -XPOST -H'Content-Type: application/json' http://127.0.0.1:8082/druid/v2/sql/ -d @count_page.json
[{"NumberOfPages":35143}]
```
