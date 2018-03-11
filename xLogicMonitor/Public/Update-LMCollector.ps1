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
function Update-LMCollector {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [int]
        $Id,
        [Parameter(Mandatory=$false)]
        [string]
        $description,
        [Parameter(Mandatory=$false)]
        [int]
        $backupAgentId,
        [Parameter(Mandatory=$false)]
        [bool]
        $enableFailBack,
        [Parameter(Mandatory=$false)]
        [int]
        $resendIval,
        [bool]
        $suppressAlertClear,
        [int]
        $escalatingChainId,
        [int]
        $collectorGroupId,
        [bool]
        $enableFailOverOnCollectorDevice,
        [bool]
        $needAutoCreateCollectorDevice

    )
    
    begin {
        Confirm-LMPortalConnection
        $resource = 'Collectors'
        $resourcePath = Convert-LMResourcePath -resource $resource
    }
    
    process {
        $resourcePathFull = $resourcePath + '/' + $Id
        $collector = Get-LMCollector -Id $Id
        $data = $PSBoundParameters

        foreach($param in $data.GetEnumerator())
            {
                #write-host $param.key
                #write-host $param.Value
                $collector.($param.Key) = $param.Value
            }

        $collector.PsObject.Members.Remove('Id')
        $collectorSubmit = ConvertTo-Json $collector
        Submit-LMData -resourcePath $resourcePathFull -Data $collectorSubmit -httpVerb PUT
        
    }
    
    end {
    }
}