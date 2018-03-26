function Convert-LMResourcePath {
        [CmdletBinding()]
        Param (
            [Parameter(Mandatory=$true)]
            [ValidateSet("SDT", "APIToken", "OpsNotes", "Alerts", "AuditLogs", "Collectors", "CollectorGroups", "UnmonitoredDevices", "Devices", "DeviceGroups", "Services", "Instances", "ServiceSDTs", "Users", "Roles", "SMCheckPoint", "DeviceProperties", "CollectorInstallers")]
            [string]
            $resource
        )

        DynamicParam
        {
            if ($resource -eq "Instances")
                {
                    $attributes = new-object System.Management.Automation.ParameterAttribute
                    $attributes.ParameterSetName = "__Instances"
                    $attributes.Mandatory = $true
                    $attributeCollection = new-object -Type System.Collections.ObjectModel.Collection[System.Attribute]
                    $attributeCollection.Add($attributes)

                    $dynParam1 = new-object -Type System.Management.Automation.RuntimeDefinedParameter("deviceId", [int], $attributeCollection)

                    $paramDictionary = new-object -Type System.Management.Automation.RuntimeDefinedParameterDictionary
                    $paramDictionary.Add("deviceId", $dynParam1)
                    #return $paramDictionary

                    $attributes = new-object System.Management.Automation.ParameterAttribute
                    $attributes.ParameterSetName = "__Instances"
                    $attributes.Mandatory = $true
                    $attributeCollection = new-object -Type System.Collections.ObjectModel.Collection[System.Attribute]
                    $attributeCollection.Add($attributes)

                    $dynParam2 = new-object -Type System.Management.Automation.RuntimeDefinedParameter("deviceDatasourceId", [int], $attributeCollection)

                    #$paramDictionary = new-object -Type System.Management.Automation.RuntimeDefinedParameterDictionary
                    $paramDictionary.Add("deviceDatasourceId", $dynParam2)
                    return $paramDictionary
                }

            if ($resource -eq "ServiceSDTs")
                {
                    $attributes = new-object System.Management.Automation.ParameterAttribute
                    $attributes.ParameterSetName = "__ServiceSDTs"
                    $attributes.Mandatory = $true
                    $attributeCollection = new-object -Type System.Collections.ObjectModel.Collection[System.Attribute]
                    $attributeCollection.Add($attributes)

                    $dynParam1 = new-object -Type System.Management.Automation.RuntimeDefinedParameter("Id", [int], $attributeCollection)

                    $paramDictionary = new-object -Type System.Management.Automation.RuntimeDefinedParameterDictionary
                    $paramDictionary.Add("Id", $dynParam1)
                    return $paramDictionary
                }

                if ($resource -eq "DeviceProperties")
                {
                    $attributes = new-object System.Management.Automation.ParameterAttribute
                    $attributes.ParameterSetName = "__DeviceProperties"
                    $attributes.Mandatory = $true
                    $attributeCollection = new-object -Type System.Collections.ObjectModel.Collection[System.Attribute]
                    $attributeCollection.Add($attributes)

                    $dynParam1 = new-object -Type System.Management.Automation.RuntimeDefinedParameter("deviceId", [int], $attributeCollection)

                    $paramDictionary = new-object -Type System.Management.Automation.RuntimeDefinedParameterDictionary
                    $paramDictionary.Add("deviceId", $dynParam1)
                    return $paramDictionary
                }

                if ($resource -eq "CollectorInstallers")
                {
                    $attributes = new-object System.Management.Automation.ParameterAttribute
                    $attributes.ParameterSetName = "__CollectorInstallers"
                    $attributes.Mandatory = $true
                    $attributeCollection = new-object -Type System.Collections.ObjectModel.Collection[System.Attribute]
                    $attributeCollection.Add($attributes)

                    $dynParam1 = new-object -Type System.Management.Automation.RuntimeDefinedParameter("Id", [int], $attributeCollection)

                    $paramDictionary = new-object -Type System.Management.Automation.RuntimeDefinedParameterDictionary
                    $paramDictionary.Add("Id", $dynParam1)
                    return $paramDictionary
                }
        }

        Begin {
        $ResourceList = @{
            "SDT" = "/sdt/sdts";
            "APIToken" = "/setting/admins/apitokens";
            "OpsNotes" = "/setting/opsnotes";
            "Alerts" = "/alert/alerts";
            "AuditLogs" = "/setting/accesslogs";
            "Collectors" = "/setting/collectors";
            "CollectorGroups" = "/setting/collectors/groups";
            "CollectorInstallers" = "/setting/collectors/{id}/installers/"
            "UnmonitoredDevices" = "/device/unmonitoreddevices";
            "Instances" = "/device/devices/{deviceId}/devicedatasources/{deviceDatasourceId}/instances";
            "Devices" = "/device/devices";
            "DeviceGroups" = "/device/groups";
            "Services" = "/service/services"
            "ServiceSDTs" = "/service/services/{id}/sdts";
            "Users" = "/setting/admins";
            "Roles" = "/setting/roles";
            "SMCheckPoint" = "/service/smcheckpoints";
            "DeviceProperties" = "/device/devices/{deviceID}/properties";
            }
        }

        Process {
            if ($resource -eq "Instances") {
                $ResourcePath = $ResourceList[$resource]
                $ResourcePath = $ResourcePath -replace "{deviceId}", $PSBoundParameters["deviceId"]
                $ResourcePath = $ResourcePath -replace "{deviceDatasourceId}", $PSBoundParameters["deviceDataSourceId"]
                return $ResourcePath
            }
            if ($resource -eq "ServiceSDTs") {
                $ResourcePath = $ResourceList[$resource]
                $ResourcePath = $ResourcePath -replace "{id}", $PSBoundParameters["Id"]
                return $ResourcePath
            }
            if ($resource -eq "DeviceProperties") {
                $ResourcePath = $ResourceList[$resource]
                $ResourcePath = $ResourcePath -replace "{deviceId}", $PSBoundParameters["deviceId"]
                return $ResourcePath
            }
            if ($resource -eq "CollectorInstallers") {
                $ResourcePath = $ResourceList[$resource]
                $ResourcePath = $ResourcePath -replace "{id}", $PSBoundParameters["Id"]
                return $ResourcePath
            }

            else {
            $ResourcePath = $ResourceList[$resource]
            return $ResourcePath
            }
        }
}