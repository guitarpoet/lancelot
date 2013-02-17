#!/bin/sh

##################################################
# $Id: testSrv.sh 5 2011-03-24 03:11:52Z Allen.Zhao@gmail.com $
##################################################
# @ File: testSrv.sh
# @ Description: This is test script for shell-puppy
# @ Author: Allen Zhao
# @ Email: allen.zhao@gmail.com
# @ End of file
##################################################
APP_VERSION="0.1"

##################################################
# Initialization
##################################################
# Setup the env
PROGNAME_SP=`basename $0`
PATHNAME_SP=`dirname $0`
confFile_SP=$PATHNAME_SP/../conf/config.sh
if [ -r $confFile_SP ]; then
    . $confFile_SP 2>&1 1>/dev/null
else
    echo "$confFile_SP not found! Exit." 1>&2
    exit 1
fi

##################################################
# Main
##################################################
while [ 1 ] ; do
    $SLEEP 1
    $PRINT "`GetTimeStamp_sp` - echo" >> $TMP_SP/${PROGNAME_SP}.txt
done

# End of script
