$PRINT "Test Required Global Variables ..."
$PRINT "PROGNAME_SP=$PROGNAME_SP"
$PRINT "Test Required Global Variables, done."
$PRINT "#################################################"
$PRINT
$PRINT

$PRINT "Test functions ..."
$PRINT "Test function IsProcRunning_sp, ..."
if IsProcRunning_sp $$ ; then
    $PRINT "My process is $$"
else
    $PRINT "Process $$ is not running."
fi
$PRINT "Test function IsProcRunning_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function ProcWatchDog_sp, ..."
$PRINT "Call \"ProcWatchDog_sp 15 5 $APPHOME_SP/test/testSrv.sh\""
ProcWatchDog_sp 15 5 $APPHOME_SP/test/testSrv.sh / 2>/dev/null 1>/dev/null
my_ret=$?
$PRINT "Return code is $my_ret"
$PRINT "Return msg is \"$M_ProcWatchDog_sp\""
$PRINT "Test function ProcWatchDog_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function Pargs_sp, ..."
$PRINT "Call \"Pargs_sp $$\""
Pargs_sp $$
$PRINT "Test function Pargs_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function Penvs_sp, ..."
$PRINT "Call \"Penvs_sp $$\""
Penvs_sp $$
$PRINT "Test function Penvs_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function StartDaemon_sp, ..."
$PRINT "Call \"StartDaemon_sp $APPHOME_SP/test/testSrv.sh\""
StartDaemon_sp $APPHOME_SP/test/testSrv.sh
$PRINT "Test function StartDaemon_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function StopDaemon_sp, ..."
$SLEEP 10
$PRINT "Call \"StopDaemon_sp $APPHOME_SP/test/testSrv.sh\""
StopDaemon_sp $APPHOME_SP/test/testSrv.sh
$PRINT "Test function StopDaemon_sp, done"
$PRINT "================================================="
$PRINT

$RM -f $TMP_SP/testSrv.sh.txt 2>/dev/null
$RM -f $LOGS_SP/testSrv.sh.*

$PRINT "Test functions, done."
