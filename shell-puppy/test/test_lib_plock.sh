$PRINT "Test Required Global Variables ..."
$PRINT "PROGNAME_SP=$PROGNAME_SP"
$PRINT "Test Required Global Variables, done."
$PRINT "#################################################"
$PRINT
$PRINT

$PRINT "Test function InitPLocks_sp, ..."
InitPLocks_sp find 5
$PRINT "Call \"InitPLocks_sp find 4\""
$PRINT "Test function InitPLocks_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function GetParaLock_sp and ReleaseParaLock_sp, ..."
myfind() {
    $PRINT "This is ${1}th sub-proc"
    while [ 1 ]; do
        $PRINT "Obtaining plock, call \"GetParaLock_sp find nowait\" ..."
        if myLock=`GetParaLock_sp find nowait` ; then
            $PRINT "Obtained plock, plock number = $myLock"
            $PRINT "Do something now ..."
            $SLEEP 10
            $LS > $TMP_SP/findlog.$1.$myLock 2>&1
            $PRINT "Release plock $myLock, call \"ReleaseParaLock_sp find $myLock\""
            ReleaseParaLock_sp find $myLock
            return
        else
            $PRINT "$1 is locked. Try again after 5 seconds."
            $SLEEP 5
            continue
        fi
    done
}

for i in `$SEQ 1 20`;do
    myfind $i &
    $SLEEP 1
done
wait
$PRINT "Test function GetParaLock_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test plock functions ..."
$PRINT "Test function ClearPLocks_sp, ..."
$PRINT "Call \"ClearPLocks_sp\" ..."
ClearPLocks_sp
$PRINT "Test function ClearPLocks_sp, done"
$PRINT "================================================="
$PRINT

$RM -f $TMP_SP/findlog.* 2>/dev/null

$PRINT "Test functions, done."
