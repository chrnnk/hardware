@Echo OFF
CLS

set FW=20.12.1-0002
set ROM=FW2657A.rom
set SUBDEV=1f4e
set DOS32A=/NOC /NOWARN:9004

echo ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ Dell PERC H310 Adapter Package Version %FW%               บ
echo บ                                                                   บ
echo บ You have selected to downgrade the firmware of your Dell          บ
echo บ PERC H310 Adapter to version %FW%.                        บ
echo บ                                                                   บ
echo ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

@echo.
echo ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ Press ctrl-C to stop the firmware flash process or any other key  บ
echo บ to continue.                                                      บ
echo ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
@pause >nul
cls

echo ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ Please wait while supported controller(s) are identified.         บ
echo ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
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
echo ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ Controller found! - Please wait while flash is performed.         บ
echo บ Do not power off or reboot system until all flashing              บ
echo บ has completed.                                                    บ
echo ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
@megafl.exe -ADPFWFLASH -F %ROM% -NOVERCHK -A0 >NUL
@if errorlevel 1 GOTO FAIL0
@Echo.
echo ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ Flash completed successfully!                                     บ
echo บ                                                                   บ
echo บ Please wait while searching for additional controllers.           บ
echo ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
@GOTO ADAPTER1

:SAME0
@Echo.
echo ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ Controller found, but the firmware version is the same.           บ
echo บ Flash will NOT be performed.                                      บ
echo บ                                                                   บ
echo บ Please wait while searching for additional controllers.           บ
echo ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
@Echo.
@echo.same0 >>ADPCOUNT.LOG
@GOTO ADAPTER1

:FAIL0
@Echo.
echo ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ An error was encountered during this controller's flash.          บ
echo บ                                                                   บ
echo บ Please wait while searching for additional controllers.           บ
echo ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
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
echo ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ Controller found! - Please wait while flash is performed.         บ
echo บ Do not power off or reboot system until all flashing              บ
echo บ has completed.                                                    บ
echo ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
@megafl.exe -ADPFWFLASH -F %ROM% -NOVERCHK -A1 >NUL
@if errorlevel 1 GOTO FAIL1
@Echo.
echo ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ Flash completed successfully!                                     บ
echo บ                                                                   บ
echo บ Please wait while searching for additional controllers.           บ
echo ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
@GOTO ADAPTER2

:SAME1
@Echo.
echo ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ Controller found, but the firmware version is the same.           บ
echo บ Flash will NOT be performed.                                      บ
echo บ                                                                   บ
echo บ Please wait while searching for additional controllers.           บ
echo ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
@Echo.
@echo.same1 >>ADPCOUNT.LOG
@GOTO ADAPTER2

:FAIL1
@Echo.
echo ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ An error was encountered during this controller's flash.          บ
echo บ                                                                   บ
echo บ Please wait while searching for additional controllers.           บ
echo ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
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
echo ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ Controller found! - Please wait while flash is performed.         บ
echo บ Do not power off or reboot system until all flashing              บ
echo บ has completed.                                                    บ
echo ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
@megafl.exe -ADPFWFLASH -F %ROM% -NOVERCHK -A2 >NUL
@if errorlevel 1 GOTO FAIL2
@Echo.
echo ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ Flash completed successfully!                                     บ
echo บ                                                                   บ
echo บ Please wait while searching for additional controllers.           บ
echo ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
@GOTO CHECK

:SAME2
@Echo.
echo ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ Controller found, but the firmware version is the same.           บ
echo บ Flash will NOT be performed.                                      บ
echo บ                                                                   บ
echo บ Please wait while searching for additional controllers.           บ
echo ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
@Echo.
@echo.same2 >>ADPCOUNT.LOG
@GOTO CHECK

:FAIL2
@Echo.
echo ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ An error was encountered during this controller's flash.          บ
echo บ                                                                   บ
echo บ Please wait while searching for additional controllers.           บ
echo ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
@Echo.error2 >>ADPCOUNT.LOG
@Echo.
@GOTO CHECK

:CHECK
@XGREP "error" ADPCOUNT.LOG >NUL
@If errorlevel 1 GOTO CHECK2
@Echo.
echo ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ One or more controllers encountered a flash failure.              บ
echo บ                                                                   บ
echo บ Please reboot for any changes to take effect.                     บ
echo ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
@Echo.
@GOTO END

:CHECK2
@XGREP "same" ADPCOUNT.LOG >NUL
@if errorlevel 1 GOTO PASS
@Echo.
echo ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ All flash attempts have completed!                                บ
echo บ One or more controllers were already at this firmware revision.   บ
echo บ                                                                   บ
echo บ Please reboot for any changes to take effect.                     บ
echo ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
@Echo.
@GOTO END

:PASS
@XGREP "attempt" ADPCOUNT.LOG >NUL
@if errorlevel 1 GOTO NOADP
@Echo.
echo ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ All flashes have completed successfully!                          บ
echo บ                                                                   บ
echo บ Please reboot for changes to take effect.                         บ
echo ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
@Echo.
@GOTO END


:NOADP
@Echo.
echo ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ No supported controllers present or detected.                     บ
echo ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
@Echo.
@GOTO END

:END
@del *.log