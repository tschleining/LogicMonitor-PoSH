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
            .PARAMETER returnSize
            Maximum amount of returned objects.  Default is 100.
            .PARAMETER filters
            Filters responses the API will return.  Useful for reducing API response size and time.
            .Outputs
            PSCustomObject
          #>
function Get-LMUnmonitoredDevice {
        [CmdletBinding(DefaultParameterSetName="All")]
         Param (
             [Parameter(Mandatory=$false)]
             [string]$Id,
             [Parameter(ParameterSetName="filters", Mandatory=$false)]
             [string]$filters,
             [Parameter(ParameterSetName="filters", Mandatory=$false)]
             [int]$returnSize=100
         )
        begin
        {        
             Confirm-LMPortalConnection
             $resource = 'UnmonitoredDevices'
             $resourcePath = Convert-LMResourcePath -resource $resource
             $queryParams = Add-LMQueryParams -size $returnSize -filters $filters
        }

        process
        {
            if ($Id) {
                $data = Get-LMData -resourcePath $resourcePath -Id $Id
                $responseData = Convert-LMResponseData -data $data
                return $responseData
            }
            else {
                $data = Get-LMData -ResourcePath $resourcePath -queryParams $queryParams
                $responseData = Convert-LMResponseData -data $data
                return $responseData
            }
        }

    }