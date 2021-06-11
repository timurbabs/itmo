$diskNumberCollection = (Get-Disk).Number
Write-Host "Available disks:" $diskNumberCollection
$diskNumber = Read-Host "Select the disk number"

if($diskNumberCollection -notcontains $diskNumber)
{
    Write-Error -Message "Disk $diskNumber doesn't exist" -ErrorAction 'Stop'
}

Write-Host "All data on the disk will be erased" -ForegroundColor Green
Write-Host "Press [Y] to continue or ANY KEY to refuse" -ForegroundColor Green
$key = Read-Host "Key"

if($key -contains "Y")
{
    Set-Disk $diskNumber -IsOffline $false
    Set-Disk $diskNumber -IsReadOnly $false
    New-Partition -DiskNumber $diskNumber -Size 1GB -DriveLetter T
    Format-Volume -DriveLetter T -FileSystem NTFS -Confirm: $false
    Get-Volume -DriveLetter T
}