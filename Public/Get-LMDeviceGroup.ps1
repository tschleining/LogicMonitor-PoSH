    <#
            .SYNOPSIS
            Returns a list or specific Device Group
            .DESCRIPTION
            LogicMonitor documentation regarding Device Groups can be found at https://www.logicmonitor.com/support/devices/device-groups/device-groups-overview/
            .EXAMPLE
            Get-LMDeviceGroup
            .EXAMPLE
            Get-LMDeviceGroup -Id 10
            .PARAMETER Id
            ID of the Device Group
            .Outputs
            PSCustomObject
          #>
function Get-LMDeviceGroup {
        [CmdletBinding()]
         Param (
             [Parameter(Mandatory=$false)]
             [string]$Id
         )
         Confirm-LMPortalConnection
        $resource = 'DeviceGroups'
        $resourcePath = Convert-LMResourcePath -resource $resource
        if ($Id) {
            $data = Get-LMData -resourcePath $resourcePath -Id $Id
            $responseData = Convert-LMResponseData -data $data
            return $responseData
        }
        else {
            $data = Get-LMData -ResourcePath $resourcePath
            $responseData = Convert-LMResponseData -data $data
            return $responseData
        }
    }