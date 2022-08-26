@echo off

call lsiMRupdate.exe ctlr-info.txt

SET iRC=%ERRORLEVEL%

IF %iRC% == 0 GOTO :MESSAGE

exit %iRC%

:MESSAGE

ECHO You must reboot your system to complete the firmware update process.
ECHO You do not need to reboot your system immediately.

exit %iRC%
