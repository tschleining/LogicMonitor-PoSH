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
function Get-LMServiceAlert {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $Id
    )
    
    begin {
        Confirm-LMPortalConnection
        $resource = 'ServiceAlert'
        $resourcePath = Convert-LMResourcePath -resource $resource -Id $Id
    }
    
    process {
        $data = Get-LMData -resourcePath $resourcePath
        $responseData = Convert-LMResponseData -data $data
        return $responseData
    }
    
    end {
    }
}