    <#
            .SYNOPSIS
            Authenticates you to a LogicMonitor instance.
            .DESCRIPTION
            An API token MUST be obtained from the LogicMonitor account you're attempting to use this module against.
            .EXAMPLE
            Login-LMPortal -accessID 12345aBcDeFg -accessKey ju203fi209ru02hr293efiw= -accountName INSTANCE
            .PARAMETER accessID
            Instructions on obtaining an Access ID and Access Key can be found here https://www.logicmonitor.com/support/settings/users-and-roles/api-tokens/.
            .PARAMETER accessKey
            Instructions on obtaining an Access ID and Access Key can be found here https://www.logicmonitor.com/support/settings/users-and-roles/api-tokens/.
            .PARAMETER accountName
            The account name will be the hostname of your LogicMonitor instance.  For example https://INSTANCE.logicmonitor.com 
          #>
function Add-LMAccount
    {
        Param (
            [Parameter(Mandatory=$true)]
            [string]$accessID,
            [Parameter(Mandatory=$true)]
            [string]$accessKey,
            [Parameter(Mandatory=$true)]
            [string]$accountName
        )

        $baseURL = "https://" + $accountName + ".logicmonitor.com/santaba/rest"
        $LMglobal = @{}
        $LMglobal.add('restEndpoint', $baseURL)
        $LMglobal.add('accessID', $accessID)
        $LMglobal.add('accessKey', $accessKey)
        $Global:LogicMonitor = $LMglobal

        $resourcePath = Convert-LMResourcePath  -resource 'APIToken'
        $response = Get-LMdata -resourcePath $resourcePath

        $status = $response.status
        $body = $response.data

        if ($status -eq '200' -and $body.items.accessid -eq $accessID)
            {
                        write-host "Successful connection to LogicMonitor API established."
            }

        else
            {
                $Global:LogicMonitor = $null
                Write-Error "There was a problem logging in to LogicMonitor.  Please verify your information." -Exception $response.errmsg -Category AuthenticationError
            }



    }