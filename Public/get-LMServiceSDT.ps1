    <#
            .SYNOPSIS
            Returns a list or specific Service Scheduled Down Times
            .DESCRIPTION
            LogicMonitor documentation regarding Schedule Down Times can be found at https://www.logicmonitor.com/support/devices/devices-page-overview/scheduled-down-time-sdt-tab/
            .EXAMPLE
            Get-LMServiceSDT
            .EXAMPLE
            Get-LMServiceSDT -Id 10
            .PARAMETER Id
            ID of the Service Scheduled Down Time
            .Outputs
            PSCustomObject
          #>
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