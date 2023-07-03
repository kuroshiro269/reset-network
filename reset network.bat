@echo off

REM Check network connection
ping 8.8.8.8 -n 1 >nul
if %errorlevel% equ 0 (
    echo Network connection is active.
) else (
    echo Network connection is not active.
)

REM Reset and renew network
ipconfig /release
ipconfig /renew

REM Flush DNS
ipconfig /flushdns

echo Network reset and DNS flushed.

REM Reset TCP/IP stack 
netsh int ip reset 

REM Reset network configuration to default settings
netsh int ip reset resetlog.txt

pause
