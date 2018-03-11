    <#
            .SYNOPSIS
            Returns a list or specific Audit Log
            .DESCRIPTION
            LogicMonitor documentation regarding Audit Logs can be found at https://www.logicmonitor.com/support/settings/access-logs/
            .EXAMPLE
            Get-LMAuditLog -returnSize 10 -filters 'ip:192.168.1.25'
            .EXAMPLE
            Get-LMAuditLog -Id 9jWCt8j-TzuVhvuBc9cquA
            .PARAMETER Id
            ID of the Audit Log
            .PARAMETER returnSize
            Maximum amount of returned objects.  Default is 100.
            .PARAMETER filters
            Filters responses the API will return.  Useful for reducing API response size and time.
            .Outputs
            PSCustomObject
          #>
function Get-LMAuditLog {
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
            $resource = 'AuditLogs'
            $resourcePath = Convert-LMResourcePath -resource $resource
            $queryParams = Add-LMQueryParams -size $returnSize -filters $filters
         }

        Process {
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