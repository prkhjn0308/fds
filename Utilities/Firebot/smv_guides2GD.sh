#!/bin/bash

CURDIR=`pwd`
PARENT_ID=0B_wB1pJL2bFQfmlYRUhYMk85R25DQ2k3RVAyNGQtV2ItaGZPNHA3d1hkdUtCeFVyNDNyREk
FROMDIR=~smokebot/smokebot/output
BASEDIR=Newest_Guides
UPDATE_GUIDES=$FROMDIR/$BASEDIR/update_guides

UPLOAD ()
{
  FILE=$1
  FILEnew=${FILE}_new.pdf
  cp $FILE.pdf /tmp/$FILEnew
  drive list  | grep $FILEnew | awk '{ system("drive delete -i " $1)} '
  drive upload -p $PARENT_ID -f /tmp/$FILEnew
}

#if [ -e $UPDATE_GUIDES ] ; then
  cd $FROMDIR/$BASEDIR
  rm -f $UPDATE_GUIDES
  UPLOAD SMV_User_Guide
  UPLOAD SMV_Technical_Reference_Guide
  UPLOAD SMV_Verification_Guide
  cd $CURDIR
#fi
