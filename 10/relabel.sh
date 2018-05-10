#!/bin/bash

count=1
for myfile in *-1.sgf
do
    if [ "$count" -lt 10 ]
    then cp $myfile gm0$count.sgf
    else cp $myfile gm$count.sgf
    fi
    let "count+=1"
done
count=13
for myfile in *-2.sgf
do
    cp $myfile gm$count.sgf
    let "count+=1"
done
