<#
.SYNOPSIS
    Use this Cmdlet to acknowledge collector down alerts.
.DESCRIPTION
    
.EXAMPLE
    Confirm-LMCollectorDown -Id 1000 -comment 'Comment to acknowledge a collector down alert.'
#>
function Confirm-LMCollectorDown {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $Id,
        [Parameter(Mandatory=$true)]
        [string]
        $comment
    )
    
    begin {
        Confirm-LMPortalConnection
        $resource = 'CollectorDown'
        $resourcePathFull = Convert-LMResourcePath -resource $resource -Id $Id
    }
    
    process {
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