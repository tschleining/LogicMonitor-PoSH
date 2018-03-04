    <#
            .SYNOPSIS
            Returns a list or specific Collector Group
            .DESCRIPTION
            LogicMonitor documentation regarding Collector Groups can be found at https://www.logicmonitor.com/support/settings/collectors/collector-groups/
            .EXAMPLE
            Get-LMCollectorGroup
            .EXAMPLE
            Get-LMCollectorGroup -Id 10
            .PARAMETER Id
            ID of the Collector Group
            .Outputs
            PSCustomObject
          #>
function Get-LMCollectorGroup {
        [CmdletBinding()]
         Param (
             [Parameter(Mandatory=$false)]
             [string]$Id
         )
         Confirm-LMPortalConnection
        $resource = 'CollectorGroups'
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