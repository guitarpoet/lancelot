##################################################
# $Id: lib_01_misc.sh 13 2011-03-27 00:19:04Z Allen.Zhao@gmail.com $
##################################################
# @ File: lib_misc.sh
# @ Description: Misc. shell functions
# @ Author: Allen Zhao
# @ Email: allen.zhao@gmail.com
# @ End of file
##################################################

##################################################
# @ Function: GetRandomNum_sp
# @ Description: Get a random number
# @ Usage: GetRandom_sp
# @ Return: stdout
# @ Example:
# @   My_Ran=`GetRandomNum_sp`
# @ End of function
##################################################
# This is the best
GetRandomNum_sp() {
    $PERL -e 'srand(); print int(rand() * 100000000), "\n";'
}
# You may get same number in a second
GetRandomNum2sp() {
    $AWK 'BEGIN{srand(); print int(rand()*100000000)+1}'
}
# Don't why, I might get 10-20 seconds delay from /dev/random
GetRandomNum3_sp() {
    if $LS /dev/random 1>/dev/null 2>/dev/null ; then
        $DD if=/dev/random ibs=32 count=1 2>/dev/null | $CKSUM | $CUT -d' ' -f1
        return
    fi
    $DATE | $CKSUM | $CUT -d' ' -f1
}

##################################################
# @ Function: IsDigits_sp
# @ Description: Check if a string contains only digits
# @ Usage: IsDigits_sp Num_String
# @ Return: exit code
# @ Example:
# @   if IsDigits_sp "$My_Str" ; then
# @       DoSomething
# @   fi
# @ End of function
##################################################
IsDigits_sp() {
    if IsInCharSet_sp "$1" [0-9] ; then
        return 0
    fi
    return 1
}

##################################################
# @ Function: GetSeq_sp
# @ Description: A shell replacement for seq command
# @ Usage: GetSeq_sp n1 n2
# @ Parameter: n1 - number 1
# @ Parameter: n2 - number 2
# @ Return: stdout
# @ Example:
# @     for num in `GetSeq_sp 2 10`; do
# @         doSomething $num
# @     done
# @ End of function
##################################################
GetSeq_sp() {
    IsNumber_sp $1 || return 1
    IsNumber_sp $2 || return 1
    My_GetSeq_sp_str=
    My_GetSeq_sp_n=$1
    My_GetSeq_sp_m=$2
    while [ $My_GetSeq_sp_n -le $My_GetSeq_sp_m ]; do
        if [ -z "$My_GetSeq_sp_str" ]; then
            My_GetSeq_sp_str=$My_GetSeq_sp_n
        else
            My_GetSeq_sp_str="$My_GetSeq_sp_str $My_GetSeq_sp_n"
        fi
        My_GetSeq_sp_n=`$EXPR $My_GetSeq_sp_n + 1`
    done
    $PRINT "$My_GetSeq_sp_str"
}

##################################################
# @ Function: TrimSpace_sp
# @ Description: Remove space and tab in a string
# @ Usage: TrimSpace_sp "str"
# @ Parameter: "str" - The string
# @ Return: stdout
# @ Example:
# @     TrimSpace_sp "My String"
# @ End of function
##################################################
TrimSpace_sp() {
    $PRINT "$1" | $TR -d ' \t'
}

##################################################
# @ Function: IsInCharSet_sp
# @ Description: Check a string' all char in char set
# @ Usage: IsInCharSet_sp "string" "charset"
# @ Parameter: string
# @ Parameter: charset
# @ Return: exit code
# @ Example:
# @   if IsInCharSet_sp "$My_Str" '[a-zA-Z0-9]' ; then
# @       DoSomething
# @   fi
# @ End of function
##################################################
IsInCharSet_sp() {
    if [ -z "$1" -o -z "$2" ]; then
        return 1
    fi
    My_IsInCharSet_sp_str=`$PRINT "$1" | $SED -e "s%${2}*%%g"`
    # My_IsInCharSet_sp_str=`$PRINT "$1" | $TR -d "$2"`
    if [ "$My_IsInCharSet_sp_str" = "" ]; then
        return 0
    fi
    return 1
}


##################################################
# @ Function: IsAlphaNumeric_sp
# @ Description: Check if a string contains digits and letters only
# @ Usage: IsAlphaNumeric_sp string
# @ Parameter: string
# @ Return: exit code
# @ Example:
# @   if IsAlphaNumeric_sp "$My_Str" ; then
# @       DoSomething
# @   fi
# @ End of function
##################################################
IsAlphaNumeric_sp() {
    if [ -z "$1" ]; then
        return 1
    fi
    if IsInCharSet_sp "$1" '[a-zA-Z0-9]' ; then
        return 0
    fi
    return 1
}

##################################################
# @ Function: IsNumber_sp
# @ Description: Check if a number is a arithmatic number
# @ Usage: IsNumber_sp number
# @ Parameter: number - The number string
# @ Return: exit code
# @ Example:
# @    if IsNumber_sp 1234 ; then
# @        DoSomething
# @    fi
# @ End of function
##################################################
IsNumber_sp() {
    if [ -z "$1" ]; then
        return 1
    fi
    My_IsNumber_sp_n1=`$PRINT "$1" | $SED -e 's/^+*//g' -e 's/[  ]*//g'`
    My_IsNumber_sp_n2=`$EXPR $My_IsNumber_sp_n1 \* 1 2>/dev/null`
    if [ -z "$My_IsNumber_sp_n2" ]; then
        return 1
    fi
    return 0
}

##################################################
# @ Function: GetSubStr_sp
# @ Description: Return a sub-string. If your expr does not support substr
# @ Usage: GetSubStr_sp string start end
# @ Parameter: string - The string
# @ Parameter: start - start from position (first letter is 1)
# @ Parameter: end - The end of position of substring
# @ Return: exit code, stdout
# @ Example:
# @    My_newstr=`GetSubStr_sp 1234567890 1 3`
# @ End of function
##################################################
GetSubStr_sp() {
    if IsNumber_sp $2 && IsNumber_sp $3 && [ $2 -gt 0 -a $3 -gt 0 ] ; then
        $PRINT "$1" | $CUT -c ${2}-${3}
        return 0
    fi
    return 1
}

##################################################
# @ Function: Str2Low_sp
# @ Description: Convert str to low case
# @ Usage: Str2Low_sp strings
# @ Parameter: strings - The string
# @ Return: stdout
# @ Example:
# @    My_newstr=`Str2Low_sp "AbCdEfG"`
# @ End of function
##################################################
Str2Low_sp() {
    $PRINT "$*" | $TR '[A-Z]' '[a-z]'
}

##################################################
# @ Function: Str2Upper_sp
# @ Description: Convert str to upper case
# @ Usage: Str2Upper_sp strings
# @ Parameter: strings - The string
# @ Return: stdout
# @ Example:
# @    My_newstr=`Str2Upper_sp "AbCdEfG"`
# @ End of function
##################################################
Str2Upper_sp() {
    $PRINT "$*" | $TR '[a-z]' '[A-Z]'
}

# End of script
