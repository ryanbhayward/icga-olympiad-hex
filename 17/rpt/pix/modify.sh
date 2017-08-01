#!/bin/sh

for file in *.eps
do
  sed -i.bak -f my.sed $file
done
