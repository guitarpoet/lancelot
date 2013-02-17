$PRINT "Test Required Global Variables ..."
$PRINT "LOGS_SP=$LOGS_SP"
$PRINT "PROGNAME_SP=$PROGNAME_SP"
$PRINT "Test Required Global Variables, done."
$PRINT "#################################################"
$PRINT
$PRINT

$PRINT "Test Global Variables ..."
$PRINT "LOG_DEBUG_SP=$LOG_DEBUG_SP"
$PRINT "LOG_ERROR_SP=$LOG_ERROR_SP"
$PRINT "LOG_INFO_SP=$LOG_INFO_SP"
$PRINT "LOG_WARN_SP=$LOG_WARN_SP"
$PRINT "Test Global Variables, done."
$PRINT "#################################################"
$PRINT
$PRINT

$PRINT "Test log functions ..."
$PRINT "Call InitLog_sp"
$PRINT "Default handler = 0"
InitLog_sp
lh=0
$PRINT "Write debug msg to log handler $lh"
Log_sp $lh $LOG_DEBUG_SP "Log msg debug"
$PRINT "Write info msg to log handler $lh"
Log_sp $lh $LOG_INFO_SP "Log msg info"
$PRINT "Write warnning msg to log handler $lh"
Log_sp $lh $LOG_WARN_SP "Log msg warnning"
$PRINT "Write error msg to log handler $lh"
Log_sp $lh $LOG_ERROR_SP "Log msg error"
$PRINT "==============================================="
$PRINT

$PRINT "Log handler 1 is not initialized"
lh=1
$PRINT "Write debug msg to log handler $lh"
Log_sp $lh $LOG_DEBUG_SP "Log msg debug"
$PRINT "Write info msg to log handler $lh"
Log_sp $lh $LOG_INFO_SP "Log msg info"
$PRINT "Write warnning msg to log handler $lh"
Log_sp $lh $LOG_WARN_SP "Log msg warnning"
$PRINT "Write error msg to log handler $lh"
Log_sp $lh $LOG_ERROR_SP "Log msg error"
$PRINT "==============================================="
$PRINT

$PRINT "InitLog_sp -h $lh -p mylog"
InitLog_sp -h $lh -p mylog
$PRINT "Write debug msg to log handler $lh"
Log_sp $lh $LOG_DEBUG_SP "Log msg debug"
$PRINT "Write info msg to log handler $lh"
Log_sp $lh $LOG_INFO_SP "Log msg info"
$PRINT "Write warnning msg to log handler $lh"
Log_sp $lh $LOG_WARN_SP "Log msg warnning"
$PRINT "Write error msg to log handler $lh"
Log_sp $lh $LOG_ERROR_SP "Log msg error"
$PRINT "==============================================="
$PRINT

lh=2
$PRINT "InitLog_sp -h $lh -p mylog2 -s -l \$LOG_INFO_SP"
InitLog_sp -h $lh -p mylog2 -s -l $LOG_INFO_SP
$PRINT "Write debug msg to log handler $lh"
Log_sp $lh $LOG_DEBUG_SP "Log msg debug"
$PRINT "Write info msg to log handler $lh"
Log_sp $lh $LOG_INFO_SP "Log msg info"
$PRINT "Write warnning msg to log handler $lh"
Log_sp $lh $LOG_WARN_SP "Log msg warnning"
$PRINT "Write error msg to log handler $lh"
Log_sp $lh $LOG_ERROR_SP "Log msg error"
$PRINT "==============================================="
$PRINT

lh=3
$PRINT "InitLog_sp -h $lh -p mylog3 -d $TMP_SP -l \$LOG_WARN_SP"
InitLog_sp -h $lh -p mylog3 -d $TMP_SP -l $LOG_WARN_SP
$PRINT "Write debug msg to log handler $lh"
Log_sp $lh $LOG_DEBUG_SP "Log msg debug"
$PRINT "Write info msg to log handler $lh"
Log_sp $lh $LOG_INFO_SP "Log msg info"
$PRINT "Write warnning msg to log handler $lh"
Log_sp $lh $LOG_WARN_SP "Log msg warnning"
$PRINT "Write error msg to log handler $lh"
Log_sp $lh $LOG_ERROR_SP "Log msg error"
$PRINT "==============================================="
$PRINT

for lh in 0 1 2 3 ; do
    for level in $LOG_DEBUG_SP $LOG_INFO_SP $LOG_WARN_SP $LOG_ERROR_SP ; do
        $PRINT "Write log msg with log level $level to handler $lh"
        Log_sp $lh $level "Log msg with log level $level"
        $PRINT "Write log msg with log level $level thru log pipe, hanlder $lh"
        $PRINT "Log pipe msg with level $level" | LogPipe_sp $lh $level
    done
done

$PRINT "Clean up logs"
$RM $LOGS_SP/test.sh.*.log $LOGS_SP/mylog.*.log $LOGS_SP/mylog2.*.log $TMP_SP/mylog3.*.log
$PRINT "Test functions, done."
