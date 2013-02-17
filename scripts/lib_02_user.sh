##################################################
# $Id: lib_02_user.sh 13 2011-03-27 00:19:04Z Allen.Zhao@gmail.com $
##################################################
# @ File: lib_user.sh
# @ Description: User and Group shell functions.
# @ Dependency: lib_misc.sh
# @ Author: Allen Zhao
# @ Email: allen.zhao@gmail.com
# @ End of file
##################################################
# @ Global Variable: USER_ID_SP - Current running User ID
# @ Global Variable: USER_NAME_SP - Current running User Name
# @ Global Variable: REAL_USER_ID_SP - Current running Real User ID
# @ Global Variable: REAL_USER_NAME_SP - Current running Real User Name
# @ Global Variable: USER_FULLNAME_SP - Current running User Name
# @ Global Variable: REAL_USER_FULLNAME_SP - Current running REAL User Name
# @ Global Variable: DEFAULT_GROUP_ID_SP - Current running Default Group ID
# @ Global Variable: DEFAULT_GROUP_NAME_SP - Current running Default Group Name
# @ Global Variable: REAL_DEFAULT_GROUP_ID_SP - Current running Default Real Group ID
# @ Global Variable: REAL_DEFAULT_GROUP_NAME_SP - Current running Default Real Group Name
# @ Global Variable: ALL_GROUP_IDS_SP - Group IDs the current user belongs
# @ Global Variable: ALL_GROUP_NAMES_SP - Group Names the current user belongs
# @ Global Variable: USER_FROM_SP - where the user login from)
# @ Global Variable: IS_SUPER_USER_SP - If a user is super user, the value is y, otherwise is n
# @ Global Variable: IS_IN_SUPER_GROUP_SP - If a user belongs to super group, the value is y, otherwise is n
##################################################
USER_ID_SP=`$ID -u`
USER_NAME_SP=`$ID -u -n`
USER_FULLNAME_SP=`$GREP -w "^$USER_NAME_SP" /etc/passwd | $CUT -d: -f 5`
REAL_USER_ID_SP=`$ID -r -u`
REAL_USER_NAME_SP=`$ID -r -u -n`
REAL_USER_FULLNAME_SP=`$GREP -w "^$REAL_USER_NAME_SP" /etc/passwd | $CUT -d: -f 5`
DEFAULT_GROUP_ID_SP=`$ID -g`
DEFAULT_GROUP_NAME_SP=`$ID -g -n`
REAL_DEFAULT_GROUP_ID_SP=`$ID -r -g`
REAL_DEFAULT_GROUP_NAME_SP=`$ID -r -g -n`
ALL_GROUP_IDS_SP="`$ID -G`"
ALL_GROUP_NAMES_SP="`$ID -G -n`"
USER_FROM_SP=`$WHO am i | $AWK '{print $NF}' | $SED -e 's/(\(.*\))/\1/g'`
IS_SUPER_USER_SP=n
IS_IN_SUPER_GROUP_SP=n

##################################################
# @ Function: IsUser_sp
# @ Description: Check if current user is specified user
# @ Usage: IsUser_sp UserName|UserID
# @ Return: exit code
# @ Example:
# @   if IsUser_sp tom ; then
# @       DoSomething
# @   fi
# @ End of function
##################################################
IsUser_sp() {
    if IsDigits_sp "$1" ; then
        if [ "$USER_ID_SP" = "$1" ]; then
            return 0
        else
            return 1
        fi
    else
        if [ "$USER_NAME_SP" = "$1" ]; then
            return 0
        else
            return 1
        fi
    fi
}

##################################################
# @ Function: IsInGroup_sp
# @ Description: Check if current user is specified user
# @ Usage: IsInGroup_sp GroupName|GroupID
# @ Return: exit code
# @ Example:
# @   if IsInGroup_sp wheel ; then
# @       DoSomething
# @   fi
# @ End of function
##################################################
IsInGroup_sp() {
    My_IsInGroup_sp_list="$ALL_GROUP_NAMES_SP"
    if IsDigits_sp "$1" ; then
        My_IsInGroup_sp_list="$ALL_GROUP_IDS_SP"
    fi
    for My_IsInGroup_sp_item in $My_IsInGroup_sp_list ; do
        if [ "$My_IsInGroup_sp_item" = "$1" ]; then
            return 0
        fi
    done
    return 1
}

##################################################
# @ Function: IsSuperUser_sp
# @ Description: Check if current user is super user.
# @ Usage: IsSuperUser_sp
# @ Return: exit code
# @ Example:
# @   if IsSuperUser_sp ; then
# @       DoSomething
# @   fi
# @ End of function
##################################################
IsSuperUser_sp() {
    if [ $USER_ID_SP -eq 0 ]; then
        return 0
    fi
    return 1
}

