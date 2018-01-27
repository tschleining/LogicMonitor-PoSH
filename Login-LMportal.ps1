function Login-LMportal
    {
        Param (
            [Parameter(Mandatory=$true)]
            [string]$accessID,
            [Parameter(Mandatory=$true)]
            [string]$accessKey,
            [Parameter(Mandatory=$true)]
            [string]$company
        )

        $baseURL = "https://" + $company + ".logicmonitor.com/santaba/rest"
        $LMglobal = @{}
        $LMglobal.add('restEndpoint', $baseURL)
        $LMglobal.add('accessID', $accessID)
        $LMglobal.add('accessKey', $accessKey)
        $Global:LogicMonitor = $LMglobal

        $response = Get-LMdata -resource 'APIToken'

        $status = $response.status
        $body = $response.data

        if ($status -eq '200' -and $body.items.accessid -eq $accessID)
            {
                        write-host "Successful connection to LogicMonitor API established."
            }

        else
            {
                $Global:LogicMonitor = $null
                throw "There was a problem logging in to LogicMonitor.  Please verify your information."
            }



    }