##################################################
# $Id: lib_05_file.sh 22 2011-04-13 01:38:59Z Allen.Zhao@gmail.com $
##################################################
# @ File: lib_file.sh
# @ Description: Directory and File shell functions.
# @ Dependency: lib_user.sh, lib_dt.sh
# @ Author: Allen Zhao
# @ Email: allen.zhao@gmail.com
# @ End of file
##################################################

##################################################
# @ Function: CheckFile_sp
# @ Description: Check if a file meets certain criteria
# @ Usage: CheckFile_sp local-file-name [-a] [-f] [-x] [-w] [-s] [-r]
# @ Parameter: local-file-name
# @ Parameter: -f - check if a file is a regular file and exist. Default option
# @ Parameter: -x - check if a file is executable
# @ Parameter: -r - check if a file is readable
# @ Parameter: -w - check if a file is writable
# @ Parameter: -s - check if a file has non-zero size 
# @ Parameter: -a - Check all ablve options
# @ Return: exit code, variable
# @ Example:
# @   CheckFile_sp $My_File -a
# @ End of function
##################################################
CheckFile_sp() {
    if [ -z "$1" ]; then
        M_CheckFile_sp="Nothing to check"
        return 0
    fi
    My_CheckFile_sp_file=$1
    My_CheckFile_sp_x=0
    My_CheckFile_sp_w=0
    My_CheckFile_sp_r=0
    My_CheckFile_sp_s=0
    My_CheckFile_sp_a=0
    shift
    if [ ! -f "$My_CheckFile_sp_file" ]; then
        M_CheckFile_sp="File $My_CheckFile_sp_file is not a file!"
        return 1
    fi
    while [ ! -z "$1" ]; do
        case $1 in
            -a)
                My_CheckFile_sp_a=1
            ;;
            -x)
                My_CheckFile_sp_x=1
            ;;
            -w)
                My_CheckFile_sp_w=1
            ;;
            -r)
                My_CheckFile_sp_r=1
            ;;
            -s)
                My_CheckFile_sp_s=1
            ;;
        esac
        shift
    done
    if [ $My_CheckFile_sp_a -eq 1 -o $My_CheckFile_sp_x -eq 1 ]; then
        if [ ! -x "$My_CheckFile_sp_file" ]; then
            M_CheckFile_sp="File $My_CheckFile_sp_file is not executable!"
            return 1
        fi
    fi
    if [ $My_CheckFile_sp_a -eq 1 -o $My_CheckFile_sp_w -eq 1 ]; then
        if [ ! -w "$My_CheckFile_sp_file" ]; then
            M_CheckFile_sp="File $My_CheckFile_sp_file is not writable!"
            return 1
        fi
    fi
    if [ $My_CheckFile_sp_a -eq 1 -o $My_CheckFile_sp_s -eq 1 ]; then
        if [ ! -s "$My_CheckFile_sp_file" ]; then
            M_CheckFile_sp="File $My_CheckFile_sp_file is empty!"
            return 1
        fi
    fi
    if [ $My_CheckFile_sp_a -eq 1 -o $My_CheckFile_sp_r -eq 1 ]; then
        if [ ! -r "$My_CheckFile_sp_file" ]; then
            M_CheckFile_sp="File $My_CheckFile_sp_file is readable!"
            return 1
        fi
    fi
}

##################################################
# @ Function: IsRemoteFile_sp
# @ Description: Check a file is remote file 
# @ Usage: IsRemoteFile_sp file-name
# @ Parameter: file-name
# @ Return: exit code
# @ Example:
# @   IsRemoteFile_sp $My_File
# @ End of function
##################################################
IsRemoteFile_sp() {
    if $PRINT "$1" | $GREP ':' 1>/dev/null ; then
        return 0
    else
        return 1
    fi
}

