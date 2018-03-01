function Get-LMData {
        [CmdletBinding()]
        Param (
            [Parameter(ParameterSetName="Resource", Mandatory=$true)]
            $ResourcePath,
            [Parameter(ParameterSetName="Resource", Mandatory=$false)]
            [Parameter(ParameterSetName="Id", Mandatory=$false)]
            $Id
        )

        Begin
        {
            $httpVerb = "GET"
            #$ResourcePath = Convert-LMResourcePath -resource $resource

            If ($data) {
                $requestVars = $httpVerb + $epoch + $data + $ResourcePath
            }
            Else { $requestVars = $httpVerb + $epoch + $ResourcePath }
        }
        Process
        {
            # if ($Id) {
            #     $FullResourcePath = $ResourcePath + '/' + $Id
            # }
            # else { $FullResourcePath = $ResourcePath}

            $url = $Global:LogicMonitor.restEndpoint + $ResourcePath
            [string]$epoch = [Math]::Round((New-TimeSpan -start (Get-Date -Date "1/1/1970") -end (Get-Date).ToUniversalTime()).TotalMilliseconds)
            $requestVars = $httpVerb + $epoch + $ResourcePath

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
                                    $response = Invoke-RestMethod -Uri $url -Method $httpVerb -Header $headers
                                }

                            catch
                                {
                                    write-host 'something went wrong'
                                    write-host $Error
                                }

            return $response
        }
}