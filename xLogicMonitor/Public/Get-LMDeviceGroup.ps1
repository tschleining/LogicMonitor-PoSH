    <#
            .SYNOPSIS
            Returns a list or specific Device Group
            .DESCRIPTION
            LogicMonitor documentation regarding Device Groups can be found at https://www.logicmonitor.com/support/devices/device-groups/device-groups-overview/
            .EXAMPLE
            Get-LMDeviceGroup -filters 'groupStatus:dead,groupType:Normal' -returnSize 50
            .EXAMPLE
            Get-LMDeviceGroup -Id 10
            .PARAMETER Id
            ID of the Device Group
            .PARAMETER returnSize
            Maximum amount of returned objects.  Default is 100.
            .PARAMETER filters
            Filters responses the API will return.  Useful for reducing API response size and time.
            .Outputs
            PSCustomObject
          #>
function Get-LMDeviceGroup {
        [CmdletBinding(DefaultParameterSetName="All")]
         Param (
             [Parameter(Mandatory=$false)]
             [string]$Id,
             [Parameter(ParameterSetName="filters")]
             [string]$filters,
             [Parameter(ParameterSetName="filters")]
             [int]$returnSize=100
         )

         begin
         {
            Confirm-LMPortalConnection
            $resource = 'DeviceGroups'
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