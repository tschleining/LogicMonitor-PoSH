function Get-LMServiceSDT {
        [CmdletBinding()]
         Param (
             [Parameter(Mandatory=$true)]
             [string]$Id
         )

         Begin
         {
            Confirm-LMPortalConnection
            $resource = 'ServiceSDTs'
         }

    Process
        {  
            #$data = ConvertTo-Json $PSBoundParameters

            $ResourcePath = Convert-LMResourcePath -resource $resource -Id $Id
            Get-LMData -resourcePath $ResourcePath

        }

    }