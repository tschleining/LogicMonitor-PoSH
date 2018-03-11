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
function Remove-LMCollectorGroup {
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact="High"
        )]
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $Id
    )
    
    begin {
        Confirm-LMPortalConnection
        $resource = 'CollectorGroups'
        $resourcePath = Convert-LMResourcePath -resource $resource
    }
    
    process {
        $resourcePathFull = $resourcePath + '/' + $Id
        $collectorGroup = Get-LMCollectorGroup -Id $Id

        if ($PSCmdlet.ShouldProcess("Collector " + $collectorGroup.name + " ID " + $Id)) {
            $response = Submit-LMData -resourcePath $resourcePathFull -httpVerb DELETE
            
            if ($response.errmsg -eq "OK") {
                $messageData = "Succesfully deleted " + $collectorGroup.name + " With ID of " + $Id
                Write-Host $messageData
            }
        }
    }
    
    end {
    }
}