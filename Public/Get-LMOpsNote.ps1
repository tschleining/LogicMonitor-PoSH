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
            .Outputs
            PSCustomObject
          #>
function Get-LMOpsNote {
        Param (
            [int]$ID
        )

        Confirm-LMPortalConnection
        $resource = 'OpsNotes'
        $resourcePath = Convert-LMResourcePath -resource $resource
        if ($Id) {
            $data = Get-LMData -resourcePath $resourcePath -Id $Id
            $responseData = Convert-LMResponseData -data $data
            return $responseData
        }
        else {
            $data = Get-LMData -ResourcePath $resourcePath
            $responseData = Convert-LMResponseData -data $data
            return $responseData
        }
}