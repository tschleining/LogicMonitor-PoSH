<#
.SYNOPSIS
    Short description
.DESCRIPTION
    Long description
.EXAMPLE
    Example of how to use this cmdlet
.EXAMPLE
    Another example of how to use this cmdlet
#>
function Get-LMSMCheckPoint {
    [CmdletBinding(DefaultParameterSetName="All")]
    param(
        [Parameter(ParameterSetName="Id")]
        [int]$Id,
        [Parameter(ParameterSetName="filters")]
        [string]$filters,
        [Parameter(ParameterSetName="filters")]
        [int]$returnSize=100
    )
    
    begin {
        Confirm-LMPortalConnection
        $resource = 'SMCheckPoint'
        $resourcePath = Convert-LMResourcePath -resource $resource
        $queryParams = Add-LMQueryParams -size $returnSize -filters $filters
    }
    
    process {
        if ($Id) {
            throw "BROKEN!"
            # $data = Get-LMData -resourcePath $resourcePath -Id $Id
            # $responseData = Convert-LMResponseData -data $data
            # return $responseData
        }
        
        else {
            $data = Get-LMData -ResourcePath $resourcePath -queryParams $queryParams
            $responseData = Convert-LMResponseData -data $data
            return $responseData
        }

    }
    
    end {
    }
}