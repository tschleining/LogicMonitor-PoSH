    <#
            .SYNOPSIS
            Returns a list or specific Service Scheduled Down Times
            .DESCRIPTION
            LogicMonitor documentation regarding Schedule Down Times can be found at https://www.logicmonitor.com/support/devices/devices-page-overview/scheduled-down-time-sdt-tab/
            .EXAMPLE
            Get-LMServiceSDT
            .EXAMPLE
            Get-LMServiceSDT -Id 10
            .PARAMETER Id
            ID of the Service Scheduled Down Time
            .PARAMETER returnSize
            Maximum amount of returned objects.  Default is 100.
            .PARAMETER filters
            Filters responses the API will return.  Useful for reducing API response size and time.
            .Outputs
            PSCustomObject
          #>
function Get-LMServiceSDT {
        [CmdletBinding(DefaultParameterSetName="All")]
         Param (
            [Parameter(ParameterSetName="Id", Mandatory=$true)]
            [string]$Id,
            [Parameter(ParameterSetName="filters", Mandatory=$false)]
            [string]$filters,
            [Parameter(ParameterSetName="filters", Mandatory=$false)]
            [int]$returnSize=100
         )

        begin
        {
            Confirm-LMPortalConnection
            $resource = 'ServiceSDTs'
        }

        process
        {  
            $resourcePath = Convert-LMResourcePath -resource $resource -Id $Id
            $data = Get-LMData -resourcePath $resourcePath -Id $Id
            $responseData = Convert-LMResponseData -data $data
            return $responseData

        }

    }