##################################################
# $Id: lib_12_opt.sh 13 2011-03-27 00:19:04Z Allen.Zhao@gmail.com $
##################################################
# @ File: lib_opt.sh
# @ Description: Shell funcion for commmand line options.
# @ Dependency: lib_misc.sh
# @ Author: Allen Zhao
# @ Email: allen.zhao@gmail.com
# @ End of file
##################################################
# Private Variable: OPT_SP_OptionsName_short_long - Options with name OptionsName, short option "short"'s long name
# Private Variable: OPT_SP_OptionsName_short_desc - Options with name OptionsName, short option "short"'s description
# Private Variable: OPT_SP_OptionsName_short_n - Options with name OptionsName, short option "short"'s number of args
# Private Variable: OPT_SP_OptionsName_short_required - Indicate option is required. y: required, n: not required.
# Private Variable: OPT_SP_OptionsName_short_value_x - Options with name OptionsName, short option "short"'s xth value
# Private Variable: OPT_SP_OptionsName_short_has - Indicate options with name OptionsName, short option "short" has value passed in or not.
# Private Variable: OPT_SP_OptionsName_all - A list of short options
##################################################

##################################################
# Function: Private_PrepareOptionsName_sp
# Description: Prepare the OptionsName
# Usage: Private_PrepareOptionsName_sp options_name
# Parameter: The options_name
# Return: stdout, exit code
# End of function
##################################################
Private_PrepareOptionsName_sp() {
    My_Private_PrepareOptionsName_sp_name="`TrimSpace_sp "$1"`"
    $EVAL "My_Private_PrepareOptionsName_sp_all=\"\$OPT_SP_${My_Private_PrepareOptionsName_sp_name}_all\""
    if [ -z "$My_Private_PrepareOptionsName_sp_all" ]; then
        return 1
    fi
    $PRINT "$My_Private_PrepareOptionsName_sp_name"
    return 0
}

##################################################
# Function: Private_PrepareOption_sp
# Description: Prepare the Option
# Usage: Private_PrepareOption_sp options_name short|short
# Parameter: The options_name
# Parameter: The short option
# Return: stdout, exit code
# End of function
##################################################
Private_PrepareOption_sp() {
    My_Private_PrepareOption_sp_name=`Private_PrepareOptionsName_sp "$1"` || M_Private_PrepareOption_sp="Private_PrepareOption_sp: Options name: $My_Private_PrepareOption_sp_name not defined!"
    My_Private_PrepareOption_sp_opt="`TrimSpace_sp "$2" | $TR -d '-'`"
    $EVAL "My_Private_PrepareOption_sp_sp_all=\"\$OPT_SP_${My_Private_PrepareOption_sp_name}_all\""
    for My_Private_PrepareOption_sp_i in $My_Private_PrepareOption_sp_sp_all ; do
        $EVAL "My_Private_PrepareOption_sp_i_long=\"\$OPT_SP_${My_Private_PrepareOption_sp_name}_${My_Private_PrepareOption_sp_i}_long\""
        if [ "$My_Private_PrepareOption_sp_i" = "$My_Private_PrepareOption_sp_opt" -o "$My_Private_PrepareOption_sp_i_long" = "$My_Private_PrepareOption_sp_opt" ]; then
            $PRINT $My_Private_PrepareOption_sp_i
            return 0
        fi
    done
    return 1
}

