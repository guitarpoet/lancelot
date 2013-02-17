##################################################
# $Id: commands.sh 13 2011-03-27 00:19:04Z Allen.Zhao@gmail.com $
##################################################
# @ File: lib_commands.sh
# @ Description: Import unix commands
# @ Author: Allen Zhao
# @ Email: allen.zhao@gmail.com
# @ End of file
##################################################

UNAME=/usr/bin/uname
OS_TYPE_SP=`$UNAME -s`

##################################################
# @ Function: ImportCommands_sp
# @ Description: Import proper commands file for specified os type
# @ Usage: ImportCommands_sp
# @ Return: none
# @ Example:
# @   if func-name $myhost ; then
# @       copyFiles
# @   fi
# @ End of function
##################################################
ImportCommands_sp() {
    My_ImportCommands_sp_ostype=default
    if [ ! -z "$1" ]; then
        My_ImportCommands_sp_ostype="$1"
    fi
    if [ -x "$SCRIPTS_SP/commands.${My_ImportCommands_sp_ostype}.sh" ]; then
        . "$SCRIPTS_SP/commands.${My_ImportCommands_sp_ostype}.sh"
    else
        . "$SCRIPTS_SP/commands.default.sh"
    fi
}

# Import unix commands for os type
ImportCommands_sp default
ImportCommands_sp "$OS_TYPE_SP"

# If LOADALLLIB_SP flag = 1, then load all libs under $SCRIPTS_SP
if [ "$LOADALLLIB_SP" = "y" ]; then
    for My_commands_sp_lib in `$LS $SCRIPTS_SP/lib_*.sh`; do
        if [ -x "$My_commands_sp_lib" ]; then
            . "$My_commands_sp_lib"
        fi
    done
fi

# End of script
