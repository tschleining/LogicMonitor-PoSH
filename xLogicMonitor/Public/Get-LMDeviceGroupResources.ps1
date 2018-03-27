<#
.SYNOPSIS
    Get all devices in a specific Device Group by supplying an ID.
.DESCRIPTION
    Get top level devices in a specific Device Group.  This Cmdlet will not get devices/resources recursively if you have nested device groups.
.EXAMPLE
    Get-LMDeviceGroupResources -Id 100 -returnSize 5
.EXAMPLE
    Get-LMDeviceGroupResources -id 100
#>
function Get-LMDeviceGroupResources {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $Id,
        [Parameter(ParameterSetName="filters")]
        [string]$filters,
        [Parameter(ParameterSetName="filters")]
        [int]$returnSize=100
    )
    
    begin {
        Confirm-LMPortalConnection
        $resource = 'DeviceGroupResources'
        $queryParams = Add-LMQueryParams -size $returnSize -filters $filters
    }
    
    process {
        $resourcePath = Convert-LMResourcePath -resource $resource -Id $Id
        $data = Get-LMData -resourcePath $resourcePath -queryParams $queryParams
        $responseData = Convert-LMResponseData -data $data
        return $responseData
    }
    
    end {
    }
}