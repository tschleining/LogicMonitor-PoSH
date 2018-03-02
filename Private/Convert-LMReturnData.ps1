function Convert-LMReturnData {
        [CmdletBinding()]
        Param (
            [Parameter(Mandatory=$true)]
            [PSCustomObject]$data
        )
        if ($data.data.items) {
            return $data.data.items
        }
        else { return $data.data }
}