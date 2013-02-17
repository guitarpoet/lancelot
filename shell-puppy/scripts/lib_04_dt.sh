##################################################
# $Id: lib_04_dt.sh 13 2011-03-27 00:19:04Z Allen.Zhao@gmail.com $
##################################################
# @ File: lib_dt.sh
# @ Description: Date and Time shell functions.
# @ Dependency: lib_misc.sh, lib_user.sh
# @ Author: Allen Zhao
# @ Email: allen.zhao@gmail.com
# @ End of file
##################################################

##################################################
# Function: Private_Pad00_sp
# Description: Make day and month look like DD or MM
# Usage: Private_Pad00_sp num
# Return: stdout
# End of function
##################################################
Private_Pad00_sp() {
    if IsDigits_sp "$1" ; then
        My_Private_Pad00_sp_dd=`$EXPR $1 + 0` 
        if [ $My_Private_Pad00_sp_dd -ge 0 -a $My_Private_Pad00_sp_dd -lt 10 ]; then
            $PRINT "0${My_Private_Pad00_sp_dd}"
        else
            $PRINT "${My_Private_Pad00_sp_dd}"
        fi
        return 0
    fi
    $PRINT "$1"
}

##################################################
# @ Function: GetTimeStamp_sp
# @ Description: Get a current time stamp in fomat YYYY-MM-dd HH:mm:ss
# @ Usage: GetTimeStamp_sp
# @ Return: stdout
# @ Example:
# @   My_Curr_Time=`GetTimeStamp_sp`
# @ End of function
##################################################
GetTimeStamp_sp() {
    $DATE '+%Y-%m-%d %H:%M:%S'
}

##################################################
# @ Function: GetTimeStamp2_sp
# @ Description: Get a current time stamp in fomat YYYYMMddHHmmss
# @ Usage: GetTimeStamp2_sp
# @ Return: stdout
# @ Example:
# @   My_Curr_Time=`GetTimeStamp2_sp`
# @ End of function
##################################################
GetTimeStamp2_sp() {
    $DATE '+%Y%m%d%H%M%S'
}

##################################################
# @ Function: Month2Name_sp
# @ Description: Convert month number to name
# @ Usage: Month2Name_sp month-num [-f]
# @ Parameter: month-num. 0-12
# @ Parameter: -f - Print full name
# @ Return: exit code, stdout
# @ Example:
# @   My_mn=`Month2Name_sp 12` # Dec
# @ End of function
##################################################
Month2Name_sp() {
    IsDigits_sp "$1" || return 1
    My_Month2Name_name=
    case $1 in
        01|1)
            My_Month2Name_name="January" ;;
        02|2)
            My_Month2Name_name="February" ;;
        03|3)
            My_Month2Name_name="March" ;;
        04|4)
            My_Month2Name_name="April" ;;
        05|5)
            My_Month2Name_name="May" ;;
        06|6)
            My_Month2Name_name="June" ;;
        07|7)
            My_Month2Name_name="July" ;;
        08|8)
            My_Month2Name_name="August" ;;
        09|9)
            My_Month2Name_name="September" ;;
        10)
            My_Month2Name_name="October" ;;
        11)
            My_Month2Name_name="November" ;;
        12)
            My_Month2Name_name="December" ;;
        *)
            M_Month2Name_sp="Invalid month number."
            return 1 ;;
    esac
    if [ "$2" = "-f" ]; then
        $PRINT "$My_Month2Name_name"
    else
       GetSubStr_sp "$My_Month2Name_name" 1 3
       #$EXPR substr "$My_Month2Name_name" 1 3
    fi
    return 0
}

##################################################
# @ Function: Name2Month_sp
# @ Description: Convert month name to number
# @ Usage: Name2Month_sp month-name
# @ Parameter: month-name
# @ Return: exit code, stdout, variable (error msg)
# @ Example:
# @   My_mn=`Name2Month_sp Jan` # My_mn=01
# @ End of function
##################################################
Name2Month_sp() {
    My_Name2Month_sp=`$PRINT "$1" | $TR '[A-Z]' '[a-z]'`
    case $My_Name2Month_sp in
        jan*)
            $PRINT "01" ;;
        feb*)
            $PRINT "02" ;;
        mar*)
            $PRINT "03" ;;
        apr*)
            $PRINT "04" ;;
        may*)
            $PRINT "05" ;;
        jun*)
            $PRINT "06" ;;
        jul*)
            $PRINT "07" ;;
        aug*)
            $PRINT "08" ;;
        sep*)
            $PRINT "09" ;;
        oct*)
            $PRINT "10" ;;
        nov*)
            $PRINT "11" ;;
        dec*)
            $PRINT "12" ;;
        *)
            M_Name2Month_sp="Invalid month name."
            return 1 ;;
    esac
    return 0
}

