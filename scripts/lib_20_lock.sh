##################################################
# $Id: lib_20_lock.sh 13 2011-03-27 00:19:04Z Allen.Zhao@gmail.com $
##################################################
# @ File: lib_lock.sh
# @ Description: Process lock
# @ Description: You can use this lib to keep a single running copy of your script
# @ Dependency: lib_ui.sh
# @ Author: Allen Zhao
# @ Email: allen.zhao@gmail.com
# @ End of file
##################################################
# @ Required Global Variable: PROGNAME_SP - The top script name must be initianlized in your own script. Please see template.sh.
##################################################
# Local Variable: LOCAL_LOCK_CHECK_INTVAL - Default lock check interval in seconds
##################################################
LOCAL_LOCK_CHECK_INTVAL=5

##################################################
# @ Function: LockMe_sp
# @ Description: Single script lock
# @ Usage: LockMe_sp [-l lockfile] [-e|-w|-r]
# @ Parameter: -l lockfile
# @ Parameter: -e - If lock failed, exit. This is the default option.
# @ Parameter: -w - If loca failed, wait and try again
# @ Parameter: -r - If lock failed, return.
# @ Return: exit code, variable (error message)
# @ Example:
# @     LockMe_sp
# @ End of function
##################################################
LockMe_sp() {
    My_LockMe_mylock=$RUN_SP/$PROGNAME_SP.lock
    My_LockMe_act=0
    while [ $# -ne 0 ]; do
        case $1 in
            -l)
                My_LockMe_mylock=$2
                shift 2 ;;
            -r)
                My_LockMe_act=2
                shift ;;
            -w)
                My_LockMe_act=1
                shift ;;
        esac
    done
    while [ 1 ] ; do
        if [ -f $My_LockMe_mylock ] ; then
        # Be smart, check dead lock
            My_LockMe_oldpid=`$CAT $My_LockMe_mylock 2>/dev/null`
            if [ ! -z "$My_LockMe_oldpid" ]; then
                if IsProcRunning_sp $My_LockMe_oldpid ; then
                    if [ $My_LockMe_act -eq 2 ] ; then
                        M_LockMe_sp="OldPID= My_LockMe_oldpid"
                        return 1
                    elif [ $My_LockMe_act -eq 1 ]; then
                        $SLEEP $LOCAL_LOCK_CHECK_INTVAL
                        continue
                    else
                        ErrorExit_sp "Old process $My_LockMe_oldpid is running."
                    fi
                fi
            fi
        fi
        $PRINT $$ > $My_LockMe_mylock
        return 0
    done
}

##################################################
# @ Function: AmILocked_sp
# @ Description: Check if script is locked
# @ Usage: AmILocked_sp [lockfile]
# @ Parameter: lockfile
# @ Return: exit code, variable (error message)
# @ Example:
# @     if AmILocked_sp ; then
# @         DoSomething
# @     fi
# @ End of function
##################################################
AmILocked_sp() {
    if [ -z "$1" ]; then
        My_AmILocked_sp_mylock=$RUN_SP/$PROGNAME_SP.lock
    else
        My_AmILocked_sp_mylock=$1
    fi
    if [ -f $My_AmILocked_sp_mylock ]; then
        My_AmILocked_sp_oldpid=`$CAT $My_AmILocked_sp_mylock 2>/dev/null`
        if [ -z "$My_AmILocked_sp_oldpid" ]; then
            return 1
        fi
        if IsProcRunning_sp $My_AmILocked_sp_oldpid ; then
            return 0
        fi
    fi
    return 1
}

##################################################
# @ Function: UnlockMe_sp
# @ Description: Unlock
# @ Usage: UnlockMe_sp [lockfile]
# @ Parameter: lockfile
# @ Return:
# @ Example:
# @     UnlockMe_sp
# @ End of function
##################################################
UnlockMe_sp() {
    if [ -z "$1" ]; then
        My_UnlockMe_sp_mylock=$RUN_SP/$PROGNAME_SP.lock
    else
        My_UnlockMe_sp_mylock=$1
    fi
    $RM -f $My_UnlockMe_sp_mylock 1>/dev/null 2>/dev/null
}

##################################################
# @ Function: GetLockProcess_sp
# @ Description: GetLockProcess_sp
# @ Usage: GetLockProcess_sp [lockfile]
# @ Parameter: lockfile
# @ Return:
# @ Example:
# @     My_lockproc=`GetLockProcess_sp`
# @ End of function
##################################################
GetLockProcess_sp() {
    if [ -z "$1" ]; then
        My_GetLockProcess_sp_mylock=$RUN_SP/$PROGNAME_SP.lock
    else
        My_GetLockProcess_sp_mylock=$1
    fi
    if [ -r "$My_GetLockProcess_sp_mylock" ]&& [ -f $My_GetLockProcess_sp_mylock ] ; then
        My_GetLockProcess_sp_num=`$CAT "$My_GetLockProcess_sp_mylock" | $HEAD -1 | $AWK '{print $1}'`
    fi
    if IsNumber_sp $My_GetLockProcess_sp_num ; then
        $PRINT $My_GetLockProcess_sp_num
        return 0
    fi
    return 1
}
# End of script
