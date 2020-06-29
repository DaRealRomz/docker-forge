#!/bin/bash
set -e

rm -rf /tmp/forge-install
mkdir -p /tmp/forge-install
cd /tmp/forge-install
wget https://files.minecraftforge.net/maven/net/minecraftforge/forge/$1/forge-$1-installer.jar
java -jar forge-$1-installer.jar --installServer minecraft_server.$1.jar
mv minecraft_server.$1.jar $HOME/jars/
cd -
rm -rf /tmp/forge-install
