##################################################
# $Id$
##################################################
# @ File: config.sh
# @ Description: The main config file
# @ Author: Allen Zhao
# @ Email: allen.zhao@gmail.com
# @ End of file
##################################################

##################################################
# @ Global Variable: APPHOME_SP - The application home
# @ Global Variable: LOADALLLIB_SP - The flag if load all libs by default. 0 - no, 1 - yes
##################################################
# Please CHANGE this to the absolute location in your system
##################################################
APPHOME_SP=/Users/jack/Workbench/projects/tools/lancelot/shell-puppy
LOADALLLIB_SP=y
DAMONTOOL=nohup

##################################################
# Application Directories
##################################################
# @ Global Variable: BIN_SP - SP command directory
# @ Global Variable: CONF_SP - SP main configuration directory
# @ Global Variable: SCRIPTS_SP - SP script library directory
# @ Global Variable: LOGS_SP - SP log directory
# @ Global Variable: TMP_SP - SP tmp directory
# @ Global Variable: VAR_SP - SP var directory
##################################################
BIN_SP=$APPHOME_SP/bin
CONF_SP=$APPHOME_SP/conf
SCRIPTS_SP=$APPHOME_SP/scripts
LOGS_SP=$APPHOME_SP/logs
TMP_SP=$APPHOME_SP/tmp
VAR_SP=$APPHOME_SP/var
RUN_SP=$VAR_SP/run

##################################################
# Register Commom shell library files
##################################################
# @ Global Variable: OS_SPLIB - SP os library
##################################################
COMMANDS_SPLIB=commands.sh

# Import unix commands
. "$SCRIPTS_SP/$COMMANDS_SPLIB"

# End of script
