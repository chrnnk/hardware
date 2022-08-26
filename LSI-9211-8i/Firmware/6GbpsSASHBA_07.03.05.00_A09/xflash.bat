@echo off

SET SSID=%1
SET FwName=%2
SET PkgVer=%3

SET NumFlashed=0
SET linenum=13

CLS
ECHO ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
ECHO บ                                                                   บ
ECHO บ Dell 6Gbps SAS Controllers                                        บ
ECHO บ                                                                   บ
ECHO บ This executable will update the firmware package of your Dell     บ
ECHO บ 6Gbps SAS controller to version %PkgVer%                       บ
ECHO บ                                                                   บ
ECHO ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
ECHO.
ECHO To abort the flash process now press CTL-C.  Otherwise,
PAUSE
ECHO.
ECHO NOTE: THE ENTIRE FLASH PROCESS MAY TAKE SEVERAL MINUTES
ECHO       TO COMPLETE. PLEASE BE PATIENT.
ECHO.
ECHO Searching for compatible 6Gbps SAS controllers on the system...
ECHO.

rem ****************************************************
rem   List out all the adapters in the system.
rem ****************************************************
sas2flsh -listall > list.out

rem ****************************************************
rem   Read and parse a line of text in the out file to
rem   determine if an adapter exists and what its id 
rem   number is.
rem ****************************************************
setinfo -VAR=line read list.out %linenum%
setinfo -VAR=num substring line 2 1

rem ****************************************************
rem   If no adapters are in the system jump to EXIT
rem ****************************************************

IF (%num%)==() GOTO EXIT

:LOOP

rem ****************************************************
rem   Read and parse a line of text in the out file to
rem   determine the Silicon rev on the adapter. 
rem   number is.
rem ****************************************************

setinfo -VAR=num1 substring line 15 1

IF (%num1%)==(0) GOTO SKIPFLASH

rem ****************************************************
rem   Check the SSID to determine if we need to flash
rem   this card.
rem ****************************************************
sas2flsh -c %num% -o -testssid 1028:%SSID% > SSID.out
find /I "success" SSID.out >NUL
if ERRORLEVEL 1 goto SKIPFLASH

rem ****************************************************
rem   Flash the fw for this adapter
rem ****************************************************
ECHO Flashing the firmware to controller %num%
ECHO This may take a few minutes...
sas2flsh -c %num% -f %FwName% > flash.out
find /I "error" flash.out >NUL
If NOT ERRORLEVEL 1 goto FWERROR
ECHO ...Firmware successfully flashed.
ECHO.
 
rem ****************************************************
rem   Flash the BIOS for this adapter
rem ****************************************************
ECHO Flashing the bios to controller %num%
ECHO This may take a few minutes...
sas2flsh -c %num% -b mptsas2.rom >> flash.out
find /I "error" flash.out >NUL
If NOT ERRORLEVEL 1 goto BIOSERROR
ECHO ...BIOS successfully flashed.
ECHO.

rem ******************************************************
rem   Flash the UEFI Boot Services Driver for this adapter
rem ******************************************************
ECHO Flashing the UEFI BSD to controller %num%
ECHO This may take a few minutes...
sas2flsh -c %num% -b x64sas2.rom >> flash.out
find /I "error" flash.out >NUL
If NOT ERRORLEVEL 1 goto BIOSERROR
ECHO ...UEFI Boot Services Driver successfully flashed.
ECHO.

rem ****************************************************
rem  Reset controller due to existing SASFlash 
rem  bug.  SASFlash BIOS flash should do this.
rem ****************************************************
ECHO Resetting controller %num%...
sas2flsh -c %num% -o -reset > reset.out
ECHO ...Reset complete.
ECHO.

rem ****************************************************
rem   Call modify.bat for CPG systems.
rem   (This is currently used for the cache settings
rem   modifications for Precision systems.)
rem ****************************************************
if NOT EXIST modify.bat GOTO SKIPMODIFY

:MODIFY
ECHO Modifying firmware settings on controller %num%
ECHO This may take a few minutes...
CALL modify.bat %num%
IF ERRORLEVEL 1 GOTO CFGGENERROR
ECHO ...Firmware settings successfully modified.
ECHO.

:SKIPMODIFY

rem ****************************************************
rem   Increment the counter to indicate how many
rem   controllers were flashed.
rem ****************************************************
setinfo -VAR=NumFlashed increment NumFlashed

:SKIPFLASH

rem ****************************************************
rem   Loop to the next line of list.out, if there is 
rem   another entry
rem ****************************************************
setinfo -VAR=linenum increment linenum
setinfo -VAR=line read list.out %linenum%
setinfo -VAR=num substring line 2 1

IF NOT (%num%)==() GOTO LOOP
GOTO EXIT

:FWERROR
ECHO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
ECHO    An error occurred while trying to flash the firmware to 
ECHO    controller number %num%.  Please check your hardware 
ECHO    and try again. If the error occurs again, contact Dell 
ECHO    Technical Support.
ECHO.
ECHO.
ECHO    See flash.out for details.
ECHO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
goto EXIT

:BIOSERROR
ECHO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
ECHO    An error occurred while trying to flash the BIOS to 
ECHO    controller number %num%.  Please check your hardware 
ECHO    and try again. If the error occurs again, contact Dell 
ECHO    Technical Support.
ECHO.
ECHO    See flash.out for details.
ECHO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
goto EXIT

:CFGGENERROR
ECHO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
ECHO    An error occurred while attempting to modify firmware
ECHO    settings for controller number %num%.  Please check
ECHO    your hardware and try again.  If the error occurs again,
ECHO    contact Dell Technical Support.
ECHO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

:EXIT
IF %NumFlashed%==0 GOTO NONEFLASHED
ECHO ****************************************************************
ECHO   %NumFlashed%  6Gbps SAS controller(s) successfully flashed
ECHO ****************************************************************
ECHO.
GOTO END

:NONEFLASHED
ECHO.
ECHO **********************************************************
ECHO No compatible 6Gbps SAS controllers were identified or 
ECHO flashed. Please check your hardware. 
ECHO **********************************************************
GOTO END

:END
