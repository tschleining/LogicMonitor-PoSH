function Convert-LMResourcePath {
        [CmdletBinding()]
        Param (
            [Parameter(Mandatory=$true)]
            [ValidateSet("SDT", "APIToken", "OpsNotes", "Alerts", "AuditLogs", "Collectors", "CollectorGroups", "UnmonitoredDevices", "Devices", "DeviceGroups", "Services")]
            [string]
            $resource
        )

        $ResourceList = @{
            "SDT" = "/sdt/sdts";
            "APIToken" = "/setting/admins/apitokens";
            "OpsNotes" = "/setting/opsnotes";
            "Alerts" = "/alert/alerts";
            "AuditLogs" = "/setting/accesslogs";
            "Collectors" = "/setting/collectors";
            "CollectorGroups" = "/setting/collectors/groups";
            "UnmonitoredDevices" = "/device/unmonitoreddevices";
            "Devices" = "/device/devices";
            "DeviceGroups" = "/device/groups";
            "Services" = "/service/services"
            }

        $ResourcePath = $ResourceList[$resource]
        return $ResourcePath
}