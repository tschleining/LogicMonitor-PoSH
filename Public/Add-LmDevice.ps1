function Add-LMDevice {
        [CmdletBinding()]
        Param (
            [Parameter(Mandatory=$true)]
            [string]
            $name,
            [Parameter(Mandatory=$true)]
            [string]
            $displayName,
            [Parameter(Mandatory=$true)]
            [int]
            $preferredCollectorId,
            [Parameter(Mandatory=$true)]
            [int]
            $hostGroupIds,
            [int]
            $description,
            [bool]
            $disableAlerting,
            [System.Uri]
            $link,
            [Parameter(Mandatory=$false, ParameterSetName="Netflow")]
            [bool]
            $enableNetflow,
            [string]
            $customProperties

        )

        DynamicParam
        {
            if ($enableNetflow -eq $true)
                {
                    $attributes = new-object System.Management.Automation.ParameterAttribute
                    $attributes.ParameterSetName = "__AllParameterSets"
                    $attributes.Mandatory = $true
                    $attributeCollection = new-object -Type System.Collections.ObjectModel.Collection[System.Attribute]
                    $attributeCollection.Add($attributes)

                    $dynParam1 = new-object -Type System.Management.Automation.RuntimeDefinedParameter("netflowCollectorId", [int], $attributeCollection)

                    $paramDictionary = new-object -Type System.Management.Automation.RuntimeDefinedParameterDictionary
                    $paramDictionary.Add("netflowCollectorId", $dynParam1)
                    return $paramDictionary
                }
        }


        Begin
             {
                Confirm-LMPortalConnection
                $resource = 'Devices'
             }

        Process
            {  
                #Convert all the local function parameters to JSON
                $data = ConvertTo-Json $PSBoundParameters
                #write-host $data
                $ResourcePath = Convert-LMResourcePath -resource $resource
                Submit-LMData -resourcePath $ResourcePath -Data $data
                #$collectors.data.items | select id,hostname,collectorgroupname,isdown,numberofhosts
            }

            
    
}