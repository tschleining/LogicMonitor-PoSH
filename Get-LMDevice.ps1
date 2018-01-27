function Get-LMDevice {
        [CmdletBinding()]
         Param (
             [Parameter(Mandatory=$false)]
             [string]$Id
         )
         Confirm-LMPortalConnection
        $resource = 'Devices'
        if ($Id) {
            Get-LMData -resource $resource -Id $Id
        }
        Else { Get-LMdata -resource $resource }
    }