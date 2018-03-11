function Add-LMQueryParams {
        [CmdletBinding()]
        Param (
                [Parameter(Mandatory=$false)]
                [ValidatePattern("((\w*|\w*.\w*)(<|>|<:|>:|!|!:|:|~|!~)(\w*.\w*|\w*),?)|^$")]
                [string]$filters,
                [Parameter(Mandatory=$false)]
                [string]$size
        )
        
        if ($size) {
                $returnSize = '?size=' + $size
        }
        if ($filters) {
                $returnFilters = '&filter=' + $filters
        }

        $return = $returnSize + $returnFilters
        return $return
}