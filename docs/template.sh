#!/bin/sh

##################################################
# $Id: template.sh 5 2011-03-24 03:11:52Z Allen.Zhao@gmail.com $
##################################################
# @ File: template.sh
# @ Description: This is a script template file
# @ Description: Use this one as your start point
# @ Author: Your Name
# @ Email: Your.Name@YourCompany.com
# @ End of file
##################################################
TEMPLATE_VERSION="0.1"

##################################################
# Put your functions here
##################################################

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
    DispOptionsUsage_sp template -t "Shell-puppy template script" -d "This is an example script." \
       -d "Please report bug to YourName@YourCompany.com"
}

doList() {
    $PRINT "You call list function"
}

doRun() {
    $PRINT "You call run function with arg $1"
}

doAll() {
    $PRINT "You call all function"
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
AddOption_sp template h help 0 n "Display this help"
AddOption_sp template a all 0 n "Run all tests"
AddOption_sp template l list 0 n "List all tests"
AddOption_sp template r run 1 n "Run a test. -r test-name"

ParseOptions_sp template "$@"

if HasOption_sp template l ; then
    doList
    exit $?
fi

if HasOption_sp template a ; then
    doAll
    exit $?
fi

if HasOption_sp template r ; then
    My_val=`GetOptionValue_sp template r`
    doRun $My_val
    exit $?
fi

usage

# End of script

