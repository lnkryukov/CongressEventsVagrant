#!/usr/bin/env bash

yum update -y

for i in $PACKAGES; do
	if yum list installed $i > /dev/null; then
		echo "$i already installed, skipping"
	else
		echo "Installing $i"
		yum install -y $i
	fi
done