function Send-LMdata
    {
        [CmdletBinding()]
        Param (
            [Parameter(Mandatory=$true)]
            [ValidateSet("GET", "POST")]
            [string]
            $httpVerb,
            [Parameter(Mandatory=$true)]
            [ValidateSet("SDT", "APIToken")]
            [string]
            $resource

        )

        DynamicParam
            {
                if ($httpVerb -eq "POST")
                    {
                        $attributes = new-object System.Management.Automation.ParameterAttribute
                        $attributes.ParameterSetName = "__AllParameterSets"
                        $attributes.Mandatory = $true
                        $attributeCollection = new-object -Type System.Collections.ObjectModel.Collection[System.Attribute]
                        $attributeCollection.Add($attributes)

                        $dynParam1 = new-object -Type System.Management.Automation.RuntimeDefinedParameter("data", [string], $attributeCollection)

                        $paramDictionary = new-object -Type System.Management.Automation.RuntimeDefinedParameterDictionary
                        $paramDictionary.Add("data", $dynParam1)
                        return $paramDictionary
                    }
            }

        Begin
            {
                $ResourceList = @{
                    "SDT" = "/sdt/sdts";
                    "APIToken" = "/setting/admins/apitokens";
                    "OpsNotes" = "/setting/opsnotes"
                }

                $ResourcePath = $ResourceList[$resource]
            }
        
        Process
            {
                
                $url = $Global:LogicMonitor.restEndpoint + $ResourcePath
                [string]$epoch = [Math]::Round((New-TimeSpan -start (Get-Date -Date "1/1/1970") -end (Get-Date).ToUniversalTime()).TotalMilliseconds)

                if ($httpVerb -eq 'GET')
                    {
                        $requestVars = $httpVerb + $epoch + $resourcePath

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
                    }

                else
                    {
                        $requestVars = $httpVerb + $epoch + $data + $resourcePath

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
                                $response = Invoke-RestMethod -Uri $url -Method $httpVerb -Header $headers -Body $data
                            }

                        catch
                            {
                                write-host 'something went wrong'
                                write-host $Error
                            }
                    }


                return $response
            }


    }