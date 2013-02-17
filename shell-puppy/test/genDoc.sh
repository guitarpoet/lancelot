#!/bin/sh

##################################################
# $Id: genDoc.sh 19 2011-03-27 02:22:32Z Allen.Zhao@gmail.com $
##################################################
# @ File: genDoc.sh
# @ Description: Generate shell library docs
# @ Author: Allen Zhao
# @ Email: allen.zhao@gmail.com
# @ End of file
##################################################

usage() {
    DispOptionsUsage_sp genDoc -t "Shell Library Doc Generate Tool" \
       -d "This tool will scan the libraries under " \
       -d "    $SCRIPTS_SP" \
       -d "and generate docs under." \
       -d "    $APPHOME_SP/docs." \
       -d "Please report bug to allen.zhao@gmail.com"
}

genDocRef() {
    mfn=`$BASENAME $1`
    $PRINT "==================================================="
    $PRINT "$mfn"
    $PRINT "==================================================="
    $PRINT
    items=`GetLibRequiredVars $1`
    if [ ! -z "$items" ]; then
        $PRINT "Required Global Variables"
        $PRINT "---------------------------------------------------"
        for item in $items ; do
            $PRINT "  $item"
        done
        $PRINT "---------------------------------------------------"
        $PRINT
    fi

    items=`GetLibGlobalVars $1`
    if [ ! -z "$items" ]; then
        $PRINT "Global Variables"
        $PRINT "---------------------------------------------------"
        for item in $items ; do
            $PRINT "  $item"
        done
        $PRINT "---------------------------------------------------"
        $PRINT
    fi

    items=`GetLibFuncs $1`
    if [ ! -z "$items" ]; then
        $PRINT "Public Functions"
        $PRINT "---------------------------------------------------"
        for item in $items ; do
            $PRINT "  $item"
        done
        $PRINT "---------------------------------------------------"
        $PRINT
    fi
    $PRINT "==================================================="
    $PRINT "End of file $mfn"
    $PRINT "==================================================="
    $PRINT
    $PRINT
}

genDoc() {
    file=0
    $GREP '# @' $1 | while read ln ; do
        if [ $file -eq 0 ] ; then
            if $PRINT "$ln" | $GREP -i '# @ File:' 1>/dev/null ; then
                file=1
                $PRINT "$ln" | $SED -e 's/^# @ //g'
                $PRINT "=================================================="
            fi
        else
            if $PRINT "$ln" | $GREP -i '# @ End of file' 1>/dev/null ; then
                $PRINT "=================================================="
                break
            else
                $PRINT "$ln" | $SED -e 's/^# @ //g'
            fi
        fi
    done

    $PRINT
    $PRINT
    if $GREP -i '# @ Required Global' $1 1>/dev/null ; then
        $PRINT "Required Global Variable"
        $PRINT "--------------------------------------------------"
        $GREP -i '# @ Required Global' $1 | $SED -e 's/^# @ Required Global Variable: /    /g'
        $PRINT
        $PRINT
    fi

    if $GREP -i '# @ Global' $1 1>/dev/null ; then
        $PRINT "Global Variable"
        $PRINT "--------------------------------------------------"
        $GREP -i '# @ Global' $1 | $SED -e 's/^# @ Global Variable: /    /g'
        $PRINT
        $PRINT
    fi

    if $GREP -i '# @ Function: ' $1 1>/dev/null ; then 
        func=0
        $GREP '# @' $1 | while read ln ; do
            if [ $func -eq 0 ]; then
                if $PRINT "$ln" | $GREP -i '# @ Function: ' 1>/dev/null ; then
                    func=1
                    $PRINT "$ln" | $SED -e 's/^# @ //g'
                    $PRINT "--------------------------------------------------"
                else
                    continue
                fi
            elif [ $func -eq 1 ]; then
                if $PRINT "$ln" | $GREP -i '# @ End of function' 1>/dev/null ; then
                    func=0
                    $PRINT "--------------------------------------------------"
                    $PRINT
                    $PRINT
                else
                    $PRINT "$ln" | $SED -e 's/^# @ //g'
                fi
            fi
        done
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
AddOption_sp genDoc h help 0 n "Display this help"
AddOption_sp genDoc d doc 1 n "Specify the doc dir. -d doc-dir"

ParseOptions_sp genDoc "$@"

if HasOption_sp genDoc h ; then
    usage
    exit 0
fi
myDocs=
if HasOption_sp genDoc d ; then
    myDocs==`GetOptionValue_sp genDoc d`
fi

if [ -z "$myDocs" ] || ! CheckDir_sp "$myDocs" -a ; then
    myDocs=$APPHOME_SP/docs
fi

. $APPHOME_SP/test/lib_doc.sh

docRef=$myDocs/LibDocQuickRef.txt
docPostfix=doc.txt
RemoveTemp_sp "$docRef"
for lib in `cd $SCRIPTS_SP; $LS lib_*.sh`; do
    alib=`$PRINT "$lib" | $CUT -d '_' -f3`
    $PRINT "Generate docs for $lib ..."
    genDocRef $SCRIPTS_SP/$lib >> $docRef
    genDoc $SCRIPTS_SP/$lib > $myDocs/${lib}.$docPostfix
    $PRINT "Generate docs for $lib, done"
done

# End of script
