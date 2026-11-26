function Get-UserReport {
    <#
    .SYNOPSIS
    Lists users by department from Microsoft Graph.
    .EXAMPLE
    Get-UserReport
    .EXAMPLE
    Get-UserReport -Department Sales
    #>
    [CmdletBinding()]
    param(
        [string]$Department,
        [string]$OutputPath
    )

    $users = Get-MgUser -All -Property DisplayName,UserPrincipalName,Department

    if (-not $Department) {
        $result = $users
    } elseif ($Department -eq 'None') {
        $result = $users | Where-Object { -not $_.Department }
    } else {
        $result = $users | Where-Object Department -eq $Department
    }
    Write-Verbose "Found $($result.Count) users"

    $result = $result | Select-Object DisplayName, UserPrincipalName, Department
    if ($OutputPath) { $result | Export-Csv $OutputPath }
    $result
}