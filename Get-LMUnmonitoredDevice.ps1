function Get-LMUnmonitoredDevice {
        [CmdletBinding()]
         Param (
             [Parameter(Mandatory=$false)]
             [string]$Id
         )
        Confirm-LMPortalConnection

        $resource = 'UnmonitoredDevices'
        if ($Id) {
            Get-LMData -resource $resource -Id $Id
        }
        Else { Get-LMdata -resource $resource }
    }