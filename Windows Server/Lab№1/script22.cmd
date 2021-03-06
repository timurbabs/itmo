@echo off
:start
set /p parameter="Choose parameter Auto or Manual:"

if "%parameter%" == "Auto" (
	netsh interface ip set address "Ethernet" dhcp
	netsh interface ip set dns "Ethernet" dhcp
)

if "%parameter%" == "Manual" (
	netsh interface ip set address "Ethernet" static 192.168.1.10 255.255.255.0 192.168.1.1 1
	netsh interface ip set dns "Ethernet" static 8.8.8.8 primary
)

set result=true
if not "%parameter%" == "Auto" if not "%parameter%" == "Manual" set result=false
if "%result%"=="true" (
	pause
) else (
	echo Wrong parameter.
	pause
	exit 1
)
