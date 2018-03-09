    <#
            .SYNOPSIS
            Returns a list or specific Device
            .DESCRIPTION
            LogicMonitor documentation regarding Devices can be found at https://www.logicmonitor.com/support/devices/adding-managing-devices/
            .EXAMPLE
            Get-LMDevice
            .EXAMPLE
            Get-LMDevice -Id 10
            .EXAMPLE
            Get-LMDevice -returnSize 1000 -filters 'displayName~SVR'
            .PARAMETER Id
            ID of the Device
            .PARAMETER returnSize
            Maximum amount of returned objects.  Default is 100.
            .PARAMETER filters
            Filters responses the API will return.  Useful for reducing API response size and time.
            .Outputs
            PSCustomObject
          #>
function Get-LMDevice {
        [CmdletBinding(DefaultParameterSetName="All")]
         Param (
            [Parameter(ParameterSetName="ID", Mandatory=$false)]
             [string]$Id,
             [Parameter(ParameterSetName="filters")]
             [string]$filters,
             [Parameter(ParameterSetName="filters")]
             [int]$returnSize=100
         )
         begin {
            Confirm-LMPortalConnection
            $resource = 'Devices'
            $resourcePath = Convert-LMResourcePath -resource $resource
            $queryParams = Add-LMQueryParams -size $returnSize -filters $filters
         }
        
        process {
            if ($Id) {
                $data = Get-LMData -resourcePath $resourcePath -Id $Id
                $responseData = Convert-LMResponseData -data $data
                return $responseData
            }

            $data = Get-LMData -ResourcePath $resourcePath -queryParams $queryParams
            $responseData = Convert-LMResponseData -data $data
            return $responseData
        }

    }