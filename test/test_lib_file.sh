$PRINT "Test functions ..."
$PRINT "Preapare test data"
for f in `$SEQ 1 4`; do
    $PRINT "test $f" > $TMP_SP/${f}.file_test.$$
done
$PRINT | $TR -d "\n" > $TMP_SP/${f}.file_test.$$
$CHMOD 775 $TMP_SP/1.file_test.$$
$CHMOD 444 $TMP_SP/2.file_test.$$
$CHMOD 000 $TMP_SP/3.file_test.$$
for f in `$SEQ 1 4`; do
    $MKDIR $TMP_SP/${f}.dir_test.$$
done
$CHMOD 775 $TMP_SP/1.dir_test.$$
$CHMOD 555 $TMP_SP/2.dir_test.$$
$CHMOD 000 $TMP_SP/3.dir_test.$$
$PRINT "Test function CheckFile_sp, ..."
for f in `$SEQ 1 4`; do
    if CheckFile_sp $TMP_SP/${f}.file_test.$$ -a ; then
        $PRINT "$TMP_SP/${f}.file_test.$$ has -a"
    else
        $PRINT "$TMP_SP/${f}.file_test.$$ : $M_CheckFile_sp"
    fi
    if CheckFile_sp $TMP_SP/${f}.file_test.$$ -r -w ; then
        $PRINT "$TMP_SP/${f}.file_test.$$ has -r -w"
    else
        $PRINT "$TMP_SP/${f}.file_test.$$ : $M_CheckFile_sp"
    fi
    if CheckFile_sp $TMP_SP/${f}.file_test.$$ -x -s ; then
        $PRINT "$TMP_SP/${f}.file_test.$$ has -x -s"
    else
        $PRINT "$TMP_SP/${f}.file_test.$$ : $M_CheckFile_sp"
    fi
done
$PRINT "Test function CheckFile_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function IsRemoteFile_sp, ..."
for f in /tmp/abc myserver:/tmp/abc ; do
    if IsRemoteFile_sp "$f" ; then
        $PRINT "$f is remote file"
    else
        $PRINT "$f is not remote file"
    fi
done
$PRINT "Test function IsRemoteFile_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function CheckDir_sp, ..."
for f in `$SEQ 1 4`; do
    if CheckDir_sp $TMP_SP/${f}.dir_test.$$ -a ; then
        $PRINT "$TMP_SP/${f}.dir_test.$$ has -a"
    else
        $PRINT "$TMP_SP/${f}.dir_test.$$ : $M_CheckDir_sp"
    fi
    if CheckDir_sp $TMP_SP/${f}.dir_test.$$ -r -w ; then
        $PRINT "$TMP_SP/${f}.dir_test.$$ has -r -w"
    else
        $PRINT "$TMP_SP/${f}.dir_test.$$ : $M_CheckDir_sp"
    fi
    if CheckDir_sp $TMP_SP/${f}.dir_test.$$ -x ; then
        $PRINT "$TMP_SP/${f}.dir_test.$$ has -x"
    else
        $PRINT "$TMP_SP/${f}.dir_test.$$ : $M_CheckDir_sp"
    fi
done
$PRINT "Test function CheckDir_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function IsAbsPath_sp, ..."
for f in ./abc abc /tmp/abc ../abc /tmp/../abc ; do
    if IsAbsPath_sp $f ; then
        $PRINT "$f is abs path"
    else
        $PRINT "$f is not abs path"
    fi
done
$PRINT "Test function IsAbsPath_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function MakeAbsPath_sp, ..."
for f in ./abc abc /tmp/abc ../abc /tmp/../abc ; do
    $PRINT "$f abs path = `MakeAbsPath_sp $f`"
done
$PRINT "Test function MakeAbsPath_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function MakeTemp_sp and RemoveTemp_sp, ..."
if mytmpf=`MakeTemp_sp`; then
    $PRINT "Create tmp file: $mytmpf"
    $PRINT "Delete file $mytmpf"
    RemoveTemp_sp $mytmpf
else
    $PRINT "Create tmp file failed: $M_MakeTemp_sp"
fi
if mytmpf=`MakeTemp_sp -p /tmp`; then
    $PRINT "Create tmp file: $mytmpf"
    $PRINT "Delete file $mytmpf"
    RemoveTemp_sp $mytmpf
else
    $PRINT "Create tmp file failed: $M_MakeTemp_sp"
fi
if mytmpf=`MakeTemp_sp -n -h mytmp`; then
    $PRINT "Create tmp file: $mytmpf"
else
    $PRINT "Create tmp file failed: $M_MakeTemp_sp"
fi
if mytmpf=`MakeTemp_sp -p /root`; then
    $PRINT "Create tmp file: $mytmpf"
    $PRINT "Delete file $mytmpf"
    RemoveTemp_sp $mytmpf
else
    $PRINT "Create tmp file failed: $M_MakeTemp_sp"
fi
if mytmpf=`MakeTemp_sp -d`; then
    $PRINT "Create tmp dir: $mytmpf"
    $PRINT "Delete dir $mytmpf"
    RemoveTemp_sp $mytmpf
else
    $PRINT "Create tmp dir failed: $M_MakeTemp_sp"
