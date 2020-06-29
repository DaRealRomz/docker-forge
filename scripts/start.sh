#!/bin/bash
set -e

# default JVM args
JVM_ARGS=${JVM_ARGS:--Xms1024M -Xmx1024M}

# build spigot if it does not exist
if [ ! -e $HOME/jars/minecraft_server.$VERSION.jar ]
then
  build.sh $VERSION
fi

# move to the server directory
cd $HOME/data

# accept the eula
if [ "$EULA" = "true" ] && ( [ ! -e eula.txt ] || [ -n $(grep "eula=false" eula.txt) ] )
then
  rm -f eula.txt
  echo eula=true > eula.txt
fi

# create the stdin pipe for the server console
rm -f $HOME/run/console
mkfifo $HOME/run/console

# start the server
java $JVM_ARGS -jar $HOME/jars/minecraft_server.$VERSION.jar nogui < <(tail -f $HOME/run/console)
rm -f rm -f $HOME/run/console
