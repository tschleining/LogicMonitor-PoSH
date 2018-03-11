function Add-LMDeviceOneTimeSDT
    {        
        [CmdletBinding()]
        Param (
            [Parameter(ParameterSetName="DeviceID", Mandatory=$true)]
            [int]
            $deviceId,
            [Parameter(ParameterSetName="DeviceDisplayName", Mandatory=$true)]
            $DeviceDisplayName,
            [parameter(Mandatory=$true, ParameterSetName="DeviceID")]
            [parameter(Mandatory=$true, ParameterSetName="DeviceDisplayName")]
            [DateTime]
            $startDateTime,
            [parameter(Mandatory=$true, ParameterSetName="DeviceID")]
            [parameter(Mandatory=$true, ParameterSetName="DeviceDisplayName")]
            [DateTime]
            $endDateTime
        )
        Confirm-LMPortalConnection
        $resource = 'SDT'
        [string]$startDateEpoch = [Math]::Round((New-TimeSpan -start (Get-Date -Date "1/1/1970") -end $startDateTime).TotalMilliseconds)
        [string]$endDateEpoch = [Math]::Round((New-Timespan -start (get-date -date "1/1/1970") -end $endDateTime).TotalMilliseconds)
        #[Int64]$startDateEpoch = (get-date $startDateTime -UFormat %s).Replace((Get-Culture).NumberFormat.NumberDecimalSeparator, '')
        #[Int64]$endDateEpoch = (get-date $endDateTime -UFormat %s).Replace((Get-Culture).NumberFormat.NumberDecimalSeparator, '')

        #Add One time SDT options for endpoint
        $staticOptions = @{
            "sdtType" = 1;
            "type" = 'DeviceSDT'
        }
        
        #copy local function parameters to new variable
        $data = $PSBoundParameters

        #Add staticOptions to data object
        foreach ($h in $staticOptions.GetEnumerator()) {
            $data.Add($($h.Name), $($h.Value))
        }
        #Add Epoch time to data object
        $data["startDateTime"] = $startDateEpoch
        $data["endDateTime"] = $endDateEpoch
        $dataJson = ConvertTo-Json $data

        $ResourcePath = Convert-LMResourcePath -resource $resource
        Submit-LMData -resourcePath $ResourcePath -Data $dataJson httpVerb POST
        #submit-LMdata -resource $resource -Data $data
    }