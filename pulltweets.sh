#!/bin/bash

myQuery="$1"
page=1
count=0

if test -z "$1"
then
    echo " usage: pulltweets.sh query [numberOfPagesToDownload] "
    exit 1
fi

if test -z "$2"
then 
    page=1
else
    page="$2"
fi

while [ $count -lt $page ]
do
    count=$[$count+1]
    curl http://search.twitter.com/search.atom?q=$myQuery\&rpp=100\&page=$count
done


