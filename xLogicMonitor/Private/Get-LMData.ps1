function Get-LMData {
        [CmdletBinding()]
        Param (
            [Parameter(ParameterSetName="Resource", Mandatory=$true)]
            $ResourcePath,
            [Parameter(ParameterSetName="Resource", Mandatory=$false)]
            [Parameter(ParameterSetName="Id", Mandatory=$false)]
            $Id,
            [Parameter(ParameterSetName="Resource", Mandatory=$false)]
            [Parameter(ParameterSetName="Id", Mandatory=$false)]
            $queryParams
        )

        Begin
        {
            $httpVerb = "GET"
        }
        Process
        {
             if ($Id) {
                 $FullResourcePath = $ResourcePath + '/' + $Id
             }
             else { $FullResourcePath = $ResourcePath}

            $url = $Global:LogicMonitor.restEndpoint + $FullResourcePath + $queryParams
            [string]$epoch = [Math]::Round((New-TimeSpan -start (Get-Date -Date "1/1/1970") -end (Get-Date).ToUniversalTime()).TotalMilliseconds)
            $requestVars = $httpVerb + $epoch + $FullResourcePath

            $hmac = New-Object System.Security.Cryptography.HMACSHA256
            $hmac.Key = [Text.Encoding]::UTF8.GetBytes($Global:LogicMonitor.accessKey)
            $signatureBytes = $hmac.ComputeHash([Text.Encoding]::UTF8.GetBytes($requestVars))
            $signatureHex = [System.BitConverter]::ToString($signatureBytes) -replace '-'
            $signature = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($signatureHex.ToLower()))

            $auth = 'LMv1 ' + $Global:LogicMonitor.accessId + ':' + $signature + ':' + $epoch
            $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
            $headers.Add("Authorization",$auth)
            $headers.Add("Content-Type",'application/json')

            #check for windows and ensure TLS1.2
            if ($ENV:OS -eq "Windows_NT") {
                [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            }
            $response = Invoke-RestMethod -Uri $url -Method $httpVerb -Header $headers
            if ($response.status -ne '200') {
                throw $response.errmsg
            }
            
            else {
                return $response
            }

        }
}