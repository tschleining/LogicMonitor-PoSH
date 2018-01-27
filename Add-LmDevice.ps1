function Add-LmDevice {
        [CmdletBinding()]
        Param (
            [Parameter(Mandatory=$true)]
            [string]
            $name,
            [Parameter(Mandatory=$true)]
            [string]
            $displayname,
            [Parameter(Mandatory=$true)]
            [string]
            $preferredCollectorId,
            [Parameter(Mandatory=$true)]
            [string]
            $hostGroupIds,
            [string]
            $description,
            [bool]
            $disableAlerting,
            [string]
            $link,
            [Parameter(Mandatory=$false, ParameterSetName="Netflow")]
            [bool]
            $enableNetflow,
            [Parameter(Mandatory=$true, ParameterSetName="Netflow")]
            [int]
            $netflowCollectorId,
            [string]
            $customProperties

        )
        Confirm-LMPortalConnection

        begin
            {
                $resource = "Devices"
            }

        process
            {
                $data = '{"name":"' + $name + '","displayName":"' + $displayname + '","preferredCollectorId":' + $preferredCollectorId + ',"hostGroupIds":2,}'
                throw "function not complete"
            }
    
}





#data = '{"name":"172.16.19.171","displayName":"ProdServer25","preferredCollectorId":171,"hostGroupIds":2,"customProperties":[{"name":"snmp.version","value":"v3"},{"name":"location","value":"Santa Barbara,CA"}]}'