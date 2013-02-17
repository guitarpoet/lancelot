$PRINT "Test functions ..."
$PRINT "Test function YN_sp, ..."
    if YN_sp -n "Are you sure to conitnue?" ; then
        $PRINT "You choose yes to continue"
    else
        $PRINT "You choose no to stop"
    fi
$PRINT "Test function YN_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function InfoWait_sp, ..."
InfoWait_sp "this is your messg"
$PRINT "Test function InfoWait_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function InfoExit_sp, ..."
$PRINT "InfoExit_sp will display message and quit your script. Test skipped"
$PRINT "Test function InfoExit_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function PrintError_sp, ..."
PrintError_sp "Error msgs are printed to stderr"
$PRINT "Test function PrintError_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function ErrorExit_sp, ..."
$PRINT "ErrorExit_sp will display message to stderr and quit your script. Test skipped"
$PRINT "Test function ErrorExit_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function ReadValue_sp, ..."
ReadValue_sp "Please enter a word"
$PRINT "You entered: $M_ReadValue_sp"
$PRINT "Test function ReadValue_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function ReadPassword_sp, ..."
ReadPassword_sp "Please enter your secret word"
$PRINT "You entered $M_ReadPassword_sp"
$PRINT "Test function ReadPassword_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function ReadPath_sp, ..."
ReadPath_sp "Please enter any path"
$PRINT "You entered: $M_ReadPath_sp"
ReadPath_sp "Please enter a exist file with read and execute perission" -f -r -x
$PRINT "You entered: $M_ReadPath_sp"
ReadPath_sp "Please enter a exist dir with write and execute perission" -d -w -x
$PRINT "You entered: $M_ReadPath_sp"
$PRINT "Test function ReadPath_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test function Menu_sp, ..."
Menu_sp -t "Sofrware Installation" -d 1 \
-i 1 "Dummy Install" \
-i 2 "Full Install" \
-i - \
-i 3 "Expert Install"
$PRINT "You choose $M_Menu_sp"
$PRINT "Test function Menu_sp, done"
$PRINT "================================================="
$PRINT

$PRINT "Test functions, done."
