function Submit-LMdata
    {
        [CmdletBinding()]
        Param (
            [string]
            $data,
            [Parameter(Mandatory=$true)]
            [string]
            $resourcePath
        )

        Begin
            {
                $httpVerb = "POST"
            }

        Process
            {
                [string]$epoch = [Math]::Round((New-TimeSpan -start (Get-Date -Date "1/1/1970") -end (Get-Date).ToUniversalTime()).TotalMilliseconds)

                #some requests do not require data in request vars
                if ($data) {
                    $requestVars = $httpVerb + $epoch + $data + $resourcePath
                }

                else { $requestVars = $httpVerb + $epoch + $resourcePath }

                $url = $Global:LogicMonitor.restEndpoint + $ResourcePath
                
                $hmac = New-Object System.Security.Cryptography.HMACSHA256
                $hmac.Key = [Text.Encoding]::UTF8.GetBytes($Global:LogicMonitor.accessKey)
                $signatureBytes = $hmac.ComputeHash([Text.Encoding]::UTF8.GetBytes($requestVars))
                $signatureHex = [System.BitConverter]::ToString($signatureBytes) -replace '-'
                $signature = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($signatureHex.ToLower()))

                $auth = 'LMv1 ' + $Global:LogicMonitor.accessId + ':' + $signature + ':' + $epoch
                $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
                $headers.Add("Authorization",$auth)
                $headers.Add("Content-Type",'application/json')

                try
                    {
                        #send data in body if data is necessary for request
                        if ($data) {
                            $response = Invoke-RestMethod -Uri $url -Method $httpVerb -Headers $headers -Body $data
                        }
                                
                        else { $response = Invoke-RestMethod -Uri $url -Method $httpVerb -Header $headers }
                    }

                    catch
                        {
                            write-host 'something went wrong'
                            write-host $Error
                        }

                return $response
            }


    }