$PRINT "Test functions ..."
$PRINT "Test function GetTimeStamp_sp, ..."
$PRINT "The current GetTimeStamp_sp is `GetTimeStamp_sp`"
$PRINT "Test function GetTimeStamp_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function GetTimeStamp2_sp, ..."
$PRINT "The current GetTimeStamp2_sp is `GetTimeStamp2_sp`"
$PRINT "Test function GetTimeStamp2_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function Month2Name_sp, ..."
$PRINT "Run Month2Name_sp 01, return `Month2Name_sp 01`"
$PRINT "Run Month2Name_sp 02, return `Month2Name_sp 02`"
$PRINT "Run Month2Name_sp 03, return `Month2Name_sp 03`"
$PRINT "Run Month2Name_sp 04, return `Month2Name_sp 04`"
$PRINT "Run Month2Name_sp 05, return `Month2Name_sp 05`"
$PRINT "Run Month2Name_sp 06, return `Month2Name_sp 06`"
$PRINT "Run Month2Name_sp 07, return `Month2Name_sp 07`"
$PRINT "Run Month2Name_sp 08, return `Month2Name_sp 08`"
$PRINT "Run Month2Name_sp 09, return `Month2Name_sp 09`"
$PRINT "Run Month2Name_sp 10, return `Month2Name_sp 10`"
$PRINT "Run Month2Name_sp 11, return `Month2Name_sp 11`"
$PRINT "Run Month2Name_sp 12, return `Month2Name_sp 12`"
$PRINT "Test function Month2Name_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function Name2Month_sp, ..."
$PRINT "Run Name2Month_sp Jan, return `Name2Month_sp Jan`"
$PRINT "Run Name2Month_sp Febu, return `Name2Month_sp Febu`"
$PRINT "Run Name2Month_sp March, return `Name2Month_sp March`"
$PRINT "Run Name2Month_sp apr, return `Name2Month_sp apr`"
$PRINT "Run Name2Month_sp May, return `Name2Month_sp May`"
$PRINT "Run Name2Month_sp JUNE, return `Name2Month_sp JUNE`"
$PRINT "Run Name2Month_sp july, return `Name2Month_sp july`"
$PRINT "Run Name2Month_sp August, return `Name2Month_sp August`"
$PRINT "Run Name2Month_sp September, return `Name2Month_sp September`"
$PRINT "Run Name2Month_sp October, return `Name2Month_sp October`"
$PRINT "Run Name2Month_sp Nov, return `Name2Month_sp Nov`"
$PRINT "Run Name2Month_sp Dec, return `Name2Month_sp Dec`"
$PRINT "Run Name2Month_sp Error, return `Name2Month_sp Error`"
$PRINT "Test function Name2Month_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function IsLeapYear_sp, ..."
for y in `$SEQ 2000 2012` ; do
    if IsLeapYear_sp $y ; then
        $PRINT "$y is a leap year."
    else
        $PRINT "$y is not leap year."
    fi
done
$PRINT "Test function IsLeapYear_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function GetPreYear_sp, ..."
for y in `$SEQ 2000 2012` ; do
    $PRINT "The year before $y is `GetPreYear_sp $y`."
done
$PRINT "Test function GetPreYear_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function GetNextYear_sp, ..."
for y in `$SEQ 2000 2012` ; do
    $PRINT "The next year of $y is `GetNextYear_sp $y`."
done
$PRINT "Test function GetNextYear_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function GetDaysInMonth_sp, ..."
for m in `$SEQ 1 12` ; do
    $PRINT "The number of days in 2000-$m is `GetDaysInMonth_sp 2000-$m`"
done
$PRINT "Test function GetDaysInMonth_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function IsValidDate_sp, ..."
for m in `$SEQ 25 32` ; do
    if IsValidDate_sp "2011-03-$m" ; then
        $PRINT "The date 2011-03-$m is a valid date."
    else
        $PRINT "The date 2011-03-$m is not a valid date."
    fi
done
$PRINT "Test function IsValidDate_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function GetNextMonth_sp, ..."
for m in `$SEQ 1 12` ; do
    $PRINT "The next month of 2011-$m is `GetNextMonth_sp 2011-$m`"
done
$PRINT "Test function GetNextMonth_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function GetPreMonth_sp, ..."
for m in `$SEQ 1 12` ; do
    $PRINT "The month before 2011-$m is `GetPreMonth_sp 2011-$m`"
done
$PRINT "Test function GetPreMonth_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function GetPreDay_sp, ..."
for m in `$SEQ 1 5` ; do
    $PRINT "The day before 2011-03-$m is `GetPreDay_sp 2011-03-$m`"
