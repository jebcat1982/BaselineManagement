
Function Write-GPOPrivilegeINFData
{
    [CmdletBinding()]
    [OutputType([String])]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Privilege,

        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [string]$PrivilegeData
    )

    $privilegeHash = @{}
    $privilegeHash.Policy = ""
    $privilegeHash.Identity = ""

    # These are UserRights
    if ($UserRightsHash.ContainsKey($Privilege))
    {                        
        $privilegeHash.Policy = $UserRightsHash[$Privilege]
    }
    else
    {
        Write-Error "Cannot find $Privilege"
        return ""
    }

    $privilegeHash.Identity = $PrivilegeData -split ","
    
    Write-DSCString -Resource -Name "INF_$($privilegeHash.Policy)" -Type UserRightsAssignment -Parameters  $privilegeHash
}
