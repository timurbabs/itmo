param($path)

if ($NULL -eq $path)
	Write-Error "No path for csv file provided"
	exit 1
}


if ((Test-Path $path) -eq $false) {
	Write-Error "Wrong file path provided"
	exit 1
}


"" > log.txt

Import-Csv $path | ForEach-object {
	$groups = @()
	$trash
	$groups = $_.groups
	$OU = $_.OU
	$name = $_.name
	$login = $_.login

	foreach ($group in $groups) {
		try {
			Get-AdGroupMember -Identity $group > $trash
		}
		catch {
			New-ADgroup $g -GroupScope Global
			"New group added: $g<br>" >> log.txt
		}
	}

	if ([adsi]::Exists("LDAP://OU=$OU, DC=AFN, DC=local") -eq $false) {
		New-AdOrganizationalUnit "$OU"
		"New OU added: $OU<br>" >> log.txt
	}

	try {
		New-Aduser -Name $_.name -Surname $_.surname -Initials $_.FIO -SamAccountName $_.login -Title $_.position -EmailAddress $_.mail -AccountPassword (ConvertTo-SecureString $_.pass -AsPlainText -force) -Enable $true
		Get-ADUser $login | $Move-AdObject -TargetPath "OU=$OU, DC=AFN, DC=local"
		Get-AdGroupMember -Identity $_.groups -Member $_.login
		"New user added: $name<br>" >> log.txt
	}
	catch {
		Write-Error "User $name already exists"
	}
}

$htmlParams = @{Title = "Log file for script" Body = get-Content log.txt}
convertto-html @htmlParams | Out-file report.html
Remove-Item log.txt
Invoke-Item output.html
