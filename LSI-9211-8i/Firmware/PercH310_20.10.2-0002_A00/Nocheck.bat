@Echo OFF
CLS

set FW=20.10.2-0002
set ROM=H310PWS.rom
set SUBDEV=1f78
set DOS32A=/NOC /NOWARN:9004

echo ��������������������������������������������������������������������?
echo ?Dell PERC H310 Adapter Package Version %FW%               ?
echo ?                                                                  ?
echo ?You have selected to downgrade the firmware of your Dell          ?
echo ?PERC H310 Adapter to version %FW%.                        ?
echo ?                                                                  ?
echo ��������������������������������������������������������������������?

@echo.
echo ��������������������������������������������������������������������?
echo ?Press ctrl-C to stop the firmware flash process or any other key  ?
echo ?to continue.                                                      ?
echo ��������������������������������������������������������������������?
@pause >nul
cls

echo ��������������������������������������������������������������������?
echo ?Please wait while supported controller(s) are identified.         ?
echo ��������������������������������������������������������������������?
@megafl.exe -ADPCOUNT >ADPCOUNT.LOG
@XGREP "Controller Count: 0" adpcount.log >NUL
@If errorlevel 1 GOTO ADAPTER0
@GOTO NOADP

:ADAPTER0
@megafl.exe -ADPALLINFO -A0 -NOLOG >ADP0.log
@If errorlevel 1 GOTO ADAPTER1
@XGREP %SUBDEV% ADP0.LOG >NUL
@If errorlevel 1 GOTO ADAPTER1
@XGREP %FW% ADP0.LOG >NUL
@If errorlevel 1 GOTO FLASH0
@GOTO SAME0

:FLASH0
@Echo.attempt0 >>ADPCOUNT.LOG
@Echo.
echo ��������������������������������������������������������������������?
echo ?Controller found! - Please wait while flash is performed.         ?
echo ?Do not power off or reboot system until all flashing              ?
echo ?has completed.                                                    ?
echo ��������������������������������������������������������������������?
@megafl.exe -ADPFWFLASH -F %ROM% -NOVERCHK -A0 >NUL
@if errorlevel 1 GOTO FAIL0
@Echo.
echo ��������������������������������������������������������������������?
echo ?Flash completed successfully!                                     ?
echo ?                                                                  ?
echo ?Please wait while searching for additional controllers.           ?
echo ��������������������������������������������������������������������?
@GOTO ADAPTER1

:SAME0
@Echo.
echo ��������������������������������������������������������������������?
echo ?Controller found, but the firmware version is the same.           ?
echo ?Flash will NOT be performed.                                      ?
echo ?                                                                  ?
echo ?Please wait while searching for additional controllers.           ?
echo ��������������������������������������������������������������������?
@Echo.
@echo.same0 >>ADPCOUNT.LOG
@GOTO ADAPTER1

:FAIL0
@Echo.
echo ��������������������������������������������������������������������?
echo ?An error was encountered during this controller's flash.          ?
echo ?                                                                  ?
echo ?Please wait while searching for additional controllers.           ?
echo ��������������������������������������������������������������������?
@Echo.error0 >>ADPCOUNT.LOG
@Echo.
@GOTO ADAPTER1

:ADAPTER1
@megafl.exe -ADPALLINFO -A1 -NOLOG >ADP1.log
@If errorlevel 1 GOTO ADAPTER2
@XGREP %SUBDEV% ADP1.LOG >NUL
@If errorlevel 1 GOTO ADAPTER2
@XGREP %FW% ADP1.LOG >NUL
@If errorlevel 1 GOTO FLASH1
@GOTO SAME1

:FLASH1
@Echo.attempt1 >>ADPCOUNT.LOG
@Echo.
echo ��������������������������������������������������������������������?
echo ?Controller found! - Please wait while flash is performed.         ?
echo ?Do not power off or reboot system until all flashing              ?
echo ?has completed.                                                    ?
echo ��������������������������������������������������������������������?
@megafl.exe -ADPFWFLASH -F %ROM% -NOVERCHK -A1 >NUL
@if errorlevel 1 GOTO FAIL1
@Echo.
echo ��������������������������������������������������������������������?
echo ?Flash completed successfully!                                     ?
echo ?                                                                  ?
echo ?Please wait while searching for additional controllers.           ?
echo ��������������������������������������������������������������������?
@GOTO ADAPTER2

