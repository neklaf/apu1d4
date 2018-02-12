#!/bin/sh
# pfSense-install-FreeBSD-Package.sh
# @javcasta - Javier Casta?non - 2016 - https://javcasta.com/
###############################################################
# Install FreeBSD package at pfSense 2.3
# Use # sh pfSense-install-FreeBSD-Package.sh <FreeBSD-Package>
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

pkg bootstrap
pkg update
yes | pkg lock pkg
pkg lock pfSense-2.3.2
pkg lock dnsmasq-devel
echo " Install package $1"
yes | pkg install $1
yes | pkg unlock pkg
pkg unlock pfSense-2.3.2
pkg unlock dnsmasq-devel
#rehash

#back
sed "s|$YESFREEBSD|$NOFREEBSD|" $FILE1  > $FAUX
cp $FAUX $FILE1
sed "s|$YESFREEBSD|$NOFREEBSD|" $FILE2  > $FAUX
cp $FAUX $FILE2

[root@pf ~/soft]# vi pfSense-install-FreeBSD-Package.sh 

#!/bin/sh
# pfSense-install-FreeBSD-Package.sh
# @javcasta - Javier Casta?non - 2016 - https://javcasta.com/
###############################################################
# Install FreeBSD package at pfSense 2.3
# Use # sh pfSense-install-FreeBSD-Package.sh <FreeBSD-Package>
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

pkg bootstrap
pkg update
yes | pkg lock pkg
pkg lock pfSense-2.3.2
pkg lock dnsmasq-devel
echo " Install package $1"
yes | pkg install $1
yes | pkg unlock pkg
pkg unlock pfSense-2.3.2
pkg unlock dnsmasq-devel
#rehash

#back
sed "s|$YESFREEBSD|$NOFREEBSD|" $FILE1  > $FAUX
cp $FAUX $FILE1
sed "s|$YESFREEBSD|$NOFREEBSD|" $FILE2  > $FAUX
cp $FAUX $FILE2
