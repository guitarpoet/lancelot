##################################################
# $Id: lib_13_process.sh 13 2011-03-27 00:19:04Z Allen.Zhao@gmail.com $
##################################################
# @ File: lib_process.sh
# @ Description: Common Process shell functions.
# @ Dependency: lib_misc.sh, lib_os.sh, lib_dt.sh
# @ Author: Allen Zhao
# @ Email: allen.zhao@gmail.com
# @ End of file
##################################################
# @ Required Global Variable: PROGNAME_SP - The top script name must be initianlized in your own script. Please see template.sh.
##################################################
# Local Variable: LOCAL_PROC_TIMEOUT_SP - Default process timeout
# Local Variable: LOCAL_PROC_INTVAL_SP - Default process check interval
##################################################
LOCAL_PROC_TIMEOUT_SP=1800
LOCAL_PROC_INTVAL_SP=30

##################################################
# @ Function: IsProcRunning_sp
# @ Description: Check if a process is running
# @ Usage: IsProcRunning_sp pid
# @ Parameter: pid
# @ Return: return code
# @ Example:
# @   IsProcRunning_sp 1234
# @ End of function
##################################################
IsProcRunning_sp() {
    if [ -z "$1" ]; then
        return 1
    fi
    if [ -d "/proc/$1" ]; then
        return 0
    fi
    return 1
}

##################################################
# @ Function: ProcWatchDog_sp
# @ Description: Run a process and wathc it. If is not finished in certain time, terminate it.
# @ Usage: ProcWatchDog_sp timeout check-interval program args
# @ Parameter: timeout - If procese run time over this, it will be killed
# @ Parameter: check-interval - Process check interval
# @ Return: return code
# @ Example:
# @   ProcWatchDog_sp 3600 60 My_Prog arg1 arg2
# @ End of function
##################################################
ProcWatchDog_sp() {
    M_ProcWatchDog_sp_TimeOut=$LOCAL_PROC_TIMEOUT_SP
    M_ProcWatchDog_sp_Intval=$LOCAL_PROC_INTVAL_SP
    if IsDigits_sp "$1" ; then
        M_ProcWatchDog_sp_TimeOut=$1
    fi
    if IsDigits_sp "$2" ; then
        M_ProcWatchDog_sp_Intval=$2
    fi
    shift; shift
    "$@" &
    M_ProcWatchDog_sp_PID=$!
    M_ProcWatchDog_sp_MILES=0
    while [ 1 ]; do
        $SLEEP $M_ProcWatchDog_sp_Intval
        IsProcRunning_sp $M_ProcWatchDog_sp_PID || break
        M_ProcWatchDog_sp_MILES=`$EXPR $M_ProcWatchDog_sp_MILES + $M_ProcWatchDog_sp_Intval`
        if [ $M_ProcWatchDog_sp_MILES -ge $M_ProcWatchDog_sp_TimeOut ]; then
            M_ProcWatchDog_sp="Processing: $M_ProcWatchDog_sp_PID running over $M_ProcWatchDog_sp_TimeOut, killed!"
            $KILL -9 $M_ProcWatchDog_sp_PID 1>/dev/null 2>/dev/null
            return 99
        fi
    done
    wait $M_ProcWatchDog_sp_PID
    M_ProcWatchDog_sp="M_ProcWatchDog_sp_PID is done."
    return $?
}

##################################################
# @ Function: Pargs_sp
# @ Description: A replacement of Solaris pargs
# @ Usage: Pargs_sp pid
# @ Parameter: pid
# @ Return: stdout, exit code
# @ Example:
# @     Pargs_sp 1234
# @ End of function
##################################################
Pargs_sp() {
    case $OS_TYPE_SP in
        SunOS)
            if My_Pargs_sp_m=`$PARGS $1 2>/dev/null 2>/dev/null` ; then
                $PRINT "$My_Pargs_sp_m" | $SED -e 's/^argv\[[0-9]*\]: //g'
            else
                return 1
            fi ;;
        *)
            if [ -f /proc/$1/cmdline ]; then
                $CAT /proc/$1/cmdline  2>/dev/null | $TR "\0" "\n"
            else
                return 1
            fi
    esac
}

