    <#
            .SYNOPSIS
            Returns a list or specific Collector
            .DESCRIPTION
            LogicMonitor documentation regarding Collectors can be found at https://www.logicmonitor.com/support/settings/collectors/about-the-logicmonitor-collector/
            .EXAMPLE
            Get-LMCollector -filters 'collectorSize:medium,numberOfHosts>50'
            .EXAMPLE
            Get-LMCollector -Id 10
            .PARAMETER Id
            ID of the Collector
            .PARAMETER returnSize
            Maximum amount of returned objects.  Default is 100.
            .PARAMETER filters
            Filters responses the API will return.  Useful for reducing API response size and time.
            .Outputs
            PSCustomObject
          #>
function Get-LMCollector {
        [CmdletBinding(DefaultParameterSetName="All")]
         Param (
             [Parameter(Mandatory=$false)]
             [string]$Id,
             [Parameter(ParameterSetName="filters", Mandatory=$false)]
             [string]$filters,
             [Parameter(ParameterSetName="filters", Mandatory=$false)]
             [int]$returnSize=100
         )
        begin {
            Confirm-LMPortalConnection
            $resource = 'Collectors'
            $resourcePath = Convert-LMResourcePath -resource $resource
            $queryParams = Add-LMQueryParams -size $returnSize -filters $filters
            $properties = @("id", "hostname","collectorSize", "numberOfHosts", "collectorGroupName")
        }

        process {
            if ($Id) {
                $data = Get-LMData -resourcePath $resourcePath -Id $Id
                $responseData = Convert-LMResponseData -data $data
                $returnData = Format-LMReturnData -data $responseData -properties $properties
                return $returnData
            }
            else {
                $data = Get-LMData -ResourcePath $resourcePath -queryParams $queryParams
                $responseData = Convert-LMResponseData -data $data
                $returnData = Format-LMReturnData -data $responseData -properties $properties
                return $returnData
            }
        }

    }