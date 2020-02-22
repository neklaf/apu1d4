#!/bin/sh
# pfSense-install-FreeBSD-Package.sh
# @javcasta - Javier Castañon - 2016 - https://javcasta.com/
###############################################################
# Install FreeBSD package at pfSense 2.x.x
# Use # sh pfSense-install-FreeBSD-Package.sh <FreeBSD-Package>
###############################################################
# Updated by @AitorAcedo - Aitor Acedo 2020 - https://neklaf.wordpress.com/
# Modified script to work with additional pfSense versions 2.4.x
###############################################################

# FreeBSD: { enabled: no } =>  FreeBSD: { enabled: yes }
# /usr/local/share/pfSense/pkg/repos/pfSense-repo.conf
# /usr/local/etc/pkg/repos/FreeBSD.conf

if [ $# -eq 0 ]
  then
    echo "No package supplied"
    exit 1
fi

FAUX="/tmp/fauxf2b.tmp"
FILE1="/usr/local/share/pfSense/pkg/repos/pfSense-repo.conf"
cp $FILE1 /usr/local/share/pfSense/pkg/repos/pfSense-repo.conf.back
FILE2="/usr/local/etc/pkg/repos/FreeBSD.conf"
cp $FILE2 /usr/local/etc/pkg/repos/FreeBSD.conf.back
NOFREEBSD="FreeBSD: { enabled: no }"
YESFREEBSD="FreeBSD: { enabled: yes }"
sed "s|$NOFREEBSD|$YESFREEBSD|" $FILE1  > $FAUX
cp $FAUX $FILE1
sed "s|$NOFREEBSD|$YESFREEBSD|" $FILE2  > $FAUX
cp $FAUX $FILE2

PF_PKG=$(pkg info pfSense|head -1)
DNSMASQ_PKG=$(pkg info dnsmasq|head -1)
pkg bootstrap
pkg update
yes | pkg lock pkg
pkg lock ${PF_PKG}
pkg lock ${DNSMASQ_PKG}
echo " Install package $1"
yes | pkg install $1
yes | pkg unlock pkg
pkg unlock ${PF_PKG}
pkg unlock ${DNSMASQ_PKG}
#rehash

#back
sed "s|$YESFREEBSD|$NOFREEBSD|" $FILE1  > $FAUX
cp $FAUX $FILE1
sed "s|$YESFREEBSD|$NOFREEBSD|" $FILE2  > $FAUX
cp $FAUX $FILE2