##################################################
# @ Function: AddOption_sp
# @ Description: Add an option to options
# @ Usage: AddOption_sp options_name short long number-of-args required description
# @ Parameter: options_name - A uniq options name (Alphabeta only)
# @ Parameter: short - short option letter
# @ Parameter: long - long option word
# @ Parameter: number-of-args - number of args follows this option
# @ Parameter: required - indicate it is a required option or not. y: required; n: not-required
# @ Parameter: description - The description of the option
# @ Return: exit code
# @ Example:
# @   AddOption_sp $MyName a all 0 n "List all data"
# @ End of function
##################################################
AddOption_sp() {
    if [ $# -lt 6 ]; then
        return 1
    fi
    My_AddOption_sp_name=`TrimSpace_sp "$1"`
    My_AddOption_sp_short=`TrimSpace_sp "$2"`
    My_AddOption_sp_long=`TrimSpace_sp "$3"`
    if [ -z "$My_AddOption_sp_name" -o -z "$My_AddOption_sp_short" -o -z "$My_AddOption_sp_long" ]; then
        return 1
    fi
    My_AddOption_sp_n=`TrimSpace_sp "$4"`
    IsDigits_sp "$My_AddOption_sp_n" || My_AddOption_sp_n=0
    My_AddOption_sp_required=`TrimSpace_sp "$5"`
    if [ "$My_AddOption_sp_required" = "y" -o "$My_AddOption_sp_required" = "n" ] ; then
        My_AddOption_sp_DoNothing=
    else
        My_AddOption_sp_required=n
    fi
    
    shift 5
    My_AddOption_sp_desc="$*"
    $EVAL "My_AddOption_sp_all=\"\$OPT_SP_${My_AddOption_sp_name}_all\""
    My_AddOption_sp_all="$My_AddOption_sp_all $My_AddOption_sp_short"
    $EVAL "OPT_SP_${My_AddOption_sp_name}_all=\"$My_AddOption_sp_all\""
    $EVAL "OPT_SP_${My_AddOption_sp_name}_${My_AddOption_sp_short}_long=\"$My_AddOption_sp_long\""
    $EVAL "OPT_SP_${My_AddOption_sp_name}_${My_AddOption_sp_short}_desc=\"$My_AddOption_sp_desc\""
    $EVAL "OPT_SP_${My_AddOption_sp_name}_${My_AddOption_sp_short}_n=\"$My_AddOption_sp_n\""
    $EVAL "OPT_SP_${My_AddOption_sp_name}_${My_AddOption_sp_short}_required=\"$My_AddOption_sp_required\""

    return 0
}

##################################################
# @ Function: ParseOptions_sp
# @ Description: Parse the command line options
# @ Usage: ParseOptions_sp optinons_name args
# @ Parameter: options_name - A uniq options name (Alphabeta only)
# @ Parameter: args - The args user passes in
# @ Return: exit code, variable
# @ Example:
# @   ParseOptions_sp "$PROGNAME_SP" arg1 ...
# @ End of function
##################################################
ParseOptions_sp() {
    My_ParseOptions_sp_name=`Private_PrepareOptionsName_sp "$1"` || {
        M_ParseOptions_sp="ParseOptions_sp: Options name: $1 not defined!"
        return 1
    }
    shift
    while [ $# -ne 0 ]; do
        if My_ParseOptions_sp_short=`Private_PrepareOption_sp "$My_ParseOptions_sp_name" "$1"` ; then
            shift
            $EVAL "My_ParseOptions_sp_n=\"\$OPT_SP_${My_ParseOptions_sp_name}_${My_ParseOptions_sp_short}_n\""
            for My_ParseOptions_sp_i in `$SEQ 1 $My_ParseOptions_sp_n`; do
                $EVAL "OPT_SP_${My_ParseOptions_sp_name}_${My_ParseOptions_sp_short}_value_${My_ParseOptions_sp_i}=\"$1\""
                shift
            done
            $EVAL "OPT_SP_${My_ParseOptions_sp_name}_${My_ParseOptions_sp_short}_has=y"
        else
            M_ParseOptions_sp="Unknown option $1."
            return 1
        fi
    done
    $EVAL "My_ParseOptions_sp_all=\"\$OPT_SP_${My_ParseOptions_sp_name}_all\""
    for My_ParseOptions_sp_j in $My_ParseOptions_sp_all ; do
        $EVAL "My_ParseOptions_sp_req=\"\$OPT_SP_${My_ParseOptions_sp_name}_${My_ParseOptions_sp_j}_required\""
        $EVAL "My_ParseOptions_sp_has=\"\$OPT_SP_${My_ParseOptions_sp_name}_${My_ParseOptions_sp_j}_has\""
        if [ "$My_ParseOptions_sp_req" = y ]; then
            if [ ! "$My_ParseOptions_sp_has" = "y" ] ; then
                M_ParseOptions_sp="$My_ParseOptions_sp_j is required."
                return 1
            fi
        fi
    done
}

##################################################
# @ Function: HasOption_sp
# @ Description: Check if user has entered option x
# @ Usage: HasOption_sp option_name short|long
# @ Parameter: options_name - A uniq options name (Alphabeta only)
# @ Parameter: short|long - The option wiht long or short name
# @ Return: exit_code
# @ Example:
# @   HasOption_sp "$PROGNAME_SP" a
# @ End of function
##################################################
HasOption_sp() {
    My_HasOption_sp_name=`Private_PrepareOptionsName_sp "$1"` || {
        M_HasOption_sp="HasOption_sp: Options name: $1 not defined!"
        return 1
    }
    My_HasOption_sp_short=`Private_PrepareOption_sp "$My_HasOption_sp_name" "$2"` || {
        M_HasOption_sp="HasOption_sp: Option name: $2 not defined!"
        return 1
    }
    $EVAL "My_HasOption_sp_has=\"\$OPT_SP_${My_HasOption_sp_name}_${My_HasOption_sp_short}_has\""
    if [ "$My_HasOption_sp_has" = "y" ]; then
        return 0
    fi
    return 1
}


##################################################
# @ Function: GetOptionValue_sp
# @ Description: Retrive the option value
# @ Usage: GetOptionValue_sp option_name short|long [n]
# @ Parameter: options_name - A uniq options name (Alphabeta only)
# @ Parameter: short|long - The option short or long name
# @ Parameter: n - The nth value
# @ Return: exit_code, stdout
# @ Example:
# @   GetOptionValue_sp "$PROGNAME_SP" a
# @ End of function
##################################################
GetOptionValue_sp() {
    My_GetOptionValue_sp_name=`Private_PrepareOptionsName_sp "$1"` || {
        M_GetOptionValue_sp="GetOptionValue_sp: Options name: $1 not defined!"
        return 1
    }
    My_GetOptionValue_sp_short=`Private_PrepareOption_sp "$My_GetOptionValue_sp_name" "$2"` || {
        M_GetOptionValue_sp="GetOptionValue_sp: Option name: $2 not defined!"
        return 1
    }
    
    My_GetOptionValue_sp_n=`TrimSpace_sp "$3"`
    IsDigits_sp "$`TrimSpace_sp "$My_GetOptionValue_sp_n"`" || My_GetOptionValue_sp_n=1
    $EVAL "My_GetOptionValue_sp_short_n=\"\$OPT_SP_${My_GetOptionValue_sp_name}_${My_GetOptionValue_sp_short}_n\""
    if [ $My_GetOptionValue_sp_n -lt 1 -o $My_GetOptionValue_sp_n -gt $My_GetOptionValue_sp_short_n ]; then
        M_GetOptionValue_sp="GetOptionValue_sp: out of value range."
        return 1
    fi
    $EVAL "My_GetOptionValue_sp_val=\"\$OPT_SP_${My_GetOptionValue_sp_name}_${My_GetOptionValue_sp_short}_value_${My_GetOptionValue_sp_n}\""
    $PRINT "$My_GetOptionValue_sp_val"
    return 0
}

##################################################
# @ Function: DispOptionsUsage_sp
# @ Description: Print defined options usage
# @ Usage: DispOptionsUsage_sp option_name [-t title] [-e errormsg] [-d Description ...]
# @ Parameter: options_name - A uniq options name (Alphabeta only)
# @ Parameter: -t title - Specify the usage title.
# @ Parameter: -e errormsg - Display extra error message.
# @ Parameter: -d Description - Display extra description. You can have muliple options to split the lines
# @ Return: exit code, stdout
# @ Example:
# @   DispOptionsUsage_sp
# @ End of function
##################################################
DispOptionsUsage_sp() {
    My_DispOptionsUsage_sp_name=`Private_PrepareOptionsName_sp "$1"` || {
        M_DispOptionsUsage_sp="DispOptionsUsage_sp: Options name: $1 not defined!"
        return 1
    }
    shift
    My_DispOptionsUsage_sp_title="$My_DispOptionsUsage_sp_name"
    My_DispOptionsUsage_sp_errmsg=
    My_DispOptionsUsage_sp_desc=
    while [ $# -ne 0 ]; do
        case $1 in
            -t)
                My_DispOptionsUsage_sp_title="$2"
            ;;
            -e)
                My_DispOptionsUsage_sp_errmsg="$2"
            ;;
            -d)
                if [ -z "$My_DispOptionsUsage_sp_desc" ]; then
                    My_DispOptionsUsage_sp_desc="    $2"
                else
                    My_DispOptionsUsage_sp_desc="$My_DispOptionsUsage_sp_desc
    $2"
                fi
            ;;
        esac
        shift 2
    done
    $EVAL "My_DispOptionsUsage_sp_all=\"\$OPT_SP_${My_DispOptionsUsage_sp_name}_all\""
    $PRINT "$My_DispOptionsUsage_sp_title"
    $PRINT "=================================================================="
    if [ !  -z "$My_DispOptionsUsage_sp_desc" ]; then
        $PRINT "Description: "
        $PRINT "$My_DispOptionsUsage_sp_desc"
    fi
    $PRINT "Options: "
    for My_DispOptionsUsage_sp_i in $My_DispOptionsUsage_sp_all ; do
        $EVAL "My_DispOptionsUsage_sp_i_long=\"\$OPT_SP_${My_DispOptionsUsage_sp_name}_${My_DispOptionsUsage_sp_i}_long\""
        $EVAL "My_DispOptionsUsage_sp_i_desc=\"\$OPT_SP_${My_DispOptionsUsage_sp_name}_${My_DispOptionsUsage_sp_i}_desc\""
        $EVAL "My_DispOptionsUsage_sp_i_required=\"\$OPT_SP_${My_DispOptionsUsage_sp_name}_${My_DispOptionsUsage_sp_i}_required\""
        $EVAL "My_DispOptionsUsage_sp_i_n=\"\$OPT_SP_${My_DispOptionsUsage_sp_name}_${My_DispOptionsUsage_sp_i}_n\""
        $PRINT "    -${My_DispOptionsUsage_sp_i}|--${My_DispOptionsUsage_sp_i_long}:"
        $PRINT "        $My_DispOptionsUsage_sp_i_desc"
        if [ $My_DispOptionsUsage_sp_i_n -gt 0 ]; then
            $PRINT "        This option requires $My_DispOptionsUsage_sp_i_n args."
        fi
        if [ "$My_DispOptionsUsage_sp_i_required" = "y" ]; then
            $PRINT "        Option is required."
        fi
    done
    $PRINT
    if [ ! -z "$My_DispOptionsUsage_sp_errmsg" ]; then
        $PRINT "    Error: $My_DispOptionsUsage_sp_errmsg"
    fi
}

# End of script
