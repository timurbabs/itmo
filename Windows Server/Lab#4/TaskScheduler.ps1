$name = "Task monitoring"
$description = "Dumps information about running processes to a csv file every 3 minutes"
$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument '-File C:\MonitoringLogCreater.ps1'
$time = New-TimeSpan -Minutes 3
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).Date -RepetitionInterval $time -RepetitionDuration ([timeSpan]::MaxValue)
$settings = New-ScheduledTaskSettingsSet -DontStopIfGoingOnBatteries -AllowStartIfOnBatteries

try
{
    Register-ScheduledTask -TaskName $name -Description $description -Action $action -Trigger $trigger -Settings $settings
}
catch
{
    Write-Error "Scheduled task is already exist"
}