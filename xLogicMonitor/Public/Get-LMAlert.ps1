    <#
            .SYNOPSIS
            Returns a list or specific Alert
            .DESCRIPTION
            LogicMonitor documentation regarding Alerts can be found at https://www.logicmonitor.com/support/alerts/
            .EXAMPLE
            Get-LMAlert -Id DS3
            .EXAMPLE
            Get-LMAlert -returnSize 50 -filters 'type:dataSourceAlert,acked:False'
            .EXAMPLE
            Get-LMAlert
            .PARAMETER Id
            ID of the Alert
            .PARAMETER returnSize
            Maximum amount of returned objects.  Default is 100.
            .PARAMETER filters
            Filters responses the API will return.  Useful for reducing API response size and time.
            .Outputs
            PSCustomObject
          #>
function Get-LMAlert {
        [CmdletBinding(DefaultParameterSetName="All")]
         Param (
             [Parameter(ParameterSetName="Id", Mandatory=$false)]
             [string]$Id,
             [Parameter(ParameterSetName="filters", Mandatory=$false)]
             [string]$filters,
             [Parameter(ParameterSetName="filters", Mandatory=$false)]
             [int]$returnSize=100
         )

    begin
         {
            Confirm-LMPortalConnection
            $resource = 'Alerts'
            $resourcePath = Convert-LMResourcePath -resource $resource
            $queryParams = Add-LMQueryParams -size $returnSize -filters $filters
         }

    process
        {  
            if ($Id) {
                $data = Get-LMData -resourcePath $resourcePath -Id $Id
                $responseData = Convert-LMResponseData -data $data
                #$returnData = Format-LMReturnData -data $responseData -properties $properties
                return $responseData
            }
            else {
                $data = Get-LMData -ResourcePath $resourcePath -queryParams $queryParams
                $responseData = Convert-LMResponseData -data $data
                #$returnData = Format-LMReturnData -data $responseData -properties $properties
                return $responseData
            }

        }

    }