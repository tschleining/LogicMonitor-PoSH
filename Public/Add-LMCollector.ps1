function Add-LMCollector {
    [CmdletBinding()]
    Param (
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


    Begin
         {
            Confirm-LMPortalConnection
            $resource = 'Collectors'
            $resourcePath = Convert-LMResourcePath -resource $resource
         }

    Process
        {  
            #Convert all the local function parameters to JSON
            $submitData = ConvertTo-Json $PSBoundParameters
            #write-host $data
            $data = Submit-LMData -resourcePath $ResourcePath -Data $submitData -httpVerb POST
            $responseData = Convert-LMResponseData -data $data
            return $responseData
        }

}