    <#
            .SYNOPSIS
            Returns a list or specific Audit Log
            .DESCRIPTION
            LogicMonitor documentation regarding Audit Logs can be found at https://www.logicmonitor.com/support/settings/access-logs/
            .EXAMPLE
            Get-LMAuditLog
            .EXAMPLE
            Get-LMAuditLog -Id 9jWCt8j-TzuVhvuBc9cquA
            .PARAMETER Id
            ID of the Audit Log
            .Outputs
            PSCustomObject
          #>
function Get-LMAuditLog {
        [CmdletBinding()]
         Param (
             [Parameter(Mandatory=$false)]
             [string]$Id
         )
         Confirm-LMPortalConnection
        $resource = 'AuditLogs'
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