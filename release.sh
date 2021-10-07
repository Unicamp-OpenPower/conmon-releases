#!/usr/bin/env bash
github_version=$(cat github_version.txt)
ftp_version=$(cat ftp_version.txt)
ROOTPATH="~/rpmbuild/RPMS/ppc64le"
LOCALPATH="../conmon/bin"
REPO1="/repository/debian/ppc64el/containers"
REPO2="/repository/rpm/ppc64le/containers"

if [ "$github_version" != "$ftp_version" ]
  then
    git clone https://$USERNAME:$TOKEN@github.com/Unicamp-OpenPower/repository-scrips.git
    cd repository-scrips/
    chmod +x empacotar-deb.sh
    chmod +x empacotar-rpm.sh
    sudo mv empacotar-deb.sh $LOCALPATH
    sudo mv empacotar-rpm.sh $LOCALPATH
    cd $LOCALPATH
    sudo ./empacotar-deb.sh conmon conmon-$github_version $github_version "gcc, libc6-dev, libglib2.0-dev, pkg-config, runc"
    sudo ./empacotar-rpm.sh conmon conmon-$github_version $github_version "gcc, glib2-devel, glibc-devel, pkgconfig, runc" "An OCI container runtime monitor"

    sudo lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O $REPO1 conmon-$github_version-ppc64le.deb"
    sudo lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O $REPO2 $ROOTPATH/conmon-$github_version-1.ppc64le.rpm"
fi
