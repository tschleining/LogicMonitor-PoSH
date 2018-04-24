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
function Add-LMRole {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $name,
        [Parameter(Mandatory=$false)]
        [string]
        $description,
        [Parameter(Mandatory=$false)]
        [bool]
        $requireEula,
        [Parameter(Mandatory=$false)]
        [string]
        $customHelpLabel,
        [Parameter(Mandatory=$false)]
        [System.Uri]
        $customHelpURL
    )
    
    begin {
        Confirm-LMPortalConnection
        $resource = 'Roles'
        $resourcePath = Convert-LMResourcePath -resource $resource
    }
    
    process {
        $data = ConvertTo-Json $PSBoundParameters
        $responseData = Submit-LMData -resourcePath $ResourcePath -Data $data -httpVerb POST
        return $responseData
    }
    
    end {
    }
}