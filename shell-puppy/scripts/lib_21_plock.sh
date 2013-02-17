##################################################
# $Id: lib_21_plock.sh 13 2011-03-27 00:19:04Z Allen.Zhao@gmail.com $
##################################################
# @ File: lib_plock.sh
# @ Description: Parallel lock.
# @ Description: One of the useful scenario is to run specified number of parallel tasks
# @ Dependency: lib_misc.sh, lib_ui.sh
# @ Author: Allen Zhao
# @ Email: allen.zhao@gmail.com
# @ End of file
##################################################
# @ Required Global Variable: PROGNAME_SP - The top script name must be initianlized in your own script. Please see template.sh.
##################################################
# Local Variable: LOCAL_PLOCK_CHECK_INTVAL - Default lock check interval in seconds
# Local Variable: PLOCK_name_total - number of plocks
##################################################
LOCAL_PLOCK_CHECK_INTVAL=10

##################################################
# @ Function: ClearPLocks_sp
# @ Description: Clear all plocks
# @ Usage: ClearPLocks_sp plocksName
# @ Parameter: plocksName
# @ Return: exit code
# @ Example:
# @     ClearPLocks_sp
# @ End of function
##################################################
ClearPLocks_sp() {
    if [ ! -z "$1" ]; then
        $RM -f "$RUN_SP/$1" 2>/dev/null
        return 0
    fi
    return 1
}

##################################################
# @ Function: InitPLocks_sp
# @ Description: Initialize Plocks
# @ Usage: InitPLocks_sp plocksName] [num-of-plocks]
# @ Parameter: plocksName - Specify plocksName. Default is ${PROGNAME_SP}. Must be digits/letters only
# @ Parameter: num-of-plocks - Specify how many plocks default is 2
# @ Return: exit code, variable (error msg)
# @ Example:
# @     ClearPLocks_sp
# @ End of function
##################################################
InitPLocks_sp() {
    if IsAlphaNumeric_sp "$1" ; then
        My_InitPLocks_sp_DoNothing=
    else
        M_InitPLocks_sp="Invalid plock name $1"
        return 1
    fi
    My_InitPLocks_sp_pln=$1
    My_InitPLocks_sp_total=2
    if [ ! -z "$2" ] && IsNumber_sp $2 ; then
        My_InitPLocks_sp_total=$2
    fi
    $EVAL "PLOCK_${My_InitPLocks_sp_pln}_total=$My_InitPLocks_sp_total"
    ClearPLocks_sp $My_InitPLocks_sp_pln
    return 0
}

##################################################
# @ Function: GetParaLock_sp
# @ Description: Get a parallel lock
# @ Usage: GetParaLock_sp plocksName [nowait]
# @ Parameter: plocksName
# @ Parameter: nowait - If get lock failed, return 1 (false). Defaultis wait and try again
# @ Return: exit code, stdout
# @ Example:
# @     if GetParaLock_sp mylock ; then
# @         DoSomething
# @     fi
# @ End of function
##################################################
GetParaLock_sp() {
    IsAlphaNumeric_sp "$1" || {
        M_GetParaLock_sp="Invalid plock name $1"
        return 1
    }
    My_GetParaLock_sp_pln="$1"
    $EVAL "My_GetParaLock_sp_total=\$PLOCK_${My_GetParaLock_sp_pln}_total"
    if [ -z "$My_GetParaLock_sp_total" ] ; then
        M_GetParaLock_sp="Plock $My_GetParaLock_sp_total not initialized"
        return 1
    fi
    IsNumber_sp "$My_GetParaLock_sp_total" || {
        M_GetParaLock_sp="Plock $My_GetParaLock_sp_total not initialized"
        return 1
    }
    while [ true ] ; do
        for My_GetParaLock_sp_lckn in `$SEQ 1 $My_GetParaLock_sp_total`; do
            if [ -f $RUN_SP/${My_GetParaLock_sp_pln}.plock.$My_GetParaLock_sp_lckn ]; then
                continue
            fi
            $TOUCH $RUN_SP/${My_GetParaLock_sp_pln}.plock.$My_GetParaLock_sp_lckn
            $PRINT "$My_GetParaLock_sp_lckn"
            return 0
        done
        if [ "$2" = "nowait" ]; then
            $PRINT "0"
            return 1
        fi
        $SLEEP $LOCAL_PLOCK_CHECK_INTVAL
    done
}

##################################################
# @ Function: ReleaseParaLock_sp
# @ Description: Release a parallel lock
# @ Usage: ReleaseParaLock_sp plocksName lockNumber
# @ Parameter: plocksName
# @ Parameter: lockNumber - The index of the plock
# @ Return: exit code
# @ Example:
# @     if GetParaLock_sp mylock ; then
# @         DoSomething
# @     fi
# @ End of function
##################################################
ReleaseParaLock_sp() {
    IsAlphaNumeric_sp "$1" || {
        M_ReleaseParaLock_sp="Invalid plock name $1"
        return 1
    }
    IsNumber_sp "$2" || {
        M_ReleaseParaLock_sp="Invalid plock number $2"
        return 1
    }
    $RM $RUN_SP/${1}.plock.${2} 2>/dev/null
    return 0
}

# End of script
