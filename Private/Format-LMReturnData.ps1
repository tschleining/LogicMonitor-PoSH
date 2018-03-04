function Format-LMReturnData {
        [CmdletBinding()]
        Param (
            [Parameter(Mandatory=$true)]
            [array]$properties,
            [Parameter(Mandatory=$true)]
            [PSCustomObject]$data
        )

        $returnData = $data | Select-Object -Property $properties
        return $returnData
}