##################################################
# @ Function: CheckDir_sp
# @ Description: Check if a directory meets certain criteria
# @ Usage: CheckDir_sp local-dir-name {-a} [-d] [-r] [-w] [-x]
# @ Parameter: local-dir-name
# @ Parameter: -d - check if a file is a regular directory and exist. Default option
# @ Parameter: -x - check if a file is searchable
# @ Parameter: -r - check if a file is readable
# @ Parameter: -w - check if a file is writable
# @ Parameter: -a - Check all ablve options
# @ Return: exit code, variable
# @ Example:
# @   CheckDir_sp $My_Dir -a
# @ End of function
##################################################
CheckDir_sp() {
    if [ -z "$1" ]; then
        M_CheckDir_sp="Nothing to check"
        return 0
    fi
    My_CheckDir_sp_Dir=$1
    My_CheckDir_sp_x=0
    My_CheckDir_sp_w=0
    My_CheckDir_sp_r=0
    My_CheckDir_sp_a=0
    shift
    if [ ! -d "$My_CheckDir_sp_Dir" ]; then
        M_CheckDir_sp="File $My_CheckDir_sp_Dir is not a directory!"
        return 1
    fi
    while [ ! -z "$1" ]; do
        case $1 in
            -a)
                My_CheckDir_sp_a=1
            ;;
            -x)
                My_CheckDir_sp_x=1
            ;;
            -w)
                My_CheckDir_sp_w=1
            ;;
            -r)
                My_CheckDir_sp_r=1
            ;;
        esac
        shift
    done
    if [ $My_CheckDir_sp_a -eq 1 -o $My_CheckDir_sp_x -eq 1 ]; then
        if [ ! -x "$My_CheckDir_sp_Dir" ]; then
            M_CheckDir_sp="File $My_CheckDir_sp_Dir is not executable!"
            return 1
        fi
    fi
    if [ $My_CheckDir_sp_a -eq 1 -o $My_CheckDir_sp_w -eq 1 ]; then
        if [ ! -w "$My_CheckDir_sp_Dir" ]; then
            M_CheckDir_sp="File $My_CheckDir_sp_Dir is not writable!"
            return 1
        fi
    fi
    if [ $My_CheckDir_sp_a -eq 1 -o $My_CheckDir_sp_r -eq 1 ]; then
        if [ ! -r "$My_CheckDir_sp_Dir" ]; then
            M_CheckDir_sp="File $My_CheckDir_sp_Dir is readable!"
            return 1
        fi
    fi
}

##################################################
# @ Function: IsAbsPath_sp
# @ Description: Check if a path is absolute path
# @ Usage: IsAbsPath_sp path
# @ Parameter: Path
# @ Return: return code
# @ Example:
# @   IsAbsPath_sp ./my/path
# @ End of function
##################################################
IsAbsPath_sp() {
    if $PRINT "$1" | $GREP '^\/' 2>/dev/null 1>/dev/null ; then
        return 0
    else
        return 1
    fi
}

##################################################
# @ Function: MakeAbsPath_sp
# @ Description: Make a path to abs path
# @ Usage: MakeAbsPath_sp path
# @ Parameter: Path
# @ Return: stdout, variable
# @ Example:
# @   MakeAbsPath_sp ./my/path
# @ End of function
##################################################
MakeAbsPath_sp() {
    M_MakeAbsPath_sp_pwd=`$PWD_SP`
    if IsAbsPath_sp "$1" ; then
        M_MakeAbsPath_sp="$1"
    else
        M_MakeAbsPath_sp="${M_MakeAbsPath_sp_pwd}/$1"
    fi
    $PRINT "$M_MakeAbsPath_sp"
}

