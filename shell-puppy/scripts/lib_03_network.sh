##################################################
# $Id: lib_03_network.sh 13 2011-03-27 00:19:04Z Allen.Zhao@gmail.com $
##################################################
# @ File: lib_network.sh
# @ Description: Network shell functions
# @ Author: Allen Zhao
# @ Email: allen.zhao@gmail.com
# @ End of file
##################################################

##################################################
# @ Function: IsHostAlive_sp
# @ Description: Check if host is alive
# @ Usage: IsHostAlive_sp host-name
# @ Return: exit code
# @ Example:
# @   if IsHostAlive_sp $myhost ; then
# @       copyFiles
# @   fi
# @ End of function
##################################################
IsHostAlive_sp() {
    if $PING -c 1 $1 2>/dev/null 1>/dev/null; then
        return 0
    else
        return 1
    fi
}

##################################################
# @ Function: GetHostIP_sp
# @ Description: Get IP by host-name
# @ Usage: GetHostIP_sp host-name
# @ Return: std out
# @ Example:
# @   My_IP=`GetHostIP_sp $My_Host`
# @ Only return the first IP for DNS robin domain
# @ End of function
##################################################
GetHostIP_sp() {
    My_GetHostIP_nslkp_sp=`$NSLOOKUP $1 2>/dev/null`
    if $PRINT "$My_GetHostIP_nslkp_sp" | $GREP 'SERVFAIL' 2>/dev/null 1>/dev/null ; then
        return 1
    fi
    $PRINT "$My_GetHostIP_nslkp_sp" | $GREP '^Address:' | $GREP -v '#' | $HEAD -1 | $AWK '{print $2}'
}

##################################################
# @ Function: GetHostFQDN_sp
# @ Description: Get FQDN by host-name
# @ Usage: GetHostFQDN_sp host-name
# @ Return: std out
# @ Example:
# @   My_FQDN=`GetHostFQDN_sp $My_Host`
# @ Only return the first entry for DNS robin domain
# @ End of function
##################################################
GetHostFQDN_sp() {
    My_GetHostFQDN_nslkp_sp=`$NSLOOKUP $1 2>/dev/null`
    if $PRINT "$My_GetHostFQDN_nslkp_sp" | $GREP 'SERVFAIL' ; then
        return 1
    fi
    $PRINT "$My_GetHostFQDN_nslkp_sp" | $GREP '^Name:' | $HEAD -1 | $AWK '{print $2}'
}

##################################################
# @ Function: IsLocalPortOpen_sp
# @ Description: Check if user exists
# @ Usage: IsLocalPortOpen_sp port
# @ Parameter: port
# @ Return: exit code
# @ Example:
# @    if IsLocalPortOpen_sp 443 ; then
# @         DoSomething
# @    fi
# @ Note: This funcion not works well for port with IP
# @ End of function
##################################################
IsLocalPortOpen_sp() {
    My_IsLocalPortOpen_sp_n="$EXPR $1 \* 1 2>/dev/null"
    if [ -z "$My_IsLocalPortOpen_sp_n" ] ; then
        M_IsLocalPortOpen_sp="$1 is not a port number"
    fi
    if $NETSTAT -an | $GREP "LISTEN" | $GREP -w "$1" 1>/dev/null ; then
        return 0
    fi
    return 1
}

# end of script
