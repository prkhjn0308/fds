#!/bin/bash
SSH=
while getopts 'S:' OPTION
do
case $OPTION  in
  S)
   SSH="ssh $OPTARG"
   ;;
esac
done
shift $(($OPTIND-1))

lockfile=/tmp/startXlock
GETNEWPORT () 
{
  while [ -e $lockfile ] ; do
    echo waiting for lock file, $lockfile, to clear
    sleep 5
  done
  touch $lockfile
  chmod 777 $lockfile
  display_port=`id -u`
  nmatches=`ps a -e | grep $XVFB | grep $display_port | grep -v grep | wc | awk '{print $1}'`
  while [ $nmatches -ne 0 ] ; do
    display_port=`expr $display_port + 1`
    nmatches=`ps a -e | grep $XVFB | grep $display_port | grep -v grep | wc | awk '{print $1}'`
  done
}

XVFB="$SSH Xvfb"
echo XVFB=$XVFB
exit
echo setting up graphics environment
GETNEWPORT 
if [ "`uname`" == "Darwin" ]; then
  $XVFB :$display_port -screen 0 1280x1024x24 &
else
  $XVFB :$display_port -fp /usr/share/X11/fonts/misc -screen 0 1280x1024x24 &
  export SMV_ID=$!
fi
export DISPLAY=:$display_port
rm -f $lockfile
sleep 30
