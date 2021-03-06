$parameter = Read-Host "Enter parameter Auto or Manual"

if ($parameter -eq "Auto") {
	Remove-NetIPAddress -InterfaceAlias Ethernet -Confirm:$false
	Remove-NetRoute -InterfaceAlias Ethernet -Confirm:$false
	Set-NetIPInterface -InterfaceAlias Ethernet -Dhcp Enabled
	Set-DnsClientServerAddress -InterfaceAlias Ethernet -ResetServerAddresses
	Restart-NetAdapter -InterfaceAlias Ethernet
}

if ($parameter -eq "Manual") {
	Remove-NetIPAddress -InterfaceAlias Ethernet -Confirm:$false
	Remove-NetRoute -InterfaceAlias Ethernet -Confirm:$false
	New-NetIPAddress -InterfaceAlias Ethernet -IPAddress 192.168.1.10 -PrefixLength 24 -DefaultGateway 192.168.1.1
	Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses 8.8.8.8
}

if ($parameter -ne "Manual" -and $parameter -ne "Auto") {
	Write-Output "Wrong parameter."
	Write-Host -NoNewLine 'Press any key to continue...';
	$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
	exit 1
}