##################################################
# @ Function: IsLeapYear_sp
# @ Description: Check if the year is a leap year
# @ Usage: IsLeapYear_sp YYYY
# @ Parameter: YYYY - The year
# @ Return: exit code, variable (error msg)
# @ Example:
# @    if IsLeapYear_sp 2001 ; then
# @        DoSomething
# @    fi
# @ End of function
##################################################
IsLeapYear_sp() {
    My_IsLeapYear_sp_year=`TrimSpace_sp "$1"`
    IsDigits_sp "$My_IsLeapYear_sp_year" || {
        M_IsLeapYear_sp="Invalid year."
        return 1
    }
    if [ `$EXPR $My_IsLeapYear_sp_year % 4` -ne 0 ]; then
        return 1
    elif [ `$EXPR $My_IsLeapYear_sp_year % 400` -eq 0 ]; then
        return 0
    elif [ `$EXPR $My_IsLeapYear_sp_year % 100` -eq 0 ]; then
        return 1
    fi
    return 0
}

##################################################
# @ Function: GetPreYear_sp
# @ Description: Get the last year
# @ Usage: GetPreYear_sp YYYY
# @ Parameter: YYYY - The year
# @ Return: exit code, stdout, variable (error msg)
# @ Example:
# @    My_year=`GetPreYear_sp 2011` # My_year=2010
# @ End of function
##################################################
GetPreYear_sp() {
    My_GetPreYear_sp_year=`TrimSpace_sp "$1"`
    IsDigits_sp "$My_GetPreYear_sp_year" || {
        M_GetPreYear_sp="Invalid year."
        return 1
    }
    $EXPR $My_GetPreYear_sp_year - 1
}

##################################################
# @ Function: GetNextYear_sp
# @ Description: Get the next year
# @ Usage: GetNextYear_sp YYYY
# @ Parameter: YYYY - The year
# @ Return: exit code, stdout, variable (error msg)
# @ Example:
# @    My_year=`GetNextYear_sp 2011` # My_year=2012
# @ End of function
##################################################
GetNextYear_sp() {
    My_GetNextYear_sp_year=`TrimSpace_sp "$1"`
    IsDigits_sp "$My_GetNextYear_sp_year" || {
        M_GetNextYear_sp="Invalid year."
        return 1
    }
    $EXPR $My_GetNextYear_sp_year + 1
}

##################################################
# @ Function: GetDaysInMonth_sp
# @ Description: Get the number days in a month
# @ Usage: GetDaysInMonth_sp YYYY-MM
# @ Parameter: YYYY-MM - The year-month
# @ Return: exit code, stdout, variable (error msg)
# @ Example:
# @    My_year=`GetNextYear_sp 2011` # My_year=2012
# @ End of function
##################################################
GetDaysInMonth_sp() {
    My_GetDaysInMonth_sp_year=`$PRINT "$1" | $CUT -d'-' -f 1`
    My_GetDaysInMonth_sp_mon=`$PRINT "$1" | $CUT -d'-' -f 2`
    if IsDigits_sp "$My_GetDaysInMonth_sp_year" ; then
        case $My_GetDaysInMonth_sp_mon in
            1|01)
                $PRINT "31" ;;
            2|02)
                if IsLeapYear_sp "$My_GetDaysInMonth_sp_year" ; then
                    $PRINT "29"
                else
                    $PRINT "28"
                fi ;;
            3|03)
                $PRINT "31" ;;
            4|04)
                $PRINT "30" ;;
            5|05)
                $PRINT "31" ;;
            6|06)
                $PRINT "30" ;;
            7|07)
                $PRINT "31" ;;
            8|08)
                $PRINT "31" ;;
            9|09)
                $PRINT "30" ;;
            10|10)
                $PRINT "31" ;;
            11|11)
                $PRINT "30" ;;
            12|12)
                $PRINT "31" ;;
            *)
                GetDaysInMonth_sp="Invalid month."
                return 1
        esac
        return 0
    fi
    GetDaysInMonth_sp="Invalid year."
    return 1
}

##################################################
# @ Function: IsValidDate_sp
# @ Description: Get the last month
# @ Usage: IsValidDate_sp YYYY-MM-DD
# @ Parameter: YYYY-MM-DD - The date
# @ Return: exit code, variable (error msg)
# @ Example:
# @    if IsValidDate_sp '2010-11-12' ;
# @        DoSomething
# @    fi
# @ End of function
##################################################
IsValidDate_sp() {
    My_IsValidDate_sp_year=`$PRINT "$1" | $CUT -d'-' -f 1`
    My_IsValidDate_sp_mon=`$PRINT "$1" | $CUT -d'-' -f 2`
    My_IsValidDate_sp_day=`$PRINT "$1" | $CUT -d'-' -f 3`
    if IsDigits_sp "$My_IsValidDate_sp_year" && IsDigits_sp "$My_IsValidDate_sp_mon" && IsDigits_sp "$My_IsValidDate_sp_day" ; then
        if [ $My_IsValidDate_sp_mon -lt 0 -o $My_IsValidDate_sp_mon -gt 12 ]; then
            M_IsValidDate_sp="Invalid month."
            return 1
        fi
        if My_IsValidDate_sp_alldays=`GetDaysInMonth_sp "${My_IsValidDate_sp_year}-${My_IsValidDate_sp_mon}"` ; then
            if [ $My_IsValidDate_sp_day -lt 1 -o $My_IsValidDate_sp_day -gt $My_IsValidDate_sp_alldays ]; then
                M_IsValidDate_sp="Invalid day of month."
                return 1
            else
                return 0
            fi
        else
            M_IsValidDate_sp="GetDaysInMonth error."
            return 1
        fi
    else
        return 1
    fi
}