done
$PRINT "Test function GetPreDay_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function GetNextDay_sp, ..."
for m in `$SEQ 25 31` ; do
    $PRINT "The next day of 2011-03-$m is `GetNextDay_sp 2011-03-$m`"
done
$PRINT "Test function GetNextDay_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function GetWeekday_sp, ..."
for m in `$SEQ 20 31` ; do
    $PRINT "The weekday of 2011-03-$m is `GetWeekday_sp 2011-03-$m`"
done
$PRINT "Test function GetWeekday_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function GetToday_sp, ..."
$PRINT "Today is `GetToday_sp`"
$PRINT "Test function GetToday_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function GetYesterady_sp, ..."
$PRINT "Yesterday is `GetYesterady_sp`"
$PRINT "Test function GetYesterady_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function GetTomorrow_sp, ..."
$PRINT "Tomorrow is `GetTomorrow_sp`"
$PRINT "Test function GetTomorrow_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function GetThisMonth_sp, ..."
$PRINT "This month is `GetThisMonth_sp`"
$PRINT "Test function GetThisMonth_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function GetThisYear_sp, ..."
$PRINT "This year is `GetThisYear_sp`"
$PRINT "Test function GetThisYear_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function GetLastMonth_sp, ..."
$PRINT "Last year is `GetLastMonth_sp`"
$PRINT "Test function GetLastMonth_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function GetLastYear_sp, ..."
$PRINT "Last year is `GetLastYear_sp`"
$PRINT "Test function GetLastYear_sp, done"
$PRINT "================================================="
$PRINT
my_now=`GetNow_sp`
my_time=`GetNow_sp | cut -d' ' -f2`
$PRINT "Test function GetNow_sp, ..."
$PRINT "Now it is $my_now"
$PRINT "Test function GetNow_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function IsValidTime_sp, ..."
if IsValidTime_sp "$my_time" ; then
    $PRINT "$my_time is valid time"
else
    $PRINT "$my_time is invalid time"
fi
$PRINT "Test function IsValidDateTime_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function IsValidDateTime_sp, ..."
if IsValidDateTime_sp "$my_now" ; then
    $PRINT "$my_now is valid date-time"
else
    $PRINT "$my_now is invalid date-time"
fi
$PRINT "Test function DateTime2Epoch_sp, done"
$PRINT "================================================="
$PRINT
my_epoch=`DateTime2Epoch_sp "$my_now"`
$PRINT "Test function DateTime2Epoch_sp, ..."
$PRINT "$my_now eposh value is $my_epoch"
$PRINT "Test function DateTime2Epoch_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function Epoch2DateTime_sp, ..."
$PRINT "eposh $my_epoch date-time is `Epoch2DateTime_sp "$my_epoch"`"
$PRINT "Test function Epoch2DateTime_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function ComputeTime_sp, ..."
$PRINT "$my_now + 35 seconds is `ComputeTime_sp "$my_now" 35`"
$PRINT "$my_now - 60 seconds is `ComputeTime_sp "$my_now" -60`"
$PRINT "Test function ComputeTime_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function ComputeMinute_sp, ..."
$PRINT "$my_now + 135 minutes is `ComputeMinute_sp "$my_now" 135`"
$PRINT "$my_now - 60 minutes is `ComputeMinute_sp "$my_now" -60`"
$PRINT "Test function ComputeMinute_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function ComputeHour_sp, ..."
$PRINT "$my_now + 24 hours is `ComputeHour_sp "$my_now" 24`"
$PRINT "$my_now - 48 hours is `ComputeHour_sp "$my_now" -48`"
$PRINT "Test function ComputeHour_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function ComputeDay_sp, ..."
$PRINT "$my_now + 15 days is `ComputeDay_sp "$my_now" +15`"
$PRINT "$my_now - 17 days is `ComputeDay_sp "$my_now" -17`"
$PRINT "Test function ComputeDay_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function ComputeYear_sp, ..."
thisYear=`GetThisYear_sp`
for i in `$SEQ -5 5` ; do
    $PRINT "Year $thisYear + $i = `ComputeYear_sp "$thisYear" $i`"
done
$PRINT "Test function ComputeYear_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test function ComputeMonth_sp, ..."
thisMon=`GetThisMonth_sp`
for i in `$SEQ -5 5` ; do
    $PRINT "Month $thisMon + $i = `ComputeMonth_sp "$thisMon" $i`"
done
$PRINT "Test function ComputeMonth_sp, done"
$PRINT "================================================="
$PRINT
$PRINT "Test functions, done."
