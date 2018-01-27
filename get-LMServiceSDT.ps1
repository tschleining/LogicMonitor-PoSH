function Get-LMServiceSDT {
        [CmdletBinding()]
         Param (
             [Parameter(Mandatory=$false)]
             [string]$Id
         )
         Confirm-LMPortalConnection
        $resource = 'SDT'
        if ($Id) {
            Get-LMData -resource $resource -Id $Id
        }
        Else { Get-LMdata -resource $resource }
    }