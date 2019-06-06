#!/bin/bash

distro () {
    local DISTRO_NAME DISTRO_DATA DISTRO_STR
    for line in `cat /etc/*-release`; do
        if [[ $line =~ ^(NAME|DISTRIB_ID)=(.+)$ ]]; then
            DISTRO_STR=${BASH_REMATCH[2]}
            if echo $DISTRO_STR | grep -q ['ubuntu','debian','mint']; then
                DISTRO_NAME='debian'
            elif echo $DISTRO_STR | grep -q ['fedora']; then
                DISTRO_NAME='fedora'
            elif echo $DISTRO_STR | grep -q ['arch','manjaro','antergos','parabola','anarchy']; then
                DISTRO_NAME='arch'
            fi
            break
        fi
    done
    # plain arch installation doesn't guarantee /etc/os-release
    # but the filesystem pkg installs a blank /etc/arch-release
    if [ -z "$DISTRO_NAME" ]; then
        if [ -e /etc/arch-release ]; then
        DISTRO_NAME='arch'
        fi
    fi
    # TODO: if os is not detected, try package-manager detection (not 100% reliable)
    echo $DISTRO_NAME
}

if [ `distro` == 'debian' ]; then
    echo 'Hi'
else
    echo 'Hello'
fi