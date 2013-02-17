$PRINT "Test Global Variables ..."
$PRINT "USER_ID_SP=$USER_ID_SP"
$PRINT "USER_NAME_SP=$USER_NAME_SP"
$PRINT "REAL_USER_ID_SP=$REAL_USER_ID_SP"
$PRINT "REAL_USER_NAME_SP=$REAL_USER_NAME_SP"
$PRINT "USER_FULLNAME_SP=$USER_FULLNAME_SP"
$PRINT "REAL_USER_FULLNAME_SP=$REAL_USER_FULLNAME_SP"
$PRINT "DEFAULT_GROUP_ID_SP=$DEFAULT_GROUP_ID_SP"
$PRINT "DEFAULT_GROUP_NAME_SP=$DEFAULT_GROUP_NAME_SP"
$PRINT "REAL_DEFAULT_GROUP_ID_SP=$REAL_DEFAULT_GROUP_ID_SP"
$PRINT "REAL_DEFAULT_GROUP_NAME_SP=$REAL_DEFAULT_GROUP_NAME_SP"
$PRINT "ALL_GROUP_IDS_SP=$ALL_GROUP_IDS_SP"
$PRINT "ALL_GROUP_NAMES_SP=$ALL_GROUP_NAMES_SP"
$PRINT "USER_FROM_SP=$USER_FROM_SP"
$PRINT "IS_SUPER_USER_SP=$IS_SUPER_USER_SP"
$PRINT "IS_IN_SUPER_GROUP_SP=$IS_IN_SUPER_GROUP_SP"
$PRINT "Test Global Variables, done."
$PRINT "#################################################"
$PRINT
$PRINT

# Get last 5 users and 2 groups
my_users=`$TAIL -5 /etc/passwd | $CUT -d':' -f1`
my_groups=`$TAIL -5 /etc/group | $CUT -d':' -f1`

$PRINT "Test functions ..."
$PRINT "Test function IsUser_sp, ..."
for u in $my_users ; do
    if IsUser_sp $u ; then
        $PRINT "Current user is $u"
    else
        $PRINT "Current user is not $u"
    fi
done
$PRINT "Test function IsUser_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function IsInGroup_sp, ..."
for g in $my_groups ; do
    if IsInGroup_sp $g ; then
        $PRINT "Current user is in group $g"
    else
        $PRINT "Current user is not in group $g"
    fi
done
$PRINT "Test function IsInGroup_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function IsSuperUser_sp, ..."
if IsSuperUser_sp ; then
    $PRINT "Current user is super user."
else
    $PRINT "Current user is not super user."
fi
$PRINT "Test function IsSuperUser_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function IsInSuperGroup_sp, ..."
for u in $my_users ; do
    if IsInSuperGroup_sp ; then
        $PRINT "User $u is in super user group"
    else
        $PRINT "User $u is not in super user group"
    fi
done
$PRINT "Test function IsInSuperGroup_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function GetUserName_sp, ..."
$PRINT "The user name of uid $REAL_USER_ID_SP is `GetUserName_sp $REAL_USER_ID_SP`"
$PRINT "Test function GetUserName_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function GetGroupName_sp, ..."
$PRINT "The group name of gid $REAL_DEFAULT_GROUP_ID_SP is `GetGroupName_sp $REAL_DEFAULT_GROUP_ID_SP`"
$PRINT "Test function GetGroupName_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function UserExist_sp, ..."
for u in bin daemon lp sync mysql oracle allen ;do
    if UserExist_sp -u "$u" ; then
        $PRINT "The user name $u exists"
    else
        $PRINT "The user name $u does not exist"
    fi
done
for u in `$SEQ 5 15` ;do
    if UserExist_sp -n "$u" ; then
        $PRINT "The uid $u exists. User name = `GetUserName_sp $u`"
    else
        $PRINT "The uid $u does not exist"
    fi
done
$PRINT "Test function UserExist_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function GroupExist_sp, ..."
for g in bin daemon lp sync mysql oracle allen ;do
    if GroupExist_sp -g "$g" ; then
        $PRINT "The group name $g exists"
    else
        $PRINT "The group name $g does not exist"
    fi
done
for g in `$SEQ 5 15` ;do
    if GroupExist_sp -g "$g" ; then
        $PRINT "The gid $g exists. Group name=`GetGroupName_sp $g`"
    else
        $PRINT "The gid $g does not exist"
    fi
done
$PRINT "Test function GroupExist_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test functions, done."
