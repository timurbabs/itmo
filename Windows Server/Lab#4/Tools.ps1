$infoPath = "C:\info.txt"

Get-EventLog System | 
    Where-Object {$_.EventID -contains "6009"} | 
    Select -First 10 > $infoPath

Get-HotFix | 
    Sort InstalledOn -Descending | 
    Select-Object HotFixID, InstalledOn -First 5 >> $infoPath

Get-WinEvent -ListLog * | 
    Where-Object {$_.RecordCount -AND $_.LastWriteTime -LE (Get-Date).AddDays(-1)} | 
    ForEach-Object {Get-WinEvent -LogName $_.LogName} | 
    Group-Object -Property LevelDisplayName |
    Where-Object {"Ошибка","Предупреждение" -contains $_.Name} | 
    Select-Object Name, Count >> $infoPath