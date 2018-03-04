function Login-LMportal
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