#!/bin/bash

mkdir backup
cd backup

for n in $(dpkg --get-selections|grep -v deinstall|awk '{print $1}')
do
    echo Packaging $n
    sudo dpkg-repack $n
done 

cd ..
tar -zcvf backup.tar.gz backup
rm -rf backup