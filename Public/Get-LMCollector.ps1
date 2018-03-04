    <#
            .SYNOPSIS
            Returns a list or specific Collector
            .DESCRIPTION
            LogicMonitor documentation regarding Collectors can be found at https://www.logicmonitor.com/support/settings/collectors/about-the-logicmonitor-collector/
            .EXAMPLE
            Get-LMCollector
            .EXAMPLE
            Get-LMCollector -Id 10
            .PARAMETER Id
            ID of the Collector
            .Outputs
            PSCustomObject
          #>
function Get-LMCollector {
        [CmdletBinding()]
         Param (
             [Parameter(Mandatory=$false)]
             [string]$Id
         )
        begin {
            Confirm-LMPortalConnection
            $resource = 'Collectors'
            $resourcePath = Convert-LMResourcePath -resource $resource
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
                $data = Get-LMData -ResourcePath $resourcePath
                $responseData = Convert-LMResponseData -data $data
                $returnData = Format-LMReturnData -data $responseData -properties $properties
                return $returnData
            }
        }

    }