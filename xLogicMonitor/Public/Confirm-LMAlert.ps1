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
function Confirm-LMAlert {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $Id,
        [Parameter(Mandatory=$true)]
        [string]
        $ackComment
    )
    
    begin {
        Confirm-LMPortalConnection
        $resource = 'Alerts'
        $resourcePath = Convert-LMResourcePath -resource $resource
    }
    
    process {
        $resourcePathFull = $resourcePath + '/' + $Id + "/ack"
        $data = $PSBoundParameters
        $data.PsObject.Members.Remove('Id')
        $dataSubmit = ConvertTo-Json $data
        $response = Submit-LMData -resourcePath $resourcePathFull -Data $dataSubmit -httpVerb POST
        if ($response.errmsg -eq "OK") {
            $messageData = "Succesfully Acknowledged " + $Id
            Write-Host $messageData
        }
    }
    
    end {
    }
}