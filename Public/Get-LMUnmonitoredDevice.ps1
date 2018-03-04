    <#
            .SYNOPSIS
            Returns a list or specific Unmonitored Devices
            .DESCRIPTION
            LogicMonitor documentation regarding Unmonitored Netscan Devices can be found at https://www.logicmonitor.com/support/devices/devices-page-overview/unmonitored-netscan-devices/
            .EXAMPLE
            Get-LMUnmonitoredDevice
            .EXAMPLE
            Get-LMUnmonitoredDevice -Id 10
            .PARAMETER Id
            ID of the Unmonitored Device
            .Outputs
            PSCustomObject
          #>
function Get-LMUnmonitoredDevice {
        [CmdletBinding()]
         Param (
             [Parameter(Mandatory=$false)]
             [string]$Id
         )
        Confirm-LMPortalConnection

        $resource = 'UnmonitoredDevices'
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