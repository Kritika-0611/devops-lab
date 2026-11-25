$users = Get-MgUser -All -Property DisplayName,UserPrincipalName,Department
$users | Where-Object { -not $_.Department } |
  Select-Object DisplayName, UserPrincipalName |
  Export-Csv ./no-department.csv
Write-Host "Users without department: $((Import-Csv ./no-department.csv).Count)"