##################################################
# @ Function: IsInSuperGroup_sp
# @ Description: Check if current user is super user.
# @ Usage: IsInSuperGroup_sp
# @ Return: exit code
# @ Example:
# @   if IsInSuperGroup_sp ; then
# @       DoSomething
# @   fi
# @ End of function
##################################################
IsInSuperGroup_sp() {
    for My_IsInSuperGroup_sp_gid in $ALL_GROUP_IDS_SP ; do
        if [ $My_IsInSuperGroup_sp_gid -eq 0 ]; then
            return 0
        fi
    done
    return 1
}

##################################################
# @ Function: GetUserName_sp
# @ Description: Get user name form uid
# @ Usage: GetUserName_sp uid
# @ Parameter: uid
# @ Return: exit code, stdout, variable (error msg)
# @ Example:
# @    My_uname=`GetUserName_sp 10000`
# @ End of function
##################################################
GetUserName_sp() {
    My_GetUserName_sp_id=`$EXPR $1 \* 1 2>/dev/null`
    if [ -z "$My_GetUserName_sp_id" ]; then
        M_GetUserName_sp="Invalid UID."
        return 1
    fi
    My_GetUserName_sp_uname=`$CUT -d':' -f 1,3 /etc/passwd | $GREP ":${My_GetUserName_sp_id}$" | $CUT -d':' -f1`
    if [ -z "$My_GetUserName_sp_uname" ]; then
        M_GetUserName_sp="Invalid UID."
        return 1
    fi
    $PRINT "$My_GetUserName_sp_uname"
    return 0
}

##################################################
# @ Function: GetGroupName_sp
# @ Description: Get group name form uid
# @ Usage: GetGroupName_sp gid
# @ Parameter: gid
# @ Return: exit code, stdout, variable (error msg)
# @ Example:
# @    My_gname=`GetGroupName_sp 10000`
# @ End of function
##################################################
GetGroupName_sp() {
    My_GetGroupName_sp_id=`$EXPR $1 \* 1 2>/dev/null`
    if [ -z "$My_GetGroupName_sp_id" ]; then
        M_GetGroupName_sp="Invalid GID."
        return 1
    fi
    My_GetGroupName_sp_uname=`$CUT -d':' -f 1,3 /etc/group | $GREP ":${My_GetGroupName_sp_id}$" | $CUT -d':' -f1`
    if [ -z "$My_GetGroupName_sp_uname" ]; then
        M_GetGroupName_sp="Invalid GID."
        return 1
    fi
    $PRINT "$My_GetGroupName_sp_uname"
    return 0
}

if IsSuperUser_sp ; then
    IS_SUPER_USER_SP=y
fi
if IsInSuperGroup_sp ; then
    IS_IN_SUPER_GROUP_SP=y
fi

##################################################
# @ Function: UserExist_sp
# @ Description: Check if user exists
# @ Usage: UserExist_sp [-u user]|[-n uid]
# @ Parameter: -u user - Check user name
# @ Parameter: -n uid - Check uid
# @ Return: exit code
# @ Example:
# @    if UserExist_sp -u allan ; then
# @         DoSomething
# @    fi
# @ End of function
##################################################
UserExist_sp() {
    if [ $# -lt 2 ]; then
        M_UserExist_sp="Invalid option"
        return 1
    fi
    case $1 in
        -u)
            if $ID -u $2 2>/dev/null 1>/dev/null ; then
                return 0
            fi
            return 1 ;;
        -n)
            if GetUserName_sp $2 2>/dev/null 1>/dev/null ; then
                return 0
            fi
            return 1 ;;
        *)
            M_UserExist_sp="Invalid option"
            return 1 ;;
    esac
}

##################################################
# @ Function: GroupExist_sp
# @ Description: Check if group exists
# @ Usage: GroupExist_sp [-g group]|[-n gid]
# @ Parameter: -g group - Check group name
# @ Parameter: -n gid - Check gid
# @ Return: exit code
# @ Example:
# @    if GroupExist_sp -g wheel ; then
# @         DoSomething
# @    fi
# @ End of function
##################################################
GroupExist_sp() {
    if [ $# -lt 2 ]; then
        M_GroupExist_sp="Invalid option"
        return 1
    fi
    case $1 in
        -g)
            if $CUT -d':' -f1 /etc/group | $GREP -w "${2}"  2>/dev/null 1>/dev/null ; then
                return 0
            fi
            return 1 ;;
        -n)
            if GetGroupName_sp $2 2>/dev/null 1>/dev/null ; then
                return 0
            fi
            return 1 ;;
        *)
            M_GroupExist_sp="Invalid option"
            return 1 ;;
    esac
}

# End of script
