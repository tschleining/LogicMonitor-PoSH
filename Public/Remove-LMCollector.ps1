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
function Remove-LMCollector {
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
        $resource = 'Collectors'
        $resourcePath = Convert-LMResourcePath -resource $resource
    }
    
    process {
        $resourcePathFull = $resourcePath + '/' + $Id
        $collector = Get-LMCollector -Id $Id

        if ($PSCmdlet.ShouldProcess("Collector " + $collector.hostname + " ID " + $Id)) {
            $response = Submit-LMData -resourcePath $resourcePathFull -httpVerb DELETE
            
            if ($response.errmsg -eq "OK") {
                $messageData = "Succesfully deleted " + $collector.hostname + " With ID of " + $Id
                Write-Host $messageData
            }
        }
    }
    
    end {
    }
}