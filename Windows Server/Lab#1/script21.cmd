@echo off

set /p STR="Enter STR: "
set userName=UPart2%STR%
set groupName=GPart2%STR%

echo User %userName% creating
net user %userName% /add

echo Group %userName% creating
net localgroup %groupName% /add

echo Adding user %userName% to group %groupName%
net localgroup %groupName% %userName% /add

echo Activate user %userName%
net user %userName% /active:yes

pause