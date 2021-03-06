$name = Read-Host "Enter name"

if ($name.length -ne 4) {
	Write-Output "Wrong count of chars."
	Write-Host -NoNewLine 'Press any key to continue...';
	$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
	exit 1
}

if ($name -match " ") {
	Write-Output "The string must not contains spaces."
	Write-Host -NoNewLine 'Press any key to continue...';
	$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
	exit 1
}

New-LocalUser -Name "UPart3$name" -NoPassword
New-LocalGroup -Name "GPart3$name"
Add-LocalGroupMember -Group "GPart3$name"-Member "UPart3$name"
Enable-LocalUser -Name "UPart3$name"