:SAME1
@Echo.
echo ��������������������������������������������������������������������?
echo ?Controller found, but the firmware version is the same.           ?
echo ?Flash will NOT be performed.                                      ?
echo ?                                                                  ?
echo ?Please wait while searching for additional controllers.           ?
echo ��������������������������������������������������������������������?
@Echo.
@echo.same1 >>ADPCOUNT.LOG
@GOTO ADAPTER2

:FAIL1
@Echo.
echo ��������������������������������������������������������������������?
echo ?An error was encountered during this controller's flash.          ?
echo ?                                                                  ?
echo ?Please wait while searching for additional controllers.           ?
echo ��������������������������������������������������������������������?
@Echo.error1 >>ADPCOUNT.LOG
@Echo.
@GOTO ADAPTER2

:ADAPTER2
@megafl.exe -ADPALLINFO -A2 -NOLOG >ADP2.log
@If errorlevel 1 GOTO CHECK
@XGREP %SUBDEV% ADP2.LOG >NUL
@If errorlevel 1 GOTO CHECK
@XGREP %FW% ADP2.LOG >NUL
@If errorlevel 1 GOTO FLASH2
@GOTO SAME2

:FLASH2
@Echo.attempt2 >>ADPCOUNT.LOG
@Echo.
echo ��������������������������������������������������������������������?
echo ?Controller found! - Please wait while flash is performed.         ?
echo ?Do not power off or reboot system until all flashing              ?
echo ?has completed.                                                    ?
echo ��������������������������������������������������������������������?
@megafl.exe -ADPFWFLASH -F %ROM% -NOVERCHK -A2 >NUL
@if errorlevel 1 GOTO FAIL2
@Echo.
echo ��������������������������������������������������������������������?
echo ?Flash completed successfully!                                     ?
echo ?                                                                  ?
echo ?Please wait while searching for additional controllers.           ?
echo ��������������������������������������������������������������������?
@GOTO CHECK

:SAME2
@Echo.
echo ��������������������������������������������������������������������?
echo ?Controller found, but the firmware version is the same.           ?
echo ?Flash will NOT be performed.                                      ?
echo ?                                                                  ?
echo ?Please wait while searching for additional controllers.           ?
echo ��������������������������������������������������������������������?
@Echo.
@echo.same2 >>ADPCOUNT.LOG
@GOTO CHECK

:FAIL2
@Echo.
echo ��������������������������������������������������������������������?
echo ?An error was encountered during this controller's flash.          ?
echo ?                                                                  ?
echo ?Please wait while searching for additional controllers.           ?
echo ��������������������������������������������������������������������?
@Echo.error2 >>ADPCOUNT.LOG
@Echo.
@GOTO CHECK

:CHECK
@XGREP "error" ADPCOUNT.LOG >NUL
@If errorlevel 1 GOTO CHECK2
@Echo.
echo ��������������������������������������������������������������������?
echo ?One or more controllers encountered a flash failure.              ?
echo ?                                                                  ?
echo ?Please reboot for any changes to take effect.                     ?
echo ��������������������������������������������������������������������?
@Echo.
@GOTO END

:CHECK2
@XGREP "same" ADPCOUNT.LOG >NUL
@if errorlevel 1 GOTO PASS
@Echo.
echo ��������������������������������������������������������������������?
echo ?All flash attempts have completed!                                ?
echo ?One or more controllers were already at this firmware revision.   ?
echo ?                                                                  ?
echo ?Please reboot for any changes to take effect.                     ?
echo ��������������������������������������������������������������������?
@Echo.
@GOTO END

:PASS
@XGREP "attempt" ADPCOUNT.LOG >NUL
@if errorlevel 1 GOTO NOADP
@Echo.
echo ��������������������������������������������������������������������?
echo ?All flashes have completed successfully!                          ?
echo ?                                                                  ?
echo ?Please reboot for changes to take effect.                         ?
echo ��������������������������������������������������������������������?
@Echo.
@GOTO END


:NOADP
@Echo.
echo ��������������������������������������������������������������������?
echo ?No supported controllers present or detected.                     ?
echo ��������������������������������������������������������������������?
@Echo.
@GOTO END

:END
@del *.log