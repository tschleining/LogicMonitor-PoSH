function Get-LMOpsNotes {
        Param (
            [int]$ID
        )

        Confirm-LMPortalConnection
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