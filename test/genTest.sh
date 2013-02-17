#!/bin/sh

##################################################
# $Id: genTest.sh 5 2011-03-24 03:11:52Z Allen.Zhao@gmail.com $
##################################################
# @ File: genTest.sh
# @ Description: Generate test script for all libs
# @ Author: Allen Zhao
# @ Email: allen.zhao@gmail.com
# @ End of file
##################################################

usage() {
    DispOptionsUsage_sp genTest -t "Test Generate Tool" -d "This tool will generate test scripts under:" \
       -d "    $APPHOME_SP/tmp." \
       -d "The test will echo all global variables and put a function invoker." \
       -d "Please report bug to allen.zhao@gmail.com"
}

genFunc() {
        items=`GetLibRequiredVars $1`
        if [ ! -z "$items" ]; then
            $PRINT '$PRINT "Test Required Global Variables ..."'
            for item in $items ; do
                $PRINT "\$PRINT \"$item=\$$item\""
            done
            $PRINT '$PRINT "Test Required Global Variables, done."'
            $PRINT '$PRINT "#################################################"'
            $PRINT '$PRINT'
            $PRINT '$PRINT'
            $PRINT
        fi

        items=`GetLibGlobalVars $1`
        if [ ! -z "$items" ]; then
            $PRINT '$PRINT "Test Global Variables ..."'
            for item in $items ; do
                $PRINT "\$PRINT \"$item=\$$item\""
            done
            $PRINT '$PRINT "Test Global Variables, done."'
            $PRINT '$PRINT "#################################################"'
            $PRINT '$PRINT'
            $PRINT '$PRINT'
            $PRINT
        fi

        items=`GetLibFuncs $1`
        if [ ! -z "$items" ]; then
            $PRINT '$PRINT "Test functions ..."'
            for item in $items ; do
                $PRINT "\$PRINT \"Test function $item, ...\""
                $PRINT "$item"
                $PRINT "\$PRINT \"Test function $item, done\""
                $PRINT '$PRINT "================================================="'
                $PRINT '$PRINT'
                $PRINT
            done
            $PRINT '$PRINT "Test functions, done."'
        fi
}
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
# Put your own code below
##################################################
AddOption_sp genTest h help 0 n "Display this help"
AddOption_sp genTest t tmp 1 n "Specify the tmp dir. -t tmp-dir"

ParseOptions_sp genTest "$@"

if HasOption_sp genTest h ; then
    usage
    exit 0
fi
myTmp=
if HasOption_sp genTest t ; then
    myTmp==`GetOptionValue_sp genTest t`
fi

if [ -z "$myTmp" ] || ! CheckDir_sp "$myTmp" -a ; then
    myTmp=$TMP_SP
fi

. $APPHOME_SP/test/lib_doc.sh

for lib in `cd $SCRIPTS_SP; $LS lib_*.sh`; do
    alib=`$PRINT "$lib" | $CUT -d '_' -f3`
    $PRINT "Generate test script for $lib ..."
    genFunc $SCRIPTS_SP/$lib > $myTmp/test_lib_$alib
    $PRINT "Generate test script for $lib, done"
done

# End of script