fi
if mytmpf=`MakeTemp_sp -d -p /tmp`; then
    $PRINT "Create tmp dir: $mytmpf"
    $PRINT "Delete dir $mytmpf"
    RemoveTemp_sp $mytmpf
else
    $PRINT "Create tmp dir failed: $M_MakeTemp_sp"
fi
if mytmpf=`MakeTemp_sp -d -n -h mytmp`; then
    $PRINT "Create tmp dir: $mytmpf"
else
    $PRINT "Create tmp dir failed: $M_MakeTemp_sp"
fi
if mytmpf=`MakeTemp_sp -p /root`; then
    $PRINT "Create tmp dir: $mytmpf"
    $PRINT "Delete dir $mytmpf"
    RemoveTemp_sp $mytmpf
else
    $PRINT "Create tmp dir failed: $M_MakeTemp_sp"
fi
$PRINT "Test function MakeTemp_sp and RemoveTemp_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function GetFileSize_sp, ..."
for f in `$LS /usr/bin/z*`; do
    $PRINT "File $f size = `GetFileSize_sp $f`"
done
$PRINT "Test function GetFileSize_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function DFK_sp, ..."
DFK_sp
$PRINT "Test function DFK_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function GetDiskSpace_sp, ..."
$PRINT "GetDiskSpace_sp /home = `GetDiskSpace_sp /home`"
$PRINT "GetDiskSpace_sp /home -u = `GetDiskSpace_sp /home -u`"
$PRINT "GetDiskSpace_sp /home -u -p = `GetDiskSpace_sp /home -u -p`"
$PRINT "GetDiskSpace_sp /home -f -p = `GetDiskSpace_sp /home -f -p`"
$PRINT "GetDiskSpace_sp /home -f -k = `GetDiskSpace_sp /home -f -k`"
$PRINT "Test function GetDiskSpace_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function GetFileStats_sp, ..."
for f in `$LS /usr/bin/* | $HEAD -100 | $TAIL -5 2>/dev/null`; do
    $PRINT "File $f stats:"
    GetFileStats_sp $f
done
$PRINT "Test function GetFileStats_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function GetFileDirAttributes_sp, ..."
f=`$LS /usr/bin/c* | $HEAD -1`
for attr in device inode mode nlinks uid gid rdev size atime mtime ctime atimedt mtimedt ctimedt blksize blocks ; do
    $PRINT "$f attr $attr = `GetFileDirAttributes_sp $f $attr`"
done
$PRINT "Test function GetFileDirAttributes_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function GetFileDirOwnership_sp, ..."
$PRINT "File $f owner = `GetFileDirOwnership_sp $f -u`"
$PRINT "File $f group = `GetFileDirOwnership_sp $f -g`"
$PRINT "File $f owner:ship = `GetFileDirOwnership_sp $f -a`"
$PRINT "Test function GetFileDirOwnership_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function IsFileDirChanged_sp, ..."
mf=`MakeTemp_sp`
md=`MakeTemp_sp -d`
$SLEEP 5
my_time=`GetTimeStamp_sp`
my_epoch=`DateTime2Epoch_sp "$my_time"`
my_time=`ComputeHour_sp "$my_time" -2`
my_epoch=`$EXPR $my_epoch - 2`
for f in `$LS /usr/bin/a* | $HEAD -2` $mf $md  /tmp/abc ; do
    if IsFileDirChanged_sp $f -t "$my_time" ; then
        $PRINT "$f is changed since $my_time"
    else
        $PRINT "$f is not changed since $my_time"
    fi
    if IsFileDirChanged_sp $f -e "$my_epoch" ; then
        $PRINT "$f is changed since $my_epoch"
    else
        $PRINT "$f is not changed since $my_epoch"
    fi
    if IsFileDirChanged_sp $f -s 10 ; then
        $PRINT "$f is changed within 10 seconds ago"
    else
        $PRINT "$f is not changed within 10 seconds ago"
    fi
done
$PRINT "Test function IsFileDirChanged_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function CreateBackup_sp, ..."
for f in $mf $md ; do
    if CreateBackup_sp $f ; then
        $PRINT "Create backup $f successfully"
    else
        $PRINT "Create backup $f failed: $MCreateBackup_sp"
    fi
    if CreateBackup_sp $f -e autoBak ; then
        $PRINT "Create backup $f successfully"
    else
        $PRINT "Create backup $f failed: $MCreateBackup_sp"
    fi
    if CreateBackup_sp $f -r -d $VAR_SP -e autoBak ; then
        $PRINT "Create backup $f successfully"
    else
        $PRINT "Create backup $f failed: $MCreateBackup_sp"
    fi
    if CreateBackup_sp $f ; then
        $PRINT "Create backup $f successfully"
    else
        $PRINT "Create backup $f failed: $MCreateBackup_sp"
    fi
done
$PRINT "Check backup result"
$LS -ld ${mf}* ${md}* $VAR_SP/*.autoBak
$RM -rf ${mf}* ${md}* $VAR_SP/*.autoBak
$PRINT "Test function CreateBackup_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Clean up test data"
$CHMOD 777 $TMP_SP/*.file_test.* $TMP_SP/*.dir_test.* 2>/dev/null
$RM -rf $TMP_SP/*.file_test.* $TMP_SP/*.dir_test.*
$PRINT "Test functions, done."
