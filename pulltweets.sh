#!/bin/bash


# INSTALL 
# Put in your path and make executable (chmod +x pulltweets.sh)

myQuery="$1"
page=1
count=0

function usage
{

    echo " usage: pulltweets.sh query [numberOfPagesToDownload] "
    echo " Suggested use: pulltweets.sh #importantevent > importantevent.xml  "
}

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


