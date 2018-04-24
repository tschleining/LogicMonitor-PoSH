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
function Add-LMService {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $name,
        [Parameter(Mandatory=$true)]
        [ValidateSet("ping", "webservice")]
        $type,
        [Parameter(Mandatory=$false)]
        [bool]
        $isInternal,
        [string]
        $description
    )
    
    begin {
    }
    
    process {
        throw "not implemented"
    }
    
    end {
    }
}