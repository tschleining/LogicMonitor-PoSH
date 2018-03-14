<#
.SYNOPSIS
    Short description
.DESCRIPTION
    Long description
.EXAMPLE
    Example of how to use this cmdlet
.EXAMPLE
    Another example of how to use this cmdlet
#>
function Get-LMDeviceProperties {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [int]
        $deviceId

    )
    
    begin {
        $resource = "DeviceProperties"
        Confirm-LMPortalConnection
    }
    
    process {
        $resourcePath = Convert-LMResourcePath -resource $resource -deviceId $deviceId
        write-host $resourcePath
        $data = Get-LMData -resourcePath $resourcePath
        $responseData = Convert-LMResponseData -data $data
        return $responseData
    }
    
    end {
    }
}