##################################################
# @ Function: GetNextMonth_sp
# @ Description: Get the next month
# @ Usage: GetNextMonth_sp YYYY-MM
# @ Parameter: YYYY-MM - The year and month
# @ Return: exit code, stdout, variable (error msg)
# @ Example:
# @    My_year_mon=`GetNextMonth_sp 2011-12` # My_yearmon='2012-01'
# @ End of function
##################################################
GetNextMonth_sp() {
    My_GetNextMonth_sp_year=`$PRINT "$1" | $CUT -d'-' -f 1`
    My_GetNextMonth_sp_mon=`$PRINT "$1" | $CUT -d'-' -f 2`
    if IsDigits_sp "$My_GetNextMonth_sp_year" && IsDigits_sp "$My_GetNextMonth_sp_mon" ; then
        if [ $My_GetNextMonth_sp_mon -lt 1 -o $My_GetNextMonth_sp_mon -gt 12 ]; then
            M_GetNextMonth_sp="Invalid month."
            return 1
        fi
        if [ $My_GetNextMonth_sp_mon -eq 12 ] ; then
            if My_GetNextMonth_sp_year=`GetNextYear_sp $My_GetNextMonth_sp_year` ; then
                $PRINT "${My_GetNextMonth_sp_year}-01"
            else
                M_GetNextMonth_sp="GetNexYear error."
                return 1
            fi
        else
            My_GetNextMonth_sp_mon=`$EXPR $My_GetNextMonth_sp_mon + 1`
            My_GetNextMonth_sp_mon=`Private_Pad00_sp "$My_GetNextMonth_sp_mon"`
            $PRINT "${My_GetNextMonth_sp_year}-${My_GetNextMonth_sp_mon}"
        fi
    else
        GetNextMonth_sp="Invalid year-month."
        return 1
    fi
    return 0
}

##################################################
# @ Function: GetPreMonth_sp
# @ Description: Get the last month
# @ Usage: GetPreMonth_sp YYYY-MM
# @ Parameter: YYYY-MM - The year and month
# @ Return: exit code, stdout, variable (error msg)
# @ Example:
# @    My_year_mon=`GetPreMonth_sp 2011-01` # My_yearmon='2010-12'
# @ End of function
##################################################
GetPreMonth_sp() {
    My_GetPreMonth_sp_year=`$PRINT "$1" | $CUT -d'-' -f 1`
    My_GetPreMonth_sp_mon=`$PRINT "$1" | $CUT -d'-' -f 2`
    if IsDigits_sp "$My_GetPreMonth_sp_year" && IsDigits_sp "$My_GetPreMonth_sp_mon" ; then
        if [ $My_GetPreMonth_sp_mon -lt 1 -o $My_GetPreMonth_sp_mon -gt 12 ]; then
            M_GetPreMonth_sp="Invalid month."
            return 1
        fi
        if [ $My_GetPreMonth_sp_mon -eq 1 ] ; then
            if My_GetPreMonth_sp_year=`GetPreYear_sp $My_GetPreMonth_sp_year` ; then
                $PRINT "${My_GetPreMonth_sp_year}-12"
            else
                M_GetPreMonth_sp="GetNexYear error."
                return 1
            fi
        else
            My_GetPreMonth_sp_mon=`$EXPR $My_GetPreMonth_sp_mon - 1`
            My_GetPreMonth_sp_mon=`Private_Pad00_sp "$My_GetPreMonth_sp_mon"`
            $PRINT "${My_GetPreMonth_sp_year}-${My_GetPreMonth_sp_mon}"
        fi
    else
        GetPreMonth_sp="Invalid year-month."
        return 1
    fi
    return 0
}

