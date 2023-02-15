Function Remove-Null {
    [cmdletbinding()]
    param(
        # Object to remove null values from
        [parameter(ValueFromPipeline, Mandatory)]
        [object[]]$InputObject,
        #By default, remove empty strings (""), specify -LeaveEmptyStrings to leave them.
        [switch]$LeaveEmptyStrings
    )
    process {
        foreach ($obj in $InputObject) {
            $AllProperties = $obj.psobject.properties.Name
            $NonNulls = $AllProperties |
            where-object { $null -ne $obj.$PSItem } |
            where-object { $LeaveEmptyStrings.IsPresent -or -not [string]::IsNullOrEmpty($obj.$PSItem) }
            $obj | Select-Object -Property $NonNulls
        }
    }
}

$CIM = Get-CimInstance -ClassName CIM_OperatingSystem
foreach ($Property in $CIM.PSObject.Properties) {
    Write-Host $Property.Name -ForegroundColor Cyan
    Write-Host $Property.Value
    Write-Host
}

$CIM1 = Get-CimInstance -Query "SELECT Name, Domain FROM Win32_ComputerSystem"
$CIM2 = Get-CimInstance -ClassName CIM_OperatingSystem -Property Name, Caption, InstallDate

$CIM2
foreach ($Property in $CIM2.PSObject.Properties) {
    if ($Property.Value -ne $null) {
        Write-Host $Property.Name -ForegroundColor Green
        Write-Host $Property.Value
    }
    else {
        # Write-Host $Property.Name -ForegroundColor Cyan
        # Write-Host $Property.Value
        # Write-Host 
    }
}