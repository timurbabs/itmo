Get-adobject -Filter{deleted -eq $true} -IncludeDeletedObjects -Properties * | Where-Object LastKnownParent -like '*OU=unit-for-delete,DC=AFN,DC=local'| Restore-ADObject