##################################################
# @ Function: GetPreDay_sp
# @ Description: Get yesterday's date
# @ Usage: GetPreDay_sp YYYY-MM-DD
# @ Parameter: YYYY-MM-DD - The date
# @ Return: exit code, stdout, variable (error msg)
# @ Example:
# @    My_year_mon=`GetPreDay_sp 2011-01-01` # My_yearmon='2010-12-31'
# @ End of function
##################################################
GetPreDay_sp() {
    IsValidDate_sp "$1" || {
        M_GetPreDay_sp="Invalid date."
        return 1
    }
    My_GetPreDay_sp_year=`$PRINT "$1" | $CUT -d'-' -f 1`
    My_GetPreDay_sp_mon=`$PRINT "$1" | $CUT -d'-' -f 2`
    My_GetPreDay_sp_day=`$PRINT "$1" | $CUT -d'-' -f 3`
    if [ $My_GetPreDay_sp_day -eq 1 ]; then
        if My_GetPreDay_sp_lastmon=`GetPreMonth_sp "${My_GetPreDay_sp_year}-${My_GetPreDay_sp_mon}"` ; then
            My_GetPreDay_sp_day_preday=`GetDaysInMonth_sp $My_GetPreDay_sp_lastmon` || {
                M_GetPreDay_sp="GetDaysInMonth error."
                return 1
            }
        else
            M_GetPreDay_sp="GetLastMonth error."
            return 1
        fi
    else
        My_GetPreDay_sp_mon=`Private_Pad00_sp "$My_GetPreDay_sp_mon"`
        My_GetPreDay_sp_lastmon="${My_GetPreDay_sp_year}-${My_GetPreDay_sp_mon}"
        My_GetPreDay_sp_day_preday=`$EXPR $My_GetPreDay_sp_day - 1`
        My_GetPreDay_sp_day_preday=`Private_Pad00_sp "$My_GetPreDay_sp_day_preday"`
    fi
    $PRINT "${My_GetPreDay_sp_lastmon}-${My_GetPreDay_sp_day_preday}"
    return 0
}

##################################################
# @ Function: GetNextDay_sp
# @ Description: Get tomorrow's date
# @ Usage: GetNextDay_sp YYYY-MM-DD
# @ Parameter: YYYY-MM-DD - The date
# @ Return: exit code, stdout, variable (error msg)
# @ Example:
# @    My_year_mon=`GetNextDay_sp 2011-12-31` # My_yearmon='2012-01-01'
# @ End of function
##################################################
GetNextDay_sp() {
    IsValidDate_sp "$1" || {
        M_GetNextDay_sp="Invalid date."
        return 1
    }
    My_GetNextDay_sp_year=`$PRINT "$1" | $CUT -d'-' -f 1`
    My_GetNextDay_sp_mon=`$PRINT "$1" | $CUT -d'-' -f 2`
    My_GetNextDay_sp_mon=`Private_Pad00_sp "$My_GetNextDay_sp_mon"`
    My_GetNextDay_sp_day=`$PRINT "$1" | $CUT -d'-' -f 3`
    My_GetNextDay_sp_ym="${My_GetNextDay_sp_year}-${My_GetNextDay_sp_mon}"
    My_GetNextDay_sp_alldays=`GetDaysInMonth_sp "$My_GetNextDay_sp_ym"` || {
        M_GetNextDay_sp="GetDaysInMonth error."
        return 1
    }
    if [ $My_GetNextDay_sp_day -eq $My_GetNextDay_sp_alldays ]; then
        if My_GetNextDay_sp_ym=`GetNextMonth_sp "$My_GetNextDay_sp_ym"` ; then
            My_GetNextDay_sp_nextday=01
        else
            M_GetNextDay_sp="GetNextMonth error."
            return 1
        fi
    else
        My_GetNextDay_sp_nextday=`$EXPR $My_GetNextDay_sp_day + 1`
    fi
    My_GetNextDay_sp_nextday=`Private_Pad00_sp "$My_GetNextDay_sp_nextday"`
    $PRINT "${My_GetNextDay_sp_ym}-${My_GetNextDay_sp_nextday}"
    return 0
}