##################################################
# @ Function: Penvs_sp
# @ Description: A replacement of Solaris pargs -e
# @ Usage: Penvs_sp pid
# @ Parameter: pid
# @ Return: stdout, exit code
# @ Example:
# @     Penvs_sp 1234
# @ End of function
##################################################
Penvs_sp() {
    case $OS_TYPE_SP in
        SunOS)
            if My_Penvs_sp_m=`$PARGS -e $1 2>/dev/null 2>/dev/null` ; then
                $PRINT "$My_Penvs_sp_m" | $SED -e 's/^envp\[[0-9]*\]: //g'
            else
                return 1
            fi ;;
        *)
            if [ -f /proc/$1/environ ]; then
                $CAT /proc/$1/environ  2>/dev/null | $TR "\0" "\n"
            else
                return 1
            fi
    esac
}

##################################################
# @ Function: StartDaemon_sp
# @ Description: Start a script in daemon mode
# @ Usage: StartDaemon_sp /path/to/script script-args ...
# @ Parameter: /path/to/script
# @ Parameter: script-args
# @ Return: stdout, exit code
# @ Example:
# @     StartDaemon_sp /path/to/AppServer.sh -opt
# @ End of function
##################################################
StartDaemon_sp() {
    if [ $# -lt 1 ]; then
        M_StartDaemon_sp="Empty scirpt name."
        return 1
    fi
    if [ -x "$1" ] && [ -f "$1" ] && [ -r "$1" ] ; then
        My_StartDaemon_sp_script=$1
    else
        M_StartDaemon_sp="$1 is not a valid script or program."
        return 1
    fi
    shift
    My_StartDaemon_sp_short=`$BASENAME $My_StartDaemon_sp_script`
    My_StartDaemon_sp_lock="$RUN_SP/${My_StartDaemon_sp_short}.daemon.lock"
    if [ -f $My_StartDaemon_sp_lock ]; then
        My_StartDaemon_sp_pid=`$CAT $My_StartDaemon_sp_lock | $HEAD -1 | $AWK '{print $1}'`
        if IsProcRunning_sp $My_StartDaemon_sp_pid ; then
            M_StartDaemon_sp="$My_StartDaemon_sp_short is already running. PID is $My_StartDaemon_sp_pid."
            return 2
        fi
    fi
    My_StartDaemon_sp_tm=`GetTimeStamp2_sp`
    $TOUCH $My_StartDaemon_sp_lock 2>/dev/null
    $NOHUP $My_StartDaemon_sp_script "$@" 1>$LOGS_SP/${My_StartDaemon_sp_short}.out.$My_StartDaemon_sp_tm 2>$LOGS_SP/${My_StartDaemon_sp_short}.err.$My_StartDaemon_sp_tm &
    My_StartDaemon_sp_pid=$!
    $PRINT $My_StartDaemon_sp_pid > $My_StartDaemon_sp_lock
    M_StartDaemon_sp="$My_StartDaemon_sp_short started as daemon. PID $My_StartDaemon_sp_pid"
    return 0
}

##################################################
# @ Function: StopDaemon_sp
# @ Description: Stop a running daemon (kill -9)
# @ Usage: StopDaemon_sp /path/to/script
# @ Parameter: /path/to/script
# @ Return: stdout, exit code
# @ Example:
# @     StopDaemon_sp /path/to/AppServer.sh
# @ End of function
##################################################
StopDaemon_sp() {
    if [ $# -lt 1 ]; then
        M_StopDaemon_sp="Empty scirpt name."
        return 1
    fi
    My_StopDaemon_sp_short=`$BASENAME $1`
    My_StopDaemon_sp_lock="$RUN_SP/${My_StopDaemon_sp_short}.daemon.lock"
    if [ -f $My_StopDaemon_sp_lock ]; then
        My_StopDaemon_sp_pid=`$CAT $My_StopDaemon_sp_lock | $HEAD -1 | $AWK '{print $1}'`
        if IsProcRunning_sp $My_StopDaemon_sp_pid ; then
            $KILL -9 $My_StopDaemon_sp_pid
            M_StopDaemon_sp="$My_StopDaemon_sp_short stopped. PID=$My_StopDaemon_sp_pid"
        fi
        $RM -f $My_StopDaemon_sp_lock
        return 0
    fi
    M_StopDaemon_sp="$My_StopDaemon_sp_short is not running."
    return 1
}

# End of script
