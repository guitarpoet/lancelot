$PRINT "Test Required Global Variables ..."
$PRINT "PROGNAME_SP=$PROGNAME_SP"
$PRINT "Test Required Global Variables, done."
$PRINT "#################################################"
$PRINT
$PRINT

$PRINT "Test functions ..."
$PRINT "Test function LockMe_sp, ..."
$PRINT "Already included in test.sh, skip."
$PRINT "Test function LockMe_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function AmILocked_sp, ..."
if AmILocked_sp ; then
    $PRINT "The process `GetLockProcess_sp` own the lock"
else
    $PRINT "No lock found!"
fi
$PRINT "Test function AmILocked_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function UnlockMe_sp, ..."
$PRINT "Already included in test.sh, skip."
$PRINT "Test function UnlockMe_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test functions, done."
