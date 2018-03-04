    <#
            .SYNOPSIS
            Returns a list or specific alert
            .DESCRIPTION
            LogicMonitor documentation regarding alerts can be found at https://www.logicmonitor.com/support/alerts/
            .EXAMPLE
            Get-LMAlert -Id DS3
            .EXAMPLE
            Get-LMAlert
            .PARAMETER Id
            ID of the Alert
            .Outputs
            PSCustomObject
          #>
function Get-LMAlert {
        [CmdletBinding()]
         Param (
             [Parameter(Mandatory=$false)]
             [string]$Id
         )

    Begin
         {
            Confirm-LMPortalConnection
            $resource = 'Alerts'
            #$properties = @("id", "")
         }

    Process
        {  

            $resourcePath = Convert-LMResourcePath -resource $resource
            if ($Id) {
                $data = Get-LMData -resourcePath $resourcePath -Id $Id
                $responseData = Convert-LMResponseData -data $data
                #$returnData = Format-LMReturnData -data $responseData -properties $properties
                return $responseData
            }
            else {
                $data = Get-LMData -ResourcePath $resourcePath
                $responseData = Convert-LMResponseData -data $data
                #$returnData = Format-LMReturnData -data $responseData -properties $properties
                return $responseData
            }

        }

    }