##################################################
# $Id: lib_11_log.sh 13 2011-03-27 00:19:04Z Allen.Zhao@gmail.com $
##################################################
# @ File: lib_log.sh
# @ Description: Log shell functions.
# @ Description: Support unlimited log files in one script
# @ Dependency: lib_dt.sh, lib_misc.sh
# @ Author: Allen Zhao
# @ Email: allen.zhao@gmail.com
# @ End of file
##################################################
# @ Required Global Variable: LOGS_SP - The default log directory
# @ Required Global Variable: PROGNAME_SP - The top script name must be initianlized in your own script. Please see template.sh.
# @ Global Variable: LOG_DEBUG_SP - The log level debug
# @ Global Variable: LOG_ERROR_SP - The log level error
# @ Global Variable: LOG_INFO_SP - The log level info
# @ Global Variable: LOG_WARN_SP - The log level warning
##################################################
# Local variables used in this lib only
##################################################
# Local Variable: LOCAL_LOGFILE_SP_xx - The log file for handler xx. Initialized by InitLog_sp.
# Local Variable: LOCAL_LOGONSCREEN_SP_xx - The flag (for handler xx) if print log information on screen. Initialized by InitLog_sp.
# Local Variable: LOCAL_LOGLEVEL_SP_xx - The log level for handler xx. Initialized by InitLog_sp.
##################################################
LOG_DEBUG_SP=4
LOG_INFO_SP=3
LOG_WARN_SP=1
LOG_ERROR_SP=0

##################################################
# Function: Private_GetLogPrefix_sp
# Description: Get/generate a log prefix
# Usage: Private_GetLogPrefix_sp prefix
# Parameter: prefix - The prefix passed in.
# Return: stdout
# End of function
##################################################
Private_GetLogPrefix_sp() {
    My_GetLogPrefix_sp_tmpPrefix=
    if [ -z "$1" ]; then
        if [ -z "$PROGNAME_SP" ]; then
            $PRINT "log"
        else
            $PRINT "$PROGNAME_SP"
        fi
    else
        $PRINT "$1"
    fi
}

##################################################
# Function: Private_FixLogLevel_sp
# Description: If a wrong level passed in, fix it
# Usage: Private_FixLogLevel_sp level
# Parameter: level - The user log level
# Return: stdout
# End of function
##################################################
Private_FixLogLevel_sp() {
    case $1 in
        $LOG_DEBUG_SP|$LOG_INFO_SP|$LOG_WARN_SP|$LOG_ERROR_SP)
            $PRINT "$1"
        ;;
        *)
            $PRINT "$LOG_DEBUG_SP"
        ;;
    esac
}

##################################################
# Function: Private_GetLogLevelTag_sp
# Description: Get the log level tag
# Usage: Private_GetLogLevelTag_sp level
# Parameter: level - The user log level
# Return: stdout
# End of function
##################################################
Private_GetLogLevelTag_sp() {
    case $1 in
        $LOG_ERROR_SP)
            $PRINT "Error"
        ;;
        $LOG_WARN_SP)
            $PRINT "Warn"
        ;;
        $LOG_INFO_SP)
            $PRINT "Info"
        ;;
        *)
            $PRINT "Debug"
        ;;
    esac
}

##################################################
# Function: Private_WriteLog_sp
# Description: Write log to file (and screen)
# Usage: Private_WriteLog_sp handler "msg"
# Parameter: handler - The log handler
# Parameter: level - The log msg level
# Parameter: msgs - The single line log msg
# Return: none
# End of function
##################################################
Private_WriteLog_sp() {
    My_WriteLog_sp_handler=$1
    My_WriteLog_sp_level=`Private_FixLogLevel_sp "$2"`
    shift 2
    $EVAL "My_WriteLog_sp_Logfile=\$LOCAL_LOGFILE_SP_$My_WriteLog_sp_handler"
    $EVAL "My_WriteLog_sp_OnScreen=\$LOCAL_LOGONSCREEN_SP_$My_WriteLog_sp_handler"
    $EVAL "My_WriteLog_sp_InitLevel=\$LOCAL_LOGLEVEL_SP_$My_WriteLog_sp_handler"
    if [ -z "$My_WriteLog_sp_Logfile" ]; then
        My_WriteLog_sp_OnScreen=y
        My_WriteLog_sp_InitLevel=$LOG_DEBUG_SP
    fi
    if [ $My_WriteLog_sp_InitLevel -lt $My_WriteLog_sp_level ]; then
        return
    fi
    My_WriteLog_sp_tag=`Private_GetLogLevelTag_sp $My_WriteLog_sp_level`
    My_WriteLog_sp_Now=[`GetTimeStamp_sp`]
    if [ ! -z "$My_WriteLog_sp_Logfile" ]; then
        if [ -w "$My_WriteLog_sp_Logfile" ]; then
            $PRINT "$My_WriteLog_sp_Now [$My_WriteLog_sp_tag] $*" >> $My_WriteLog_sp_Logfile
        fi
    fi
    if [ "$My_WriteLog_sp_OnScreen" = "y" ]; then
        $PRINT "$My_WriteLog_sp_Now [$My_WriteLog_sp_tag] $*" 1>&2
    fi
}

