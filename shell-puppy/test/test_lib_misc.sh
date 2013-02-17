$PRINT "Test functions ..."
$PRINT "Test function GetRandomNum_sp, ..."
$PRINT "GetRandomNum_sp=`GetRandomNum_sp`"
$PRINT "GetRandomNum_sp=`GetRandomNum_sp`"
$PRINT "GetRandomNum_sp=`GetRandomNum_sp`"
$PRINT "GetRandomNum_sp=`GetRandomNum_sp`"
$PRINT "GetRandomNum_sp=`GetRandomNum_sp`"
$PRINT "Test function GetRandomNum_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function IsDigits_sp, ..."
for i in -12 12 34 1b xy safas `GetRandomNum_sp`; do
    if IsDigits_sp $i ; then
        $PRINT "$i is digits"
    else
        $PRINT "$i is not digits"
    fi
done
$PRINT "Test function IsDigits_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function GetSeq_sp, ..."
for i in `GetSeq_sp 2011 2020`; do
    $PRINT  "$i"
done
$PRINT "Test function GetSeq_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function TrimSpace_sp, ..."
$PRINT "TrimSpace_sp \"abcd adfas asfsad 111\", return `TrimSpace_sp \"abcd adfas asfsad 111\"`"
$PRINT "Test function TrimSpace_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function IsInCharSet_sp, ..."
for i in 12 34 1b xy safas Abcd `GetRandomNum_sp`; do
    if IsInCharSet_sp "$i" '[a-z]' ; then
        $PRINT "$i is in char set [a-z]"
    else
        $PRINT "$i is not in char set [a-z]"
    fi
done
$PRINT "Test function IsInCharSet_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function IsAlphaNumeric_sp, ..."
for i in 12 34 1b xy safas Abcd `GetRandomNum_sp`; do
    if IsAlphaNumeric_sp "$i" ; then
        $PRINT "$i is alphanumberic"
    else
        $PRINT "$i is not alphanumberic"
    fi
done
$PRINT "Test function IsAlphaNumeric_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function IsNumber_sp, ..."
for i in -12 12 34 1b xy safas `GetRandomNum_sp`; do
    if IsNumber_sp $i ; then
        $PRINT "$i is arithmatic number."
    else
        $PRINT "$i is not arithmatic number."
    fi
done
$PRINT "Test function IsDigits_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function GetSubStr_sp, ..."
$PRINT "GetSubStr_sp 1234567890 3 6 = `GetSubStr_sp 1234567890 3 6`"
$PRINT "GetSubStr_sp 1234567890 3 -6 = `GetSubStr_sp 1234567890 3 -6`"
$PRINT "Test function GetSubStr_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function Str2Low_sp, ..."
$PRINT "Str2Low_sp AbCdEfGh = `Str2Low_sp AbCdEfGh`"
$PRINT "Test function Str2Low_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function Str2Upper_sp, ..."
$PRINT "Str2Upper_sp AbCdEfGh = `Str2Upper_sp AbCdEfGh`"
$PRINT "Test function Str2Upper_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test functions, done."
