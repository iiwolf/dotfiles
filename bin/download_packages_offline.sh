#!/bin/bash
# download_packages_offline : download a package and all its dependecies for offline
# install via USB
PACKAGE=$1
apt-get download $PACKAGE && \
    apt-cache depends -i $PACKAGE \
    | awk '/Depends:/ {print $2}' \
    | xargs  apt-get download