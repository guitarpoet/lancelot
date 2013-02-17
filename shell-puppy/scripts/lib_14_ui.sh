##################################################
# $Id: lib_14_ui.sh 13 2011-03-27 00:19:04Z Allen.Zhao@gmail.com $
##################################################
# @ File: lib_ui.sh
# @ Description: Shell functions for user interface.
# @ Dependency: lib_file.sh
# @ Author: Allen Zhao
# @ Email: allen.zhao@gmail.com
# @ End of file
##################################################

##################################################
# @ Function: YN_sp
# @ Description: Display message and ask user to answer yer or no
# @ Usage: YN_sp [-y|-n] "You message"
# @ Parameter: -y|-n - Default answer is yes or no
# @ Parameter: Your message 
# @ Return: $EXIT code
# @ Example:
# @   YN_sp "Continue?"
# @ End of function
##################################################
YN_sp() {
    case $1 in
        -y)
            My_YN_sp_df=y
            shift ;;
        -n)
            My_YN_sp_df=n
            shift ;;
        *)
            My_YN_sp_df=n ;;
    esac
    $PRINTF -- "$* (Default: $My_YN_sp_df): "
    $READ YN_sp_choice
    YN_sp_choice=`$PRINT "$YN_sp_choice" | $TR '[A-Z]' '[a-z]'`
    if [ "$YN_sp_choice" = "" ]; then
        YN_sp_choice="$My_YN_sp_df"
    fi
    if [ "$YN_sp_choice" = "y" -o "$YN_sp_choice" = "yes" ]; then
        return 0
    fi
    return 1
}

##################################################
# @ Function: InfoWait_sp
# @ Description: Display message and wait user to press enter
# @ Usage: InfoWait_sp "Your message"
# @ Parameter: Your message 
# @ Return: none
# @ Example:
# @   InfoWait_sp "blah blah"
# @ End of function
##################################################
InfoWait_sp() {
    if [ ! -z "$*" ] ; then
        $PRINT "$*"
    fi
    $PRINTF "Press [Enter] to continue ... "
    $READ My_MsgWait_sp_s
}

##################################################
# @ Function: InfoExit_sp
# @ Description: Display message and $EXIT
# @ Usage: InfoExit_sp "Your message"
# @ Parameter: Your message 
# @ Return: none
# @ Example:
# @   InfoExit_sp "blah blah"
# @ End of function
##################################################
InfoExit_sp() {
    $PRINT "$*"
    $EXIT 0
}

##################################################
# @ Function: PrintError_sp
# @ Description: Print error to stderr
# @ Usage: PrintError_sp "Your message"
# @ Parameter: Your message 
# @ Return: none
# @ Example:
# @   PrintError_sp "blah blah"
# @ End of function
##################################################
PrintError_sp() {
    $PRINT "$*" 1>&2
}

##################################################
# @ Function: ErrorExit_sp
# @ Description: Display error to stderr and $EXIT
# @ Usage: ErrorExit_sp "Error Msg" [exit_code]
# @ Parameter: "Error Msg" - Quoted error message
# @ Parameter: exit_code
# @ Return: none
# @ Example:
# @   ErrorExit_sp "You are wrong" 4
# @ End of function
##################################################
ErrorExit_sp() {
    PrintError_sp "$1"
    if IsDigits_sp "$2" ; then
        $EXIT $2
    fi
    $EXIT 1
}

##################################################
# @ Function: ReadValue_sp
# @ Description: Display message and read value
# @ Usage: ReadValue_sp "Your message"
# @ Parameter: "Your message" - Your message without ":".
# @ Return: variable $M_ReadValue_sp
# @ Example:
# @   ReadValue_sp "Please input your name"
# @ End of function
##################################################
ReadValue_sp() {
    $PRINTF -- "$* : "
    $READ M_ReadValue_sp
}

##################################################
# @ Function: ReadPassword_sp
# @ Description: Display message and read password
# @ Usage: ReadPassword_sp "Your message"
# @ Parameter: "Your message" - Your message without ":"
# @ Return: variable $M_ReadPassword_sp
# @ Example:
# @   ReadPassword_sp "Please input your password"
# @ End of function
##################################################
ReadPassword_sp() {
    $PRINTF -- "$* : "
    $STTY -echo
    $TRAP "$STTY echo" 0 1 2 5 15
    $READ M_ReadPassword_sp
    $STTY echo
    $PRINT
    $TRAP 1>/dev/null 2>/dev/null
}

