#!/bin/bash

export TAG='latest'
while getopts 'tvl' OPT; do
    # echo "$OPT = $OPTARG"
    case $OPT in
        l) export TAG=$(docker images | grep reverse-proxy | awk 'NR==1{print$2}');;
        v) export TAG=$(git rev-parse --short=7 HEAD)-$(git log HEAD -n1 --pretty='format:%cd' --date=format:'%Y%m%d-%H%M');;
    esac
done

echo $TAG
export TAG=$TAG
docker-compose -f ./docker-compose.yaml up -d reverse-proxy resume linebot avalon websocket websocket-ui mysql redis university university-demo fb btc