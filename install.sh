#!/usr/bin/env bash

if $( ! command -v git > /dev/null); then
    yum -y install https://centos7.iuscommunity.org/ius-release.rpm
fi

yum update -y

for i in $PACKAGES; do
	if yum list installed $i > /dev/null; then
		echo "$i already installed, skipping"
	else
		echo "Installing $i"
		yum install -y $i
	fi
done