##################################################
# @ Function: Log_sp
# @ Description: Write log message to log
# @ Usage: Log_sp handler level msg1 msg2 ...
# @ Parameter: handler - The log handler
# @ Parameter: level - The log msg level
# @ Parameter: msgs - The log message - could be multiple lines
# @ Return: none
# @ Example:
# @   Log_sp 0 $LOG_DEBUG_SP "Save file ..."
# @ End of function
##################################################
Log_sp() {
    My_Log_sp_handler=$1
    My_Log_sp_level=$2
    shift 2
    $PRINT "$*" | while read My_Log_sp_TmpMsg ; do
        Private_WriteLog_sp $My_Log_sp_handler $My_Log_sp_level "$My_Log_sp_TmpMsg"
    done
}

##################################################
# @ Function: InitLog_sp
# @ Description: Init a log file
# @ Usage: InitLog_sp [-handler|-h log-handler] [-dir|-d logDir] [-prefix|-p logPrefix] [-screen|-s] [-level|-l logLevel]
# @ Parameter: -handler|-h log-handler - Specifiy log handerl. Must be digits or letters
# @ Parameter: -level|-l log-level - Specifiy initial log level
# @ Parameter: -dir|-d - Specify log directory
# @ Parameter: -prefix|-p - Specify log prefix
# @ Parameter: -screen|-s - Set screen flag.
# @ Return: none
# @ Example:
# @   InitLog_sp
# @       Initialize log handler 0 under default log-dir with prefix $PROGNAME or "log"
# @   InitLog_sp -x blah
# @       You provide wrong information. So it does same as "InitLog_sp"
# @   InitLog_sp -h 4 -d $My_LogDir -p sysBackup -s
# @       Initialize log handler 4 under default $My_LogDir with prefix sysBackup and print log on screen too
# @ End of function
##################################################
InitLog_sp() {
    My_InitLog_sp_Handler=0
    My_InitLog_sp_LogDir="$LOGS_SP"
    My_InitLog_sp_Prefix=`Private_GetLogPrefix_sp`
    My_InitLog_sp_Screen=n
    My_InitLog_sp_Level=$LOG_DEBUG_SP
    while [ $# -ne 0 ]; do
        case "$1" in
            -handler|-h)
                My_InitLog_sp_Handler="$2"
                shift 2
            ;;
            -dir|-d)
                My_InitLog_sp_LogDir="$2"
                shift 2
            ;;
            -prefix|-p)
                My_InitLog_sp_Prefix=`Private_GetLogPrefix_sp "$2"`
                shift 2
            ;;
            -level|-l)
                case "$2" in
                    $LOG_DEBUG_SP|$LOG_INFO_SP|$LOG_WARN_SP|$LOG_ERROR_SP)
                        My_InitLog_sp_Level="$2"
                    ;;
                esac
                shift 2
            ;;
            -screen|-s)
                My_InitLog_sp_Screen="y"
                shift
            ;;
            *)
                break
            ;;
        esac
    done
    
    if [ -w "$My_InitLog_sp_LogDir" -a -d "$My_InitLog_sp_LogDir" ]; then
        My_InitLog_sp_DoNothing=
    else
        My_InitLog_sp_LogDir="$LOGS_SP"
    fi
    IsAlphaNumeric_sp "$My_InitLog_sp_Handler" || My_InitLog_sp_Handler=0
    My_InitLog_sp_tmpLogFile="$My_InitLog_sp_LogDir/${My_InitLog_sp_Prefix}.`GetTimeStamp2_sp`.log"
    $EVAL "LOCAL_LOGFILE_SP_${My_InitLog_sp_Handler}=$My_InitLog_sp_tmpLogFile"
    $EVAL "LOCAL_LOGONSCREEN_SP_${My_InitLog_sp_Handler}=$My_InitLog_sp_Screen"
    $EVAL "LOCAL_LOGLEVEL_SP_${My_InitLog_sp_Handler}=$My_InitLog_sp_Level"
    $TOUCH $My_InitLog_sp_tmpLogFile
    Private_WriteLog_sp "$My_InitLog_sp_Handler" $LOG_INFO_SP "Log Initialized."
}

##################################################
# @ Function: LogPipe_sp
# @ Description: Read log msg from pipeline and write Info log
# @ Usage: | LogPipe_sp handler level
# @ Parameter: handler - The log handler
# @ Parameter: level - The log level
# @ Return: none
# @ Example:
# @   MyProg | LogPipe_sp 0 $LOG_DEBUG_SP
# @ End of function
##################################################
LogPipe_sp() {
    My_LogPipe_sp_handler=$1
    My_LogPipe_sp_level=$2
    while read My_LogPipe_sp_TmpMsg ; do
        Private_WriteLog_sp "$My_LogPipe_sp_handler" "$My_LogPipe_sp_level" "$My_LogPipe_sp_TmpMsg"
    done
}

# End of script
