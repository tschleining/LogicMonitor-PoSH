function Add-LMDatasourceInstance {
    [CmdletBinding()]
    Param (
        [int]$groupId,
        [Parameter(Mandatory=$true)]
        [string]$displayName,
        [string]$description,
        [Parameter(Mandatory=$true)]
        [string]$wildValue,
        [bool]$disableAlerting,
        [bool]$stopMonitoring,
        [Parameter(Mandatory=$true)]
        [int]$deviceId,
        [Parameter(Mandatory=$true)]
        [int]$deviceDatasourceId

    )

    # DynamicParam
    # {
    # }


    Begin
         {
            Confirm-LMPortalConnection
            $resource = 'Instances'
         }

    Process
        {  
            #Convert all the local function parameters to JSON
            $data = ConvertTo-Json $PSBoundParameters
            #Get relative resource path to build complete URI
            $ResourcePath = Convert-LMResourcePath -resource $resource -deviceId $deviceId -deviceDatasourceId $deviceDatasourceId
            Submit-LMData -Data $data -resourcePath $ResourcePath
        }

}