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
            $ResourcePath = Convert-LMResourcePath -resource $resource -Id $Id
            $data = Get-LMData -ResourcePath $resourcePath
            $responseData = Convert-LMResponseData -data $data
            return $responseData

        }

    }