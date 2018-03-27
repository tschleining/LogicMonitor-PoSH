<#
.SYNOPSIS
    Adds a note to an alert.  Will not acknowledge the alert.
.DESCRIPTION
    
.EXAMPLE
    Add-LMAlertNote -Id 1000 -ackComment 'Alert Ack Comment'
#>
function Add-LMAlertNote {
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
        $resource = 'AlertNote'
        $resourcePath = Convert-LMResourcePath -resource $resource -Id $Id
    }
    
    process {
        $data = $PSBoundParameters
        $data.PsObject.Members.Remove('Id')
        $submitData = ConvertTo-Json $data
        $response = Submit-LMData -resourcePath $ResourcePath -Data $submitData -httpVerb POST
        if ($response.errmsg -eq "OK") {
            $messageData = "Succesfully Acknowledged " + $Id
            Write-Host $messageData
        }
    }
    
    end {
    }
}