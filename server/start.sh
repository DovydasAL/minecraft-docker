#!/bin/bash

# define pacman packages
pacman_packages="jre8-openjdk-headless jre11-openjdk-headless screen rsync"

# install compiled packages using pacman
if [[ ! -z "${pacman_packages}" ]]; then
	pacman -S --needed $pacman_packages --noconfirm
fi

ln -fs /usr/lib/jvm/java-11-openjdk/bin/java /usr/bin/java
archlinux-java set java-11-openjdk
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")

java -server -Xms5G -Xmx16G -XX:MaxPermSize=128M -jar forge-1.12.2-14.23.5.2846-universal.jar
