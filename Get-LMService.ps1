function Get-LMService {
        [CmdletBinding()]
         Param (
             [Parameter(Mandatory=$false)]
             [string]$Id
         )
         Confirm-LMPortalConnection
        $resource = 'Services'
        if ($Id) {
            Get-LMData -resource $resource -Id $Id
        }
        Else { Get-LMdata -resource $resource }
    }