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
function Update-LMCollectorGroup {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $Id,
        [Parameter(Mandatory=$true)]
        [string]
        $name,
        [Parameter(Mandatory=$false)]
        [string]
        $description
    )
    
    begin {
        Confirm-LMPortalConnection
        $resource = 'CollectorGroups'
        $resourcePath = Convert-LMResourcePath -resource $resource
    }
    
    process {
        $resourcePathFull = $resourcePath + "/" + $Id
        $collectorGroup = Get-LMCollectorGroup -Id $Id
        $data = $PSBoundParameters

        foreach($param in $data.GetEnumerator())
        {
            #write-host $param.key
            #write-host $param.Value
            $collectorGroup.($param.Key) = $param.Value
        }

        $collectorGroup.PsObject.Members.Remove('Id')
        $collectorGroupSubmit = ConvertTo-Json $collectorGroup
        $responseData = Submit-LMData -resourcePath $resourcePathFull -Data $collectorGroupSubmit -httpVerb PUT
        $returnData = Convert-LMResponseData -data $responseData
        return $returnData
    }
    
    end {
    }
}