##################################################
# @ Function: GetWeekday_sp
# @ Description: Get tomorrow's date
# @ Usage: GetWeekday_sp YYYY-MM-DD [-f]
# @ Parameter: YYYY-MM-DD - The date
# @ Parameter: -f - Return full name
# @ Return: exit code, stdout, variable (error msg)
# @ Example:
# @    My_year_mon=`GetWeekday_sp 2011-12-31` # My_yearmon='2012-01-01'
# @ End of function
##################################################
# This one based on perl
GetWeekday_sp() {
    IsValidDate_sp "$1" || {
        M_GetWeekday_sp="Invalid date and time"
        return 1
    }
    M_GetWeekday_sp_ym=`$PRINT "$1" | $PERL -e '
use Time::Local;
while (<>) {
  my $s = $_;
  my($year, $month, $day, $hour, $minute, $second);

  if($s =~ m{^\s*(\d{1,4})\W*0*(\d{1,2})\W*0*(\d{1,2})\W*0*
                 (\d{0,2})\W*0*(\d{0,2})\W*0*(\d{0,2})}x) {
    $year = $1;  $month = $2;   $day = $3;
    $hour = $4;  $minute = $5;  $second = $6;
    $hour |= 0;  $minute |= 0;  $second |= 0;  # defaults.
    $year = ($year<100 ? ($year<70 ? 2000+$year : 1900+$year) : $year);
    ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(timelocal($second,$minute,$hour,$day,$month-1,$year));
    if ( $wday eq 0 ) { print "Sunday", "\n"; exit(0); }
    if ( $wday eq 1 ) { print "Monday", "\n"; exit(0); }
    if ( $wday eq 2 ) { print "Tuesday", "\n"; exit(0); }
    if ( $wday eq 3) { print "Wednesday", "\n"; exit(0); }
    if ( $wday eq 4) { print "Thursday", "\n"; exit(0); }
    if ( $wday eq 5 ) { print "Friday", "\n"; exit(0); }
    if ( $wday eq 6 ) { print "Saturday", "\n"; exit(0); }
    exit(1);
  } else { exit(1); }
}
exit(1);
'`
    if [ -z "$M_GetWeekday_sp_ym" ] ; then
        return 1
    fi
    if [ ! "$2" = "-f" ]; then
        M_GetWeekday_sp_ym=`GetSubStr_sp "$M_GetWeekday_sp_ym" 1 3`
    fi
    $PRINT "$M_GetWeekday_sp_ym"
}

GetWeekday2_sp() {
    IsValidDate_sp "$1" || {
        M_GetWeekday_sp="Invalid date."
        return 1
    }
    My_GetWeekday_sp_year=`$PRINT "$1" | $CUT -d'-' -f 1`
    My_GetWeekday_sp_mon=`$PRINT "$1" | $CUT -d'-' -f 2`
    My_GetWeekday_sp_day=`$PRINT "$1" | $CUT -d'-' -f 3 | $SED -e 's/^0//g'`
    My_GetWeekday_sp_cal="`$CAL $My_GetWeekday_sp_mon $My_GetWeekday_sp_year`"
    if $PRINT "$My_GetWeekday_sp_cal" | $CUT -c 1-2 | $GREP -w $My_GetWeekday_sp_day 1>/dev/null; then
        if [ "$2" = "-f" ]; then
            $PRINT "Sunday"
        else
            $PRINT "Sun"
        fi
        return 0
    fi
    if $PRINT "$My_GetWeekday_sp_cal" | $CUT -c 4-5 | $GREP -w $My_GetWeekday_sp_day 1>/dev/null; then
        if [ "$2" = "-f" ]; then
            $PRINT "Monday"
        else
            $PRINT "Mon"
        fi
        return 0
    fi
    if $PRINT "$My_GetWeekday_sp_cal" | $CUT -c 7-8 | $GREP -w $My_GetWeekday_sp_day 1>/dev/null; then
        if [ "$2" = "-f" ]; then
            $PRINT "Tuesday"
        else
            $PRINT "Tue"
        fi
        return 0
    fi
    if $PRINT "$My_GetWeekday_sp_cal" | $CUT -c 10-11 | $GREP -w $My_GetWeekday_sp_day 1>/dev/null; then
        if [ "$2" = "-f" ]; then
            $PRINT "Wednesday"
        else
            $PRINT "Wed"
        fi
        return 0
    fi
    if $PRINT "$My_GetWeekday_sp_cal" | $CUT -c 13-14 | $GREP -w $My_GetWeekday_sp_day 1>/dev/null; then
        if [ "$2" = "-f" ]; then
            $PRINT "Thursday"
        else
            $PRINT "Thu"
        fi
        return 0
    fi
    if $PRINT "$My_GetWeekday_sp_cal" | $CUT -c 16-17 | $GREP -w $My_GetWeekday_sp_day 1>/dev/null; then
        if [ "$2" = "-f" ]; then
            $PRINT "Friday"
        else
            $PRINT "Fri"
        fi
        return 0
    fi
    if $PRINT "$My_GetWeekday_sp_cal" | $CUT -c 19-20 | $GREP -w $My_GetWeekday_sp_day 1>/dev/null; then
        if [ "$2" = "-f" ]; then
            $PRINT "Saturday"
        else
            $PRINT "Sat"
        fi
        return 0
    fi
    M_GetWeekday_sp="Unknown error."
    return 1
}

##################################################
# @ Function: GetToday_sp
# @ Description: Get Today's date
# @ Usage: GetToday_sp
# @ Return: stdout
# @ Example:
# @    My_day=`GetToday_sp` # return YYYY-MM-dd
# @ End of function
##################################################
GetToday_sp() {
    $DATE '+%Y-%m-%d'
}

##################################################
# @ Function: GetYesterady_sp
# @ Description: Get yesterady's date
# @ Usage: GetYesterady_sp
# @ Return: stdout
# @ Example:
# @    My_day=`GetYesterady_sp` # return YYYY-MM-dd
# @ End of function
##################################################
GetYesterady_sp() {
    GetPreDay_sp "`GetToday_sp`"
}

