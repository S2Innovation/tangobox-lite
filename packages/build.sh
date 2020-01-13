#!/usr/bin/env bash

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

docker build -t tangobox-packages "$dir"

id=$(docker create tango-packages)
docker cp $id:/tango-source-distribution_9.3.4-rc3-dev_amd64.deb "$dir"
docker cp $id:/pytango-9.3.1-cp37-cp37m-linux_x86_64.whl "$dir"
docker rm $id
