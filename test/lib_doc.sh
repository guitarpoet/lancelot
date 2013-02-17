##################################################
# $Id: lib_doc.sh 13 2011-03-27 00:19:04Z Allen.Zhao@gmail.com $
##################################################
# @ File: lib_doc.sh
# @ Description: Source code doc tool
# @ Author: Allen Zhao
# @ Email: allen.zhao@gmail.com
# @ End of file
##################################################

GetLibGlobalVars() {
    $GREP '# @ Global Variable' $1 | $SED -e 's/^.*: \(.*\) - .*/\1/g'
}

GetLibFuncs() {
    $GREP '# @ Function' $1 | $SED -e 's/^.*: \(.*\)/\1/g'
}

GetLibRequiredVars() {
    $GREP '# @ Required Global Variable' $1 | $SED -e 's/^.*: \(.*\) - .*/\1/g'
}

GenDoc() {
    if [ ! -r $1 ]; then
        return 1
    fi
    firstFunc=1
    $GREP '^# @' $1 | while read ln ; do
        if $PRINT "$ln" | $GREP -i '^# @ End of file' 1>/dev/null ; then
            $PRINT
            $PRINT
            continue
        fi
        if $PRINT "$ln" | $GREP -i '^# @ Function' 1>/dev/null ; then
            if [ $firstFunc -eq 1 ]; then
                $PRINT
            fi
            $PRINT
        fi

        $PRINT "$ln" | $SED -e 's/^# @ //g'
    done
}

# End of script
