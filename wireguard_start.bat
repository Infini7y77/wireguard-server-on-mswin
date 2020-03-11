:: Command Script
:: by: harland.coles@energy-x.com
:: dt: 2020-03-05
:: licence: https://opensource.org/licenses/MIT with Copyright 2020 H.R.Coles

@ECHO OFF
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
SET thisName=%~n0
SET thisParent=%~dp0
:: ECHO #*# %thisName%: %DATE% %TIME% Running...
::
SET _flag_exit=1
SET _flag_exit_pause=0
IF "[%1]"=="[--no-exit]" SET _flag_exit=0

SET _flag_verbose=1
IF "[%1]"=="[--quiet]" SET _flag_verbose=0

SET _flag_debug=0
IF "[%1]"=="[--debug]" SET _flag_debug=1
IF %_flag_debug% EQU 1 SET _flag_verbose=1
IF %_flag_debug% EQU 1 SET _flag_exit_pause=1
call :debug "-x-x- DEBUG IS ON -x-x-"

SET _service_base_dir=C:

:: #-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-
:: Config for service
SET _service_name=wireguard
SET _service_dir=%_service_base_dir%\%_service_name%
SET _logfile=%_service_dir%\%_service_name%_service_%DATE%.log
call :logger "--MARKER-- Calling script: %thisName% (%*)"

SET _wg_ifname=wg0_server
SET _wg_ipv4addr=192.168.222.1

:: #-----
SET _powershell_="%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe"
SET _wireguard_="C:\Program Files\WireGuard\wireguard.exe"

SET _wg_service_dir=%_service_dir%
SET _wg_conf_fn=%_wg_ifname%.conf
SET _wg_conf_fp=%_wg_service_dir%\%_wg_conf_fn%

call :logger "Update Shared Access IP address"
SET _ps_script=%_wg_service_dir%\update_sharedaccess_ipaddress.ps1
%_powershell_% -NoProfile -ExecutionPolicy Bypass -Command "& '%_ps_script%'" -ipv4addr "%_wg_ipv4addr%" >> "%_logfile%"

call :sleepN 2

:: # Start the Wireguard Service
call :logger "Starting Wireguard Service / Interface:  %_wg_ifname%"
%_wireguard_% /installtunnelservice "%_wg_conf_fp%" >> "%_logfile%"

call :sleepN 2
%_wireguard_% /dumplog "%_service_dir%\%_service_name%_dumplog.log"

call :logger "Setup Wireguard Adapter"
SET _ps_script=%_wg_service_dir%\setup_wireguard_adapter.ps1
%_powershell_% -NoProfile -ExecutionPolicy Bypass -Command "& '%_ps_script%'" -ifname "%_wg_ifname%" -enable 1 -basedir "%_wg_service_dir%" >> "%_logfile%"


:: #-----------------------------------------------------
:: # SUBROUTINES
:: #---------------
:: Skip over subroutines
goto :END

:: SUBROUTINE - Sleep N Seconds
:sleepN
	PING.EXE -N %~1 127.0.0.1 > NUL
	goto :eof

:: # SUBROUTINE - #argv: 
:logger
	echo #%DATE%-%TIME%] %~1 >> "%_logfile%"
	goto :eof

:: # SUBROUTINE - #argv: 
:pprint
	IF %_flag_verbose% EQU 1 echo %~1
	goto :eof

:: # SUBROUTINE - #argv: 
:debug
	IF %_flag_debug% EQU 1 echo #DEBUG:] %~1
	goto :eof

:: END SUBROUTINES
:: #------------------------------------------------------

:END
echo #*# %thisName% --- Done ---
IF %_flag_exit% EQU 0 GOTO :NO_EXIT
:EXIT
IF %_flag_exit_pause% EQU 1 PAUSE
ENDLOCAL
ECHO ON
@EXIT /B 0
:NO_EXIT
ENDLOCAL
