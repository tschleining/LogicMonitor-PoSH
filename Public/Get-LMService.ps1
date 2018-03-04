    <#
            .SYNOPSIS
            Returns a list or specific Services
            .DESCRIPTION
            LogicMonitor documentation regarding Services can be found at https://www.logicmonitor.com/support/services/
            .EXAMPLE
            Get-LMService
            .EXAMPLE
            Get-LMService -Id 10
            .PARAMETER Id
            ID of the Service
            .Outputs
            PSCustomObject
          #>
function Get-LMService {
        [CmdletBinding()]
         Param (
             [Parameter(Mandatory=$false)]
             [string]$Id
         )
         Confirm-LMPortalConnection
        $resource = 'Services'
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