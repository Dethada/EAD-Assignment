#!/bin/sh
docker build -t spmovy .
docker run -d -p 8080:8080 --name web-spmovy spmovy
docker start web-spmovy