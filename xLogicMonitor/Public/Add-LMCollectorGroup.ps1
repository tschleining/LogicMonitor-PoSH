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
function Add-LMCollectorGroup {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $name,
        [Parameter(Mandatory=$true)]
        [string]
        $description
    )
    
    begin {
        Confirm-LMPortalConnection
        $resource = 'CollectorGroups'
        $resourcePath = Convert-LMResourcePath -resource $resource
    }
    
    process {
        $submitData = ConvertTo-Json $PSBoundParameters
        $data = Submit-LMData -resourcePath $ResourcePath -Data $submitData -httpVerb POST
        $responseData = Convert-LMResponseData -data $data
        return $responseData
    }
    
    end {
    }
}