##################################################
# @ Function: GetTomorrow_sp
# @ Description: Get Tomorrow's date
# @ Usage: GetTomorrow_sp
# @ Return: stdout
# @ Example:
# @    My_day=`GetTomorrow_sp` # return YYYY-MM-dd
# @ End of function
##################################################
GetTomorrow_sp() {
    GetNextDay_sp "`GetToday_sp`"
}

##################################################
# @ Function: GetThisMonth_sp
# @ Description: Get This month in format YYYY-MM
# @ Usage: GetThisMonth_sp
# @ Return: stdout
# @ Example:
# @    My_mon=`GetThisMonth_sp` # return YYYY-MM
# @ End of function
##################################################
GetThisMonth_sp() {
    $DATE '+%Y-%m'
}

##################################################
# @ Function: GetThisYear_sp
# @ Description: Get This year in format YYYY
# @ Usage: GetThisYear_sp
# @ Return: stdout
# @ Example:
# @    My_mon=`GetThisYear_sp` # return YYYY
# @ End of function
##################################################
GetThisYear_sp() {
    $DATE '+%Y'
}

##################################################
# @ Function: GetLastMonth_sp
# @ Description: Get last month in format YYYY-MM
# @ Usage: GetLastMonth_sp
# @ Return: stdout
# @ Example:
# @    My_mon=`GetLastMonth_sp` # return YYYY-MM
# @ End of function
##################################################
GetLastMonth_sp() {
    GetPreMonth_sp "`GetThisMonth_sp`"
}

##################################################
# @ Function: GetLastYear_sp
# @ Description: Get last year in format YYYY
# @ Usage: GetLastYear_sp
# @ Return: stdout
# @ Example:
# @    My_mon=`GetLastYear_sp` # return YYYY
# @ End of function
##################################################
GetLastYear_sp() {
    GetPreYear_sp "`GetThisYear_sp`"
}

##################################################
# @ Function: GetNow_sp
# @ Description: Get a current time in fomat YYYY-MM-dd HH:mm:ss
# @ Usage: GetNow_sp
# @ Return: stdout
# @ Example:
# @   My_now=`GetNow_sp`
# @ End of function
##################################################
GetNow_sp() {
    $DATE '+%Y-%m-%d %H:%M:%S'
}

##################################################
# @ Function: IsValidTime_sp
# @ Description: Check if time is valid
# @ Usage: IsValidTime_sp "HH:MM:SS"
# @ Parameter: "HH:MM:SS" - the time
# @ Return: stdout
# @ Example:
# @    if IsValidTime_sp "11:11:11" ; 
# @         DoSomething
# @    fi
# @ End of function
##################################################
IsValidTime_sp() {
    My_IsValidTime_sp_h=`$PRINT "$1" | $CUT -d':' -f1`
    My_IsValidTime_sp_m=`$PRINT "$1" | $CUT -d':' -f2`
    My_IsValidTime_sp_s=`$PRINT "$1" | $CUT -d':' -f3`
    if IsDigits_sp "$My_IsValidTime_sp_h" && IsDigits_sp "$My_IsValidTime_sp_m" && IsDigits_sp "$My_IsValidTime_sp_s" ; then
        if [ $My_IsValidTime_sp_h -ge 0 -a $My_IsValidTime_sp_h -lt 24 ] &&
           [ $My_IsValidTime_sp_m -ge 0 -a $My_IsValidTime_sp_m -lt 59 ] &&
           [ $My_IsValidTime_sp_s -ge 0 -a $My_IsValidTime_sp_s -lt 59 ] ; then
            return 0
        fi
    fi
    return 1
}

##################################################
# @ Function: IsValidDateTime_sp
# @ Description: Check if date time is valid
# @ Usage: IsValidDateTime_sp "YYYY-mm-DD HH:MM:SS"
# @ Parameter: "YYYY-mm-DD HH:MM:SS"
# @ Return: stdout
# @ Example:
# @    if IsValidDateTime_sp "2011-11-11 11:11:11" ; 
# @         DoSomething
# @    fi
# @ End of function
##################################################
IsValidDateTime_sp() {
    My_IsValidDateTime_sp_date=`$PRINT "$1" | $CUT -d' ' -f1`
    My_IsValidDateTime_sp_time=`$PRINT "$1" | $CUT -d' ' -f2`
    if IsValidDate_sp "$My_IsValidDateTime_sp_date" && IsValidTime_sp "$My_IsValidDateTime_sp_time" ; then
        return 0
    fi
    return 1
}

##################################################
# perl is required for following functions
##################################################