##################################################
# @ Function: MakeTemp_sp
# @ Description: Create temp file or directory
# @ Usage: MakeTemp_sp [-p parent-dir] [-h head] [-d|-f] [-n]
# @ Parameter: -p - parent-dir - Specify the parent directory. Default is $TMP_SP.
# @ Parameter: -d - File type is directory.
# @ Parameter: -f - File type is regular file. This is default option.
# @ Parameter: -n - Don't create the file or directory. By default, it will be created.
# @ Parameter: -h - Change the file prefix. Default is tmp
# @ Return: stdout, exit code, variable
# @ Example:
# @   My_TmpFile=`MakeTemp_sp`
# @   My_TmpDir=`MakeTemp_sp d c`
# @ End of function
##################################################
MakeTemp_sp() {
    My_MakeTemp_sp_tmp="$TMP_SP"
    My_MakeTemp_sp_type=f
    My_MakeTemp_sp_head=tmp
    My_MakeTemp_sp_create=1
    while [ ! -z "$1" ]; do
        case $1 in
            -p)
                if CheckDir_sp "$2" -a ; then
                    My_MakeTemp_sp_tmp="$2"
                fi
                shift
            ;;
            -h)
                My_MakeTemp_sp_head=$2
                shift
            ;;
            -d)
                My_MakeTemp_sp_type=d
            ;;
            -n)
                My_MakeTemp_sp_create=0
            ;;
        esac
        shift
    done
    while [ 1 ]; do
        My_MakeTemp_sp_name=`GetRandomNum_sp`
        $LS "$My_MakeTemp_sp_tmp/${My_MakeTemp_sp_head}.$My_MakeTemp_sp_name" 1>/dev/null 2>/dev/null || {
            My_MakeTemp_sp_name="$My_MakeTemp_sp_tmp/${My_MakeTemp_sp_head}.$My_MakeTemp_sp_name"
            break
        }
    done
    if [ $My_MakeTemp_sp_create -eq 1 ]; then
        if [ "$My_MakeTemp_sp_type" = "f" ]; then
            $TOUCH "$My_MakeTemp_sp_name" 2>/dev/null || {
                M_MakeTemp_sp="Create file failed!"
                return 1
            }
        else
            $MKDIR "$My_MakeTemp_sp_name" 2>/dev/null || {
                M_MakeTemp_sp="Create directory failed!"
                return 1
            }
        fi
    fi
    $PRINT "$My_MakeTemp_sp_name"
    return 0
}

##################################################
# @ Function: RemoveTemp_sp
# @ Description: Remove temp file or directory
# @ Usage: RemoveTemp_sp file-or-dir ...
# @ Parameter: file-or-dir ...
# @ Return: none
# @ Example:
# @   RemoveTemp_sp "$My_tmp1" "$My_tmpDir2"
# @ End of function
##################################################
RemoveTemp_sp() {
    if [ -z "$*" ]; then
        return
    fi
    $RM -rf "$@" 2>/dev/null 1>/dev/null
}

##################################################
# @ Function: GetFileSize_sp
# @ Description: Get file size
# @ Usage: GetFileSize_sp file
# @ Parameter: file - The file
# @ Return: exit code, stdout, variable (error msg)
# @ Example:
# @    My_newyear=`GetWeekday_sp 2011 -2` # My_newyear='2009'
# @ End of function
##################################################
# With wc -c. It's safer but slower than ls.
GetFileSize_sp() {
    if CheckFile_sp "$1" -f -r ; then
        $WC -c "$1" | $AWK '{print $1}'
    else
        M_GetFileSize_sp="$M_CheckFile_sp"
    fi
}

# With ls -l
GetFileSize2_sp() {
    if CheckFile_sp "$1" -f -r ; then
        $LS -l "$1" | $AWK '{print $5}'
    else
        M_GetFileSize_sp="$M_CheckFile_sp"
        return 1
    fi
}

##################################################
# @ Function: DFK_sp
# @ Description: Same as "df -k", but will merge all fields in one line, if they are not
# @ Usage: DFK_sp [path]
# @ Parameter: path
# @ Return: exit code, stdout, variable (error msg)
# @ Example:
# @    DFK_sp
# @ End of function
##################################################
DFK_sp() {
    if [ ! -z "$1" ] ; then
        $LS "$1" 2>/dev/null 1>/dev/null || {
            DFK_sp="Invalid path $1"
            return 1
        }
    fi
    My_DFK_sp=`$DF -k $1 2>/dev/null`
    $PRINT "$My_DFK_sp" | while read My_Private_MergeDfLines_sp_ln ; do
        My_Private_MergeDfLines_sp_nf=`$PRINT "$My_Private_MergeDfLines_sp_ln" | $AWK '{print $3}' | $TR -d ' '`
        if [ -z "$My_Private_MergeDfLines_sp_nf" ]; then
            read My_Private_MergeDfLines_sp_ln2
            $PRINT "$My_Private_MergeDfLines_sp_ln $My_Private_MergeDfLines_sp_ln2"
        else
            $PRINT "$My_Private_MergeDfLines_sp_ln"
        fi
    done
}


