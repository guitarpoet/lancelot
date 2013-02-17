$PRINT "Test functions ..."
$PRINT "Test function IsHostAlive_sp, ..."
for h in www.google.com www.yahoo.com localhost myhost ; do
    if IsHostAlive_sp $h ; then
        $PRINT "$h is alive."
    else
        $PRINT "$h is not alive."
    fi
done
$PRINT "Test function IsHostAlive_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function GetHostIP_sp, ..."
for h in www.google.com www.yahoo.com localhost myhost ; do
    if myip=`GetHostIP_sp $h` ; then
        $PRINT "$h ip = $myip"
    else
        $PRINT "Get ip of $h failed."
    fi
done
$PRINT "Test function GetHostIP_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function GetHostFQDN_sp, ..."
for h in www.google.com www.yahoo.com localhost myhost ; do
    if myfqdn=`GetHostFQDN_sp $h` ; then
        $PRINT "$h fqdn = $myfqdn"
    else
        $PRINT "Get fqdn of $h failed."
    fi
done
$PRINT "Test function GetHostFQDN_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function IsLocalPortOpen_sp, ..."
for p in 5800 80 443 22 1000; do
    if IsLocalPortOpen_sp $p ; then
        $PRINT "Port $p is open"
    else
        $PRINT "Port $p is not open"
    fi
done
$PRINT "Test function IsLocalPortOpen_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test functions, done."
