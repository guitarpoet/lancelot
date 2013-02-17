#!/bin/sh

##################################################
# $Id: test.sh 11 2011-03-25 03:25:12Z Allen.Zhao@gmail.com $
##################################################
# @ File: test.sh
# @ Description: This is test script for shell-puppy
# @ Author: Allen Zhao
# @ Email: allen.zhao@gmail.com
# @ End of file
##################################################
TEST_VERSION="0.1"

##################################################
# Put your functions here
##################################################
ListTests() {
    My_list=`( $CD $APPHOME_SP/test; $LS test_*.sh 2>/dev/null) | $SED -e 's/^test_//g' -e 's/\.sh//g'`
    if [ -z "$My_list" ]; then
        $PRINT "No test found!"
        return 1
    else
        $PRINT "$My_list"
    fi
}

RunAllTests() {
    if My_testlist=`ListTests` ; then
        My_RunAllTests_DoNothing=
    else
        return 1
    fi
    for my_test in $My_testlist ; do
        RunTest $my_test
        $PRINT
        $PRINT
        $PRINT
    done
}

PrintHeader() {
$CAT <<HERE
=========================================================
                    Test: $1
=========================================================
Begin: `$DATE`
=========================================================
HERE
}

PrintTestFooter() {
$CAT <<HERE
=========================================================
                 Test: $1 is done
=========================================================
End: `$DATE`
=========================================================
HERE
}

RunTest() {
    my_test="$APPHOME_SP/test/test_${1}.sh"
    if CheckFile_sp "$my_test" -r -s -x ; then
        PrintHeader "$1"
        . $my_test
        PrintTestFooter "$1"
    else
        PrintError_sp "Invalid test file: $my_test"
        return 1
    fi
}

##################################################
# @ Function: usage
# @ Description: Display usage
# @ Usage: usage
# @ Return: none
# @ Example:
# @   usage
# @ End of function
##################################################
usage() {
    DispOptionsUsage_sp test -t "Shell-puppy test tool v$TEST_VERSION" -d "This is a test tool for shell-putty." \
       -d "You must put all your tests under:" \
       -d "    $APPHOME_SP/test." \
       -d "The test file should be named as test_YourName.sh" \
       -d "Please report bug to allen.zhao@gmail.com"
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

##################################################
# Set the command line options
##################################################
AddOption_sp test h help 0 n "Display this help"
AddOption_sp test a all 0 n "Run all tests"
AddOption_sp test l list 0 y "List all tests"
AddOption_sp test r run 1 n "Run a test. -r test-name"

ParseOptions_sp test "$@"

LockMe_sp
if HasOption_sp test l ; then
    ListTests
    UnlockMe_sp
    exit $?
fi

if HasOption_sp test a ; then
    RunAllTests
    UnlockMe_sp
    exit $?
fi

if HasOption_sp test r ; then
    My_test=`GetOptionValue_sp test r`
    RunTest $My_test
    UnlockMe_sp
    exit $?
fi

UnlockMe_sp

usage

# End of script
