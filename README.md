# Container Druid

## How to use the image

To start the container

```bash
docker run -d --rm -p 8888:8888 --name druid swal4u/druid:v0.15.1.2
```

To stop the container

```bash
docker stop druid
```

If you want to have data persistence, you must declare volume folder.

## How to have exact COUNT Distinct without approximation

```bash
docker run -d --rm -p 8888:8888 -v $PWD/broker/runtime.properties:/usr/local/druid/conf/druid/single-server/micro-quickstart/broker/runtime.properties  --name druid swal4u/druid:v0.15.1.2
```

My new file runtime.properties contains additional lines at the end of original file.

```bash
# SQL properties
druid.sql.planner.useApproximateCountDistinct=false
```
