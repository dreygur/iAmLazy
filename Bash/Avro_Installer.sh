#!/bin/bash

function install() {
    # 
    # Installs ibus-avro
    #

    # Update Cache
    sudo apt update -y

    # Install the Must have packages
    sudo apt install -y git libibus-1.0-dev ibus autotools-dev automake autoconf gjs gir1.2-ibus-1.0 build-essential

    # Clone the base repo
    git clone git://github.com/sarim/ibus-avro.git
    cd ibus-avro

    # Make Configurations
    aclocal && autoconf && automake --add-missing
    ./configure --prefix=/usr

    # Install using cmake
    sudo make install

    # Make .deb
    # sudo checkinstall

    # Removing downloaded repo
    cd ..
    rm -rf ibus-avro

    # iBus must be restarted
    ibus restart
}

function remove() {
    #
    # Removes ibus-avro
    #

    rm ${pkgdatadir}/../ibus/component/ibus-avro.xml
    rm ${pkgdatadir}/../glib-2.0/schemas/com.omicronlab.avro.gschema.xml
    glib-compile-schemas ${pkgdatadir}/../glib-2.0/schemas/
    rm -rf ${pkgdatadir}
}

if [[ $1 == 'i' ]]; then
    install
elif [[ $1 == 'r' ]]; then
    remove
fi

exit
