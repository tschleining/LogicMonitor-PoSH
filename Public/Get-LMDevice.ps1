function Get-LMDevice {
        [CmdletBinding()]
         Param (
             [Parameter(Mandatory=$false)]
             [string]$Id,
             [Parameter(ParameterSetName="Name", Mandatory=$false)]
             [string]$Name
         )
        Confirm-LMPortalConnection
        $resource = 'Devices'
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