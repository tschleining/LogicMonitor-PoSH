    <#
            .SYNOPSIS
            Returns a list of LogicMonitor Users
            .DESCRIPTION
            LogicMonitor documentation regarding Users can be found at https://www.logicmonitor.com/support/settings/users-and-roles/users/
            .EXAMPLE
            Get-LMUser
            .EXAMPLE
            Get-LMUser -Id 10
            .EXAMPLE
            Get-LMUser -filter 'lastName:admin'
            .EXAMPLE
            Get-LMUser -filter 'firstName~user'
            .EXAMPLE
            Get-LMUser -filter 'status:active'
            .PARAMETER Id
            ID of the User
            .PARAMETER returnSize
            Maximum amount of returned objects.  Default is 100.
            .PARAMETER filters
            Filters responses the API will return.  Useful for reducing API response size and time.
            .Outputs
            PSCustomObject
          #>
          function Get-LMUser {
            [CmdletBinding(DefaultParameterSetName="All")]
             Param (
                [Parameter(ParameterSetName="ID")]
                 [string]$Id,
                 [Parameter(ParameterSetName="filters")]
                 [string]$filters,
                 [Parameter(ParameterSetName="filters")]
                 [int]$returnSize=100
             )
             begin {
                Confirm-LMPortalConnection
                $resource = 'Users'
                $resourcePath = Convert-LMResourcePath -resource $resource
                $queryParams = Add-LMQueryParams -size $returnSize -filters $filters
             }
            
            process {
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