##################################################
# @ Function: DateTime2Epoch_sp
# @ Description: Convert DateTime to Epoch
# @ Usage: DateTime2Epoch_sp "YYYY-MM-DD HH:MM:SS"
# @ Parameter: "YYYY-MM-DD HH:MM:SS" - The date and time
# @ Return: exit code, stdout, variable (error msg)
# @ Example:
# @    My_epoch=`DateTime2Epoch_sp "2011-03-15 20:50:59"`
# @ End of function
##################################################
DateTime2Epoch_sp() {
    IsValidDateTime_sp "$1" || {
        M_DateTime2Epoch_sp="Invalid date and time"
        return 1
    }
    $PRINT "$1" | $PERL -e '
use Time::Local;
while (<>) {
  my $s = $_;
  my($year, $month, $day, $hour, $minute, $second);

  if($s =~ m{^\s*(\d{1,4})\W*0*(\d{1,2})\W*0*(\d{1,2})\W*0*
                 (\d{0,2})\W*0*(\d{0,2})\W*0*(\d{0,2})}x) {
    $year = $1;  $month = $2;   $day = $3;
    $hour = $4;  $minute = $5;  $second = $6;
    $hour |= 0;  $minute |= 0;  $second |= 0;  # defaults.
    $year = ($year<100 ? ($year<70 ? 2000+$year : 1900+$year) : $year);
    print timelocal($second,$minute,$hour,$day,$month-1,$year), "\n";
    exit (0)
  }
  exit(1)
}
exit(1)
'
}

##################################################
# @ Function: Epoch2DateTime_sp
# @ Description: Convert DateTime to Epoch
# @ Usage: Epoch2DateTime_sp epochNum
# @ Parameter: epochNum
# @ Return: stdout
# @ Example:
# @    My_epoch=`Epoch2DateTime_sp "2011-03-15 20:50:59"`
# @ End of function
##################################################
Epoch2DateTime_sp() {
    $PRINT "$1" | $PERL -e '
while (<>) {
    ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($_);
    $year = 1900+$year;
    $mon = $mon+1;
    printf "%04s-%02s-%02s %02s:%02s:%02s", $year, $mon, $mday, $hour, $min, $sec;
}
'
}

##################################################
# @ Function: ComputeTime_sp
# @ Description: Add or substract time (in seconds) to date-time in format YYYY-MM-dd HH:mm:ss
# @ Usage: ComputeTime_sp "YYYY-MM-dd HH:mm:ss" seconds
# @ Parameter: "YYYY-MM-dd HH:mm:ss" - The date and time
# @ Parameter: seconds - The seconds. Add minus to substract number
# @ Return: stdout, variable (error msg)
# @ Example:
# @   My_now=`GetNow_sp`
# @   My_next_hour=`ComputeTime_sp "$My_now" 3600`
# @ End of function
##################################################
ComputeTime_sp() {
    My_ComputeTime_sp_n=`$PRINT "$2" | $SED -e 's/^+*//g'`
    if My_ComputeTime_sp_epoch=`DateTime2Epoch_sp "$1"` ; then
        if My_ComputeTime_sp_epoch=`$EXPR $My_ComputeTime_sp_epoch + $My_ComputeTime_sp_n 2>/dev/null` ; then
            Epoch2DateTime_sp "$My_ComputeTime_sp_epoch"
            return 0
        else
            M_ComputeTime_sp="Invalid seconds."
        fi
    else
        M_ComputeTime_sp="Invalid date-time."
    fi
}

##################################################
# @ Function: ComputeMinute_sp
# @ Description: Add or substract time (in minutes) to date-time in format YYYY-MM-dd HH:mm:ss
# @ Usage: ComputeMinute_sp "YYYY-MM-dd HH:mm:ss" seconds
# @ Parameter: "YYYY-MM-dd HH:mm:ss" - The date and time
# @ Parameter: minutes - The minutes. Add minus to substract number
# @ Return: stdout, variable (error msg)
# @ Example:
# @   My_now=`GetNow_sp`
# @   My_next_hour=`ComputeMinute_sp "$My_now" 45`
# @ End of function
##################################################
ComputeMinute_sp() {
    My_ComputeMinute_sp_n=`$PRINT "$2" | $SED -e 's/^+*//g'`
    if My_ComputeMinute_sp_epoch=`DateTime2Epoch_sp "$1"` ; then
        if My_ComputeMinute_sp_epoch=`$EXPR $My_ComputeMinute_sp_epoch + $My_ComputeMinute_sp_n \* 60 2>/dev/null` ; then
            Epoch2DateTime_sp "$My_ComputeMinute_sp_epoch"
            return 0
        else
            M_ComputeMinute_sp="Invalid seconds."
        fi
    else
        M_ComputeMinute_sp="Invalid date-time."
    fi
}

