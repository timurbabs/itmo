Install-WindowsFeature -Name 'DHCP' -IncludeManagementTools

Import-Csv -Path .\Scope.csv | Add-DhcpServerv4Scope
Import-Csv -Path .\ExclusionRange.csv | Add-DhcpServerv4ExclusionRange
Import-Csv -Path .\OptionValue.csv | Set-DhcpServerv4OptionValue
Import-Csv -Path .\Failover.csv | Add-DhcpServerv4Failover -AutoStateTransition 1 -Force