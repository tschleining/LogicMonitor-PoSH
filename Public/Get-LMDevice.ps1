    <#
            .SYNOPSIS
            Returns a list or specific Device
            .DESCRIPTION
            LogicMonitor documentation regarding Devices can be found at https://www.logicmonitor.com/support/devices/adding-managing-devices/
            .EXAMPLE
            Get-LMDevice
            .EXAMPLE
            Get-LMDevice -Id 10
            .PARAMETER Id
            ID of the Device
            .Outputs
            PSCustomObject
          #>
function Get-LMDevice {
        [CmdletBinding()]
         Param (
             [Parameter(Mandatory=$false)]
             [string]$Id,
             [Parameter(ParameterSetName="Name", Mandatory=$false)]
             [string]$Name
         )
        Confirm-LMPortalConnection
        $resource = 'Devices'
        $resourcePath = Convert-LMResourcePath -resource $resource
        if ($Id) {
            $data = Get-LMData -resourcePath $resourcePath -Id $Id
            $responseData = Convert-LMResponseData -data $data
            return $responseData
        }
        #This needs to either build query params or call a private function that returns the proper string
        if ($name) {
            $data = Get-LMData -ResourcePath 
        }
        else {
            $data = Get-LMData -ResourcePath $resourcePath
            $responseData = Convert-LMResponseData -data $data
            return $responseData
        }
    }