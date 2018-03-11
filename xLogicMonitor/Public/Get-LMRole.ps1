    <#
            .SYNOPSIS
            Returns a list of LogicMonitor Roles
            .DESCRIPTION
            LogicMonitor documentation regarding Roles can be found at https://www.logicmonitor.com/support/settings/users-and-roles/roles/
            .EXAMPLE
            Get-LMRole
            .EXAMPLE
            Get-LMRole -Id 10
            .EXAMPLE
            Get-LMRole -filter 'name:admins'
            .EXAMPLE
            Get-LMRole -filter 'description~readonly'
            .EXAMPLE
            Get-LMRole -filter 'acctRequireTwoFA:True'
            .PARAMETER Id
            ID of the Role
            .PARAMETER returnSize
            Maximum amount of returned objects.  Default is 100.
            .PARAMETER filters
            Filters responses the API will return.  Useful for reducing API response size and time.
            .Outputs
            PSCustomObject
          #>
          function Get-LMRole {
            [CmdletBinding(DefaultParameterSetName="All")]
             Param (
                [Parameter(ParameterSetName="ID")]
                 [string]$Id,
                 [Parameter(ParameterSetName="filters")]
                 [string]$filters,
                 [Parameter(ParameterSetName="filters")]
                 [int]$returnSize=100
             )
             begin
             {
                Confirm-LMPortalConnection
                $resource = 'Roles'
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
    
                $data = Get-LMData -ResourcePath $resourcePath -queryParams $queryParams
                $responseData = Convert-LMResponseData -data $data
                return $responseData
            }
    
        }