##################################################
# @ Function: ComputeHour_sp
# @ Description: Add or substract time (in minutes) to date-time in format YYYY-MM-dd HH:mm:ss
# @ Usage: ComputeHour_sp "YYYY-MM-dd HH:mm:ss" seconds
# @ Parameter: "YYYY-MM-dd HH:mm:ss" - The date and time
# @ Parameter: minutes - The minutes. Add minus to substract number
# @ Return: stdout, variable (error msg)
# @ Example:
# @   My_now=`GetNow_sp`
# @   My_next_hour=`ComputeHour_sp "$My_now" 45`
# @ End of function
##################################################
ComputeHour_sp() {
    My_ComputeHour_sp_n=`$PRINT "$2" | $SED -e 's/^+*//g'`
    if My_ComputeHour_sp_epoch=`DateTime2Epoch_sp "$1"` ; then
        if My_ComputeHour_sp_epoch=`$EXPR $My_ComputeHour_sp_epoch + $My_ComputeHour_sp_n \* 3600 2>/dev/null` ; then
            Epoch2DateTime_sp "$My_ComputeHour_sp_epoch"
            return 0
        else
            M_ComputeHour_sp="Invalid seconds."
        fi
    else
        M_ComputeHour_sp="Invalid date-time."
    fi
}

##################################################
# @ Function: ComputeDay_sp
# @ Description: Add or substract time (in minutes) to date-time in format YYYY-MM-dd HH:mm:ss
# @ Usage: ComputeDay_sp "YYYY-MM-dd HH:mm:ss" seconds
# @ Parameter: "YYYY-MM-dd HH:mm:ss" - The date and time
# @ Parameter: minutes - The minutes. Add minus to substract number
# @ Return: stdout, variable (error msg)
# @ Example:
# @   My_now=`GetNow_sp`
# @   My_next_hour=`ComputeDay_sp "$My_now" 45`
# @ End of function
##################################################
ComputeDay_sp() {
    My_ComputeDay_sp_n=`$PRINT "$2" | $SED -e 's/^+*//g'`
    if My_ComputeDay_sp_epoch=`DateTime2Epoch_sp "$1"` ; then
        if My_ComputeDay_sp_epoch=`$EXPR $My_ComputeDay_sp_epoch + $My_ComputeDay_sp_n \* 86400 2>/dev/null` ; then
            Epoch2DateTime_sp "$My_ComputeDay_sp_epoch"
            return 0
        else
            M_ComputeDay_sp="Invalid seconds."
        fi
    else
        M_ComputeDay_sp="Invalid date-time."
    fi
}

##################################################
# @ Function: ComputeYear_sp
# @ Description: Compute year
# @ Usage: ComputeYear_sp YYYY num-of-year
# @ Parameter: YYYY - The date year
# @ Parameter: num-of-yearr - The number. Add minus to substract years
# @ Return: exit code, stdout, variable (error msg)
# @ Example:
# @    My_newyear=`ComputeYear_sp 2011 -2` # My_newyear='2009'
# @ End of function
##################################################
ComputeYear_sp() {
    if IsNumber_sp "$1" && IsNumber_sp "$2" && [ $1 -gt 0 ] ; then
        $EXPR $1 + $2
        return 0
    fi
    M_ComputeYear_sp="Invalid number"
    return 1
}

##################################################
# @ Function: ComputeMonth_sp
# @ Description: Compute year-mon
# @ Usage: ComputeMonth_sp YYYY-MM num-of-mon
# @ Parameter: YYYY-MM - The year-mon
# @ Parameter: num-of-mon - The number. Add minus to substract years
# @ Return: exit code, stdout, variable (error msg)
# @ Example:
# @    My_newmon=`ComputeMonth_sp 2011-01 -2` # My_newyear='2010-11'
# @ End of function
##################################################
ComputeMonth_sp() {
    if IsValidDate_sp "$1-01" && IsNumber_sp "$2" ; then
        My_ComputeMonth_sp_y=`$PRINT "$1" | $CUT -d'-' -f1`
        My_ComputeMonth_sp_m=`$PRINT "$1" | $CUT -d'-' -f2`
        My_ComputeMonth_sp_y=`$EXPR $My_ComputeMonth_sp_y + $2 / 12`
        My_ComputeMonth_sp_m=`$EXPR $My_ComputeMonth_sp_m + $2 % 12`
        if [ $My_ComputeMonth_sp_m -le 0 ] ; then
            My_ComputeMonth_sp_y=`$EXPR $My_ComputeMonth_sp_y - 1`
            My_ComputeMonth_sp_m=`$EXPR $My_ComputeMonth_sp_m + 12`
        elif [ $My_ComputeMonth_sp_m -gt 12 ] ; then
            My_ComputeMonth_sp_y=`$EXPR $My_ComputeMonth_sp_y + 1`
            My_ComputeMonth_sp_m=`$EXPR $My_ComputeMonth_sp_m - 12`
        fi
        My_ComputeMonth_sp_m=`Private_Pad00_sp "$My_ComputeMonth_sp_m"`
        $PRINT "$My_ComputeMonth_sp_y-$My_ComputeMonth_sp_m"
        return 0
    fi
    M_ComputeMonth_sp="Invalid YYYY-MM"
    return 1
}

# End of script
