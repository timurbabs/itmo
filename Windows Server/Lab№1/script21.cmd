@echo off
setlocal

:start
set /p name="Enter name:"
call :strLen name strlen

if not %strlen%==4 (
	echo Wrong count of chars.
	pause
	exit 1
)

if not "%name%"=="%name: =%" (
	echo The string must not contains spaces.
	pause
	exit 1
)

net user UPart2%name% /add
net localgroup GPart2%name% /add
net localgroup GPart2%name% UPart2%name% /add
net user UPart2%name% /active

pause



goto :start

:strLen
setlocal enabledelayedexpansion

:strLen_Loop
if not "!%1:~%len%!"=="" set /A len+=1 & goto :strLen_Loop
(endlocal & set %2=%len%)
goto :eof
