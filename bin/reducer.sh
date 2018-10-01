#!/usr/bin/env bash
set -x -e

iteration=1
while read line
do
    key=`echo $line | awk '{print $1}'`
    value=`echo $line | awk '{print $2}'`
    if [ "$iteration" != "1" ]
    then
        >&2 echo "ERROR. Iteration 2. Only one iteration was expected."
        exit -1
    fi

    echo "Processing bucket $key ..."

    # Your code which starts processing of buckets should be here.
    echo "'Hello world!' from bucket number $key. Got env variable from main script: basePath=$basePath."

    iteration=`expr $iteration + 1`;
done
