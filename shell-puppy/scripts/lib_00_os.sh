##################################################
# $Id: lib_00_os.sh 21 2011-04-12 21:01:43Z Allen.Zhao@gmail.com $
##################################################
# @ File: lib_os.sh
# @ Description: OS shell functions and global variables
# @ Author:      Allen Zhao
# @ Email:       allen.zhao@gmail.com
# @ End of file
##################################################

##################################################
# @ Required Global Variable: OS_TYPE_SP - OS Type. uanme -s. Setup in comands.sh
# @ Global Variable: OS_RELEASE_SP - OS Release. uname -r
# @ Global Variable: HARDWARE_PLATFORM_SP - Hardware platform. uname -i
# @ Global Variable: MACHINE_NAME_SP - Machine Name. uname -m
# @ Global Variable: RUN_LEVEL_SP - System Run-level.
# @ Global Variable: HOSTNAME_SP - Host Name.
##################################################
OS_RELEASE_SP=`$UNAME -r`
RUN_LEVEL_SP=`$WHO -r | $SED -e 's/.*run-level \([0-9].\).*/\1/g'`
HOSTNAME_SP=`$HOSTNAME`

case $OS_TYPE_SP in
    AIX)
        MACHINE_NAME_SP=`$UNAME -M`
        HARDWARE_PLATFORM_SP=`$UNAME -p`
    ;;
	Darwin)
        MACHINE_NAME_SP=`$UNAME -m`
        HARDWARE_PLATFORM_SP=`$UNAME -p`
	;;
    *)
        MACHINE_NAME_SP=`$UNAME -m`
        HARDWARE_PLATFORM_SP=`$UNAME -i`
    ;;
esac
# End of script