##################################################
# @ Function: GetDiskSpace_sp
# @ Description: Get disk space free/used in kB/percentage
# @ Usage: GetDiskSpace_sp path [-u|-f] [-p|-k]
# @ Parameter: path
# @ Parameter: -u - Get used
# @ Parameter: -f - Get free (default)
# @ Parameter: -p - In percentage
# @ Parameter: -k - In kB (default)
# @ Return: exit code, stdout, variable (error msg)
# @ Example:
# @    My_used=`GetDiskSpace_sp /path -u -p`
# @ End of function
##################################################
GetDiskSpace_sp() {
    $LS "$1" 2>/dev/null 1>/dev/null || {
        GetDiskSpace_sp="Invalid path"
        return 1
    }
    My_GetDiskSpace_sp="$1"
    My_GetDiskSpace_sp_used=0
    My_GetDiskSpace_sp_per=0
    shift
    while [ $# -ne 0 ]; do
        if [ "$1" = "-u" ]; then
            My_GetDiskSpace_sp_used=1
        elif [ "$1" = "-p" ]; then
            My_GetDiskSpace_sp_per=1
        fi
        shift
    done
    if [ $My_GetDiskSpace_sp_per -eq 0 ]; then
        if [ $My_GetDiskSpace_sp_used -eq 0 ]; then
            if [ "$OS_TYPE_SP" = "AIX" ]; then
                DFK_sp "$My_GetDiskSpace_sp" | $TAIL -1 | $AWK '{print $3}'
            else
                DFK_sp "$My_GetDiskSpace_sp" | $TAIL -1 | $AWK '{print $4}'
            fi
        else
            if [ "$OS_TYPE_SP" = "AIX" ]; then
                My_GetDiskSpace_allkb=`DFK_sp "$My_GetDiskSpace_sp" | $TAIL -1 | $AWK '{print $2}'`
                My_GetDiskSpace_freekb=`DFK_sp "$My_GetDiskSpace_sp" | $TAIL -1 | $AWK '{print $3}'`
                $EXPR $My_GetDiskSpace_allkb - $My_GetDiskSpace_freekb
            else
                DFK_sp "$My_GetDiskSpace_sp" | $TAIL -1 | $AWK '{print $3}'
            fi
        fi
    else
        if [ "$OS_TYPE_SP" = "AIX" ]; then
            My_GetDiskSpace_sp_pv=`DFK_sp "$My_GetDiskSpace_sp" | $TAIL -1 | $AWK '{print $4}' | $TR -d '%'`
        else
            My_GetDiskSpace_sp_pv=`DFK_sp "$My_GetDiskSpace_sp" | $TAIL -1 | $AWK '{print $5}' | $TR -d '%'`
        fi
        if [ $My_GetDiskSpace_sp_used -eq 0 ]; then
            $EXPR 100 - $My_GetDiskSpace_sp_pv
        else
            $PRINT $My_GetDiskSpace_sp_pv
        fi
    fi
}

##################################################
# @ Function: GetFileStats_sp
# @ Description: Get file stats
# @ Usage: GetFileStats_sp file
# @ Parameter: file
# @ Return: exit code, stdout, variable (error msg)
# @ Example:
# @    GetFileStats_sp file
# @ End of function
##################################################
GetFileStats_sp() {
    $LS "$1" 1>/dev/null 2>/dev/null || {
        M_GetFileStats_sp="File does not exist."
        return 1
    }
    $PERL -e '
@a=stat(shift);
print "device=", $a[0], "\n";
print "inode=", $a[1], "\n";
printf "mode=%04s\n", $a[2] & 07777;
print "nlinks=", $a[3], "\n";
print "uid=", $a[4], "\n";
print "gid=", $a[5], "\n";
print "rdev=", $a[6], "\n";
print "size=", $a[7], "\n";
print "atime=", $a[8], "\n";
print "mtime=", $a[9], "\n";
print "ctime=", $a[10], "\n";
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($a[8]);
printf "atimedt=%04s-%02s-%02s %02s:%02s:%02s\n", $year+1900, $mon, $mday, $hour, $min, $sec;
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($a[9]);
printf "mtimedt=%04s-%02s-%02s %02s:%02s:%02s\n", $year+1900, $mon, $mday, $hour, $min, $sec;
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($a[10]);
printf "ctimedt=%04s-%02s-%02s %02s:%02s:%02s\n", $year+1900, $mon, $mday, $hour, $min, $sec;
print "blksize=", $a[11], "\n";
print "blocks=", $a[12], "\n";' "$1"
}

##################################################
# @ Function: GetFileDirAttributes_sp
# @ Description: Get file attributes
# @ Usage: GetFileDirAttributes_sp file attrName
# @ Parameter: file
# @ Parameter: attrName - The attributed name.
# @     Please check GetFileStats_sp for supported attrName 
# @     device, inode, mode, nlinks, uid, gid, rdev, size, atime
# @     mtime, ctime, atimedt, mtimedt, ctimedt, blksize, blocks
# @ Return: exit code, stdout, variable (error msg)
# @ Example:
# @    My_file_uid=`GetFileDirAttributes_sp /path/to/myfile uid`
# @ End of function
##################################################
GetFileDirAttributes_sp() {
    case $2 in
        device|inode|mode|nlinks|uid|gid|rdev|size|atime|mtime|ctime|atimedt|mtimedt|ctimedt|blksize|blocks)
            My_GetFileDirAttributes_sp_doNothing=
            ;;
        *)
            M_GetFileDirAttributes_sp="Invalid attribute name."
            return 1
        ;;
    esac
    if My_GetFileDirAttributes_sp_msg=`GetFileStats_sp $1` ; then
        $PRINT "$My_GetFileDirAttributes_sp_msg" | $GREP -w "^$2" | $CUT -d'=' -f2
    else
        M_GetFileDirAttributes_sp="$M_GetFileStats_sp"
        return 1
    fi
    return 0
}


