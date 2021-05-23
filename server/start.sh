#!/bin/bash

aur_packages=""

source /server/aur.sh

# define pacman packages
pacman_packages="jre8-openjdk-headless jre11-openjdk-headless screen rsync"

curl -fsSL "https://repo.archlinuxcn.org/x86_64/glibc-linux4-2.33-4-x86_64.pkg.tar.zst" | bsdtar -C / -xvf -

# install compiled packages using pacman
pacman -S --needed $pacman_packages --noconfirm
pacman -S java-runtime-common

export JAVA_VERSION=$(echo "${JAVA_VERSION}" | sed -e 's~^[ \t]*~~;s~[ \t]*$~~')
if [[ ! -z "${JAVA_VERSION}" ]]; then
	echo "[info] JAVA_VERSION defined as '${JAVA_VERSION}'" | ts '%Y-%m-%d %H:%M:%.S'
else
	echo "[info] JAVA_VERSION not defined,(via -e JAVA_VERSION), defaulting to '8'" | ts '%Y-%m-%d %H:%M:%.S'
	export JAVA_VERSION="8"
fi
if [[ "${JAVA_VERSION}" == "8" ]]; then
	ln -fs /usr/lib/jvm/java-8-openjdk/jre/bin/java /usr/bin/java
	archlinux-java set java-8-openjdk/jre
elif [[ "${JAVA_VERSION}" == "11" ]]; then
	ln -fs /usr/lib/jvm/java-11-openjdk/bin/java /usr/bin/java
	archlinux-java set java-11-openjdk
else
	echo "[warn] Java version '${JAVA_VERSION}' not installed, defaulting to Java version 8" | ts '%Y-%m-%d %H:%M:%.S'
	ln -fs /usr/lib/jvm/java-8-openjdk/jre/bin/java /usr/bin/java
	archlinux-java set java-8-openjdk/jre
fi
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")

java -server -Xms5G -Xmx16G -XX:MaxPermSize=128M -jar /server/forge-1.12.2-14.23.5.2846-universal.jar
