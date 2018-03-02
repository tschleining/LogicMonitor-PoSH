function Get-LMService {
        [CmdletBinding()]
         Param (
             [Parameter(Mandatory=$false)]
             [string]$Id
         )
         Confirm-LMPortalConnection
        $resource = 'Services'
        $resourcePath = Convert-LMResourcePath -resource $resource
        if ($Id) {
            $data = Get-LMData -resourcePath $resourcePath -Id $Id
            $returnData = Convert-LMReturnData -data $data
            return $returnData
        }
        else {
            $data = Get-LMData -ResourcePath $resourcePath
            $returnData = Convert-LMReturnData -data $data
            return $returnData
        }
    }