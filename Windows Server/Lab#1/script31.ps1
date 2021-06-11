$str = Read-Host "Enter STR"
if ($str.Length -gt 4)
{
    echo "InvalidArgumentException: number of chars exceeded"
    exit 1
}

if ($str.IndexOf(" ") -gt 0)
{
    echo "InvalidArgumentException: contains an invalid char"
    exit 2
}

$userName = "UPart3$STR"
$groupName = "GPart3$STR"

$isUserExsist = Get-LocalUser | Where-Object Name -EQ $userName | Measure
if ($isUserExsist.Count -gt 0)
{
    echo "Invalid"
    exit 3
}

echo "User ${userName} creating"
New-LocalUser $userName -NoPassword

echo "Group ${groupName} creating"
New-LocalGroup $groupName

echo "Adding user ${userName} to group ${groupName}"
Add-LocalGroupMember -Group $groupName -Member $userName

echo "Activate user ${userName}"
Enable-LocalUser -Name $userName

pause