##################################################
# @ Function: ReadPath_sp
# @ Description: Display message and read value
# @ Usage: ReadPath_sp "Your message" [{-f [-a] [-x] [-w] [-s] [-r]} | {-d [-a] [-r] [-w] [-x]}]
# @ Parameter: "Your message" - Your message without ":".
# @ Parameter: [-f [-a] [-x] [-w] [-s] [-r]] - File check options. Please CheckFile_sp in lib_02_file.sh
# @ Parameter: [-d} [-a] [-r] [-w] [-x]] - Directory check options. Please CheckDir_sp in lib_02_file.sh
# @ Return: variable $ReadPath_sp
# @ Example:
# @   ReadPath_sp "Please input your path"
# @ End of function
##################################################
ReadPath_sp() {
    My_ReadPath_sp_msg=$1
    if [ $# -ge 2 ]; then
        My_ReadPath_sp_check=$2
        shift 2
    else
        if [ $# -ge 1 ]; then
            shift
        fi
    fi
    while [ 1 ]; do
        ReadValue_sp "$My_ReadPath_sp_msg"
        if [ -z "$M_ReadValue_sp" ] ; then
            continue
        fi
        case $My_ReadPath_sp_check in
            -f)
                if CheckFile_sp $M_ReadValue_sp $@ ; then
                    break
                fi
                PrintError_sp "$M_CheckFile_sp"
            ;;
            -d)
                if CheckDir_sp $M_ReadValue_sp $@ ; then
                    break
                fi
                PrintError_sp "$M_CheckDir_sp"
            ;;
            *)
                break
            ;;
        esac
    done
    M_ReadPath_sp="$M_ReadValue_sp"
}

##################################################
# @ Function: Menu_sp
# @ Description: Display menu and read menu choice
# @ Usage: Menu_sp -t "menu-title" -d default-choice -i item-tag "item-name" [-i key "item-name" ...]
# @ Parameter: -t "menu-title" - Menu title
# @ Parameter: -d default-choice - The default choice
# @ Parameter: -i key "item-name" - The menu item. The key is the value which user should input
# @            and return to caller. Only alphabeta is allowed for key.
# @ Return: variable $M_Menu_sp
# @ Example:
# @   Menu_sp "Installation Type" a \
# @       -i a "Express Install"
# @       -i -
# @       -i b "Full Install"
# @       -i c "Custom Install"
# @ Note: Key "x" and "X" are reserved for "quit menu" item.
# @       If you don't sepcify any menu key of "x", "X", a default menu item "x. Exit Menu"
# @       will be appended at the end of all menu items.
# @       If you specify any menu key of "x", "X", the "item-name" will replace "Exit Menu"
# @       and it will be listed at the end of all menu items.
# @       If key is "-", this is a menu sperate-line
# @ End of function
##################################################
Menu_sp() {
    ##################################################
    # Function: Private_DispMenuItem
    # Description: Display the menu
    # Usage: Private_DispMenuItem "Return-item-name" default-choice key1 item1 [key2 item2 ...]
    # End of function
    ##################################################
    Private_DispMenuItem() {
        My_Private_DispMenuItem_return="$1"
        My_Private_DispMenuItem_default="$2"
        shift 2
        $CLEAR
        $PRINT
        $PRINT
        $PRINT "    =========================================================="
        $PRINT "    |   $My_Menu_sp_title"
        $PRINT "    =========================================================="
        while [ ! -z "$1" ]; do
            if [ "$1" = "-" ]; then
                $PRINT "    |---------------------------------------------------------"
            else
                $PRINT "    |   ${1}. $2"
            fi
            shift 2
        done
        $PRINT "    =========================================================="
        $PRINT "    |   x. $My_Private_DispMenuItem_return"
        $PRINT "    =========================================================="
        $PRINTF "        Please enter your choice (default: $My_Private_DispMenuItem_default): "
    }

    ##################################################
    # Function: Private_IsValidKey
    # Description: Check if a menu key is valid
    # Usage: Private_IsValidKey userEnterKey key1 [key2 ...]
    # End of function
    ##################################################
    Private_IsValidKey() {
        My_Private_IsValidKey_userKey=$1
        shift
        for My_Private_IsValidKey_key in $@ ; do
            if [ "$My_Private_IsValidKey_key" = "$My_Private_IsValidKey_userKey" ]; then
                return 0
            fi
        done
        return 1
    }

    My_Menu_sp_title="Menu"
    My_Menu_sp_default="x"
    My_Menu_sp_return="Exit Menu"
    My_Menu_sp_keys="x X"
    My_Menu_sp_DispItems=
    while [ ! -z "$1" ]; do
        case $1 in
            -t)
                My_Menu_sp_title="$2"
                shift 2
            ;;
            -d)
                My_Menu_sp_default="$2"
                shift 2
            ;;
            -i)
                case $2 in
                    -)
                        My_Menu_sp_DispItems="$My_Menu_sp_DispItems \"-\" \" \""
                        shift 2
                    ;;
                    x|X)
                        My_Menu_sp_return="$3"
                        shift 3
                    ;;
                    *)
                        My_Menu_sp_keys="$My_Menu_sp_keys $2"
                        My_Menu_sp_DispItems="$My_Menu_sp_DispItems \"$2\" \"$3\""
                        shift 3
                    ;;
                esac
            ;;
            *)
                PrintError_sp "Menu_sp: Invalid option $1"
                return 1
            ;;
        esac
    done
    
    while [ 1 ]; do
        $EVAL "Private_DispMenuItem \"$My_Menu_sp_return\" \"$My_Menu_sp_default\" $My_Menu_sp_DispItems"
        $READ M_Menu_sp
        M_Menu_sp=`$PRINT "$M_Menu_sp" | $TR -d ' '`
        if [ "$M_Menu_sp" = "" ]; then
            M_Menu_sp=$My_Menu_sp_default
            return
        fi
        if Private_IsValidKey "$M_Menu_sp" $My_Menu_sp_keys ; then
           return
        fi
    done
}

# End of script
