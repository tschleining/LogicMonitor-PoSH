function Get-LMAlert {
        [CmdletBinding()]
         Param (
             [Parameter(Mandatory=$false)]
             [string]$Id
         )
         Confirm-LMPortalConnection
        $resource = 'Alerts'
        if ($Id) {
            Get-LMData -resource $resource -Id $Id
        }
        Else { Get-LMdata -resource $resource }
    }