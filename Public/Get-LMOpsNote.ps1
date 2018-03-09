    <#
            .SYNOPSIS
            Returns a list or specific Ops Note
            .DESCRIPTION
            LogicMonitor documentation regarding Ops Notes can be found at https://www.logicmonitor.com/support/devices/devices-page-overview/using-ops-notes/
            .EXAMPLE
            Get-LMOpsNote
            .EXAMPLE
            Get-LMOpsNote -Id 10
            .PARAMETER Id
            ID of the Ops Note
            .PARAMETER returnSize
            Maximum amount of returned objects.  Default is 100.
            .PARAMETER filters
            Filters responses the API will return.  Useful for reducing API response size and time.
            .Outputs
            PSCustomObject
          #>
function Get-LMOpsNote {
        [CmdletBinding(DefaultParameterSetName="All")]
        Param (
            [Parameter(ParameterSetName="Id", Mandatory=$false)]
            [string]$Id,
            [Parameter(ParameterSetName="filters", Mandatory=$false)]
            [string]$filters,
            [Parameter(ParameterSetName="filters", Mandatory=$false)]
            [int]$returnSize=100
        )

        begin 
        {
            Confirm-LMPortalConnection
            $resource = 'OpsNotes'
            $resourcePath = Convert-LMResourcePath -resource $resource
            $queryParams = Add-LMQueryParams -size $returnSize -filters $filters
        }

        process 
        {
            if ($Id) {
                $data = Get-LMData -resourcePath $resourcePath -Id $Id
                $responseData = Convert-LMResponseData -data $data
                return $responseData
            }
            else {
                $data = Get-LMData -ResourcePath $resourcePath -queryParams $queryParams
                $responseData = Convert-LMResponseData -data $data
                return $responseData
            }
        }
}