##################################################
# @ Function: GetFileDirOwnership_sp
# @ Description: Get file ownership in name
# @ Usage: GetFileDirOwnership_sp file -a|-g|-u
# @ Parameter: file
# @ Parameter: -a - return user:group. This is default
# @ Parameter: -u - return user name
# @ Parameter: -g - return group name
# @ Return: exit code, stdout, variable (error msg)
# @ Example:
# @    My_ownership=`GetFileDirOwnership_sp /path/to/myfile`
# @ End of function
##################################################
GetFileDirOwnership_sp() {
    if My_GetFileDirOwnership_sp_msg=`GetFileStats_sp $1` ; then
        My_GetFileDirOwnership_sp_uid=`$PRINT "$My_GetFileDirOwnership_sp_msg" | $GREP -w "^uid" | $CUT -d'=' -f2`
        My_GetFileDirOwnership_sp_gid=`$PRINT "$My_GetFileDirOwnership_sp_msg" | $GREP -w "^gid" | $CUT -d'=' -f2`
        My_GetFileDirOwnership_sp_uname=`GetUserName_sp "$My_GetFileDirOwnership_sp_uid"`
        My_GetFileDirOwnership_sp_gname=`GetUserName_sp "$My_GetFileDirOwnership_sp_gid"`
        case $2 in
            -u)  $PRINT "$My_GetFileDirOwnership_sp_uname" ;;
            -g)  $PRINT "$My_GetFileDirOwnership_sp_gname" ;;
            *)
                $PRINT "$My_GetFileDirOwnership_sp_uname:$My_GetFileDirOwnership_sp_gname" ;;
        esac
    else
        M_GetFileDirOwnership_sp="$M_GetFileStats_sp"
        return 1
    fi
    return 0
}

##################################################
# @ Function: IsFileDirChanged_sp
# @ Description: Check if file is change in a time frame before now
# @ Usage: IsFileDirChanged_sp file -t "YYYY-MM-dd HH:mm:ss" | -s second | -e epoch_tm
# @ Parameter: file
# @ Parameter: -t "YYYY-MM-dd HH:mm:ss" - After time
# @ Parameter: -e epoch_tm - After time
# @ Parameter: -s seconds - Seconds before now
# @ Return: exit code, stdout, variable (error msg)
# @ Example:
# @    if IsFileDirChanged_sp /path/my_file 3600 ; then
# @        DoSomething
# @     fi
# @ End of function
##################################################
IsFileDirChanged_sp() {
    $LS "$1" 2>/dev/null 1>/dev/null || {
        M_IsFileDirChanged_sp="File not exist."
        return 1
    }
    case $2 in
        -t)
            My_IsFileDirChanged_sp_ctm=`DateTime2Epoch_sp "$3"` || {
                M_IsFileDirChanged_sp="$M_DateTime2Epoch_sp"
                return 1
            } ;;
        -e)
            IsNumber_sp "$3" || {
                My_IsFileDirChanged_sp="$3 is not valid number."
                return 1
            }
            My_IsFileDirChanged_sp_ctm=$3 ;;
        -s)
            IsNumber_sp "$3" || {
                My_IsFileDirChanged_sp="$3 is not valid number."
                return 1
            }
            My_IsFileDirChanged_sp_now=`GetTimeStamp_sp`
            My_IsFileDirChanged_sp_ctm=`DateTime2Epoch_sp "$My_IsFileDirChanged_sp_now"` || {
                M_IsFileDirChanged_sp="$M_DateTime2Epoch_sp"
                return 1
            }
            My_IsFileDirChanged_sp_ctm=`$EXPR $My_IsFileDirChanged_sp_ctm - $3` ;;
        *)
            M_IsFileDirChanged_sp="Invalid option."
            return 1 ;;
    esac
    My_IsFileDirChanged_sp_ftm=`GetFileDirAttributes_sp $1 mtime` || {
        M_IsFileDirChanged_sp="$M_GetFileDirAttributes_sp"
        return 1
    }
    if [ $My_IsFileDirChanged_sp_ftm -gt $My_IsFileDirChanged_sp_ctm ]; then
        return 0
    fi
    return 1
}

##################################################
# @ Function: CreateBackup_sp
# @ Description: Create a back of local file
# @ Usage: CreateBackup_sp /path/to/file [-r] [-d /backup/path] [-t]|[-e ext]
# @ Parameter: /path/to/file
# @ Parameter: -r - Remove the orignal file
# @ Parameter: -d /backup/path- Backup to other dir
# @ Parameter: -t - Add time stamp to file extention. This is default option
# @ Parameter: -e ext - Use specified extention
# @ Return: exit code, variable (error msg)
# @ Example:
# @     CreateBackup_sp /path/myfile
# @ End of function
##################################################
CreateBackup_sp() {
    $LS "$1" 2>/dev/null 1>/dev/null || {
        M_CreateBackup_sp="File not exist."
        return 1
    }
    My_CreateBackup_sp_src="$1"
    My_CreateBackup_sp_r=0
    My_CreateBackup_sp_fn=`$BASENAME "$1"`
    My_CreateBackup_sp_e=`GetTimeStamp2_sp`
    My_CreateBackup_sp_bd=`$DIRNAME "$1"`
    shift
    while [ $# -gt 0 ] ; do
        case $1 in
            -r)
                My_CreateBackup_sp_r=1
                shift ;;
            -d)
                if CheckDir_sp "$2" -a ; then
                    My_CreateBackup_sp_bd="$2"
                fi
                shift 2 ;;
            -e)
                My_CreateBackup_sp_e="$2"
                shift 2 ;;
        esac
    done
    My_CreateBackup_sp_nf="$My_CreateBackup_sp_bd/${My_CreateBackup_sp_fn}.$My_CreateBackup_sp_e"
    $CP -pr $My_CreateBackup_sp_src $My_CreateBackup_sp_nf
    if [ $My_CreateBackup_sp_r -eq 1 ]; then
        if $RM -rf $1 2>/dev/null ; then
            M_CreateBackup_sp="Delete file $1 failed!"
        fi
    fi
    return 0
}

# End of script
