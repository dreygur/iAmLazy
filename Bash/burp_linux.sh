#!/bin/bash

echo -e "\e[0;32m
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    # You need to download Oracle-JDK-8 First
    # Otherwise this package may not work
    # Download from: http://bit.ly/2OVMDRM
    # And keep the tarball along with burp and this script
    # Good Lock
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
\e[0m"

install() {
    sudo mkdir -p /opt/jdk
    sudo cp -rf jdk-8* /opt/jdk/
    sudo tar -C /opt/jdk/ -zxf /opt/jdk/jdk-8*
    sudo cp -r /opt/jdk/jdk1.8.*/* /opt/jdk/
    sudo rm -rf /opt/jdk/jdk1.8.*
    /opt/jdk/bin/java -jar burp-loader.jar &
    /opt/jdk/bin/java -noverify -Xbootclasspath/p:burp-loader.jar -jar burpsuite_pro_v2020.1.jar &
}

if [[ $1 == 'i' ]]; then
    install
else
    /opt/jdk/bin/java -noverify -Xbootclasspath/p:burp-loader.jar -jar burpsuite_pro_v2020.1.jar &
    # /opt/jdk/bin/java -noverify -Xbootclasspath/p:burp-loader.jar -jar burpsuite_pro_v2020.1.jar 2> $1
fi
