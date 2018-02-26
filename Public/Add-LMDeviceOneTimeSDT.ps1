function Add-LMDeviceOneTimeSDT
    {        
        [CmdletBinding()]
        Param (
            [Parameter(ParameterSetName="DeviceID", Mandatory=$true)]
            $DeviceID,
            [Parameter(ParameterSetName="DeviceDisplayName", Mandatory=$true)]
            $DeviceDisplayName,
            [parameter(Mandatory=$true, ParameterSetName="DeviceID")]
            [parameter(Mandatory=$true, ParameterSetName="DeviceDisplayName")]
            [DateTime]
            $StartDate,
            [parameter(Mandatory=$true, ParameterSetName="DeviceID")]
            [parameter(Mandatory=$true, ParameterSetName="DeviceDisplayName")]
            [DateTime]
            $EndDate
        )
        Confirm-LMPortalConnection
        $sdtType = '1'
        $type = 'DeviceSDT'
        $resource = 'SDT'

        [string]$startDateEpoch = [Math]::Round((New-TimeSpan -start (Get-Date -Date "1/1/1970") -end $StartDate).TotalMilliseconds)
        [string]$endDateEpoch = [Math]::Round((New-Timespan -start (get-date -date "1/1/1970") -end $EndDate).TotalMilliseconds)

        if ($DeviceID)
            {
                $data = '{"sdtType":' + $sdtType + ',"type":"' + $type + '","deviceId":' + $DeviceID + ',"startDateTime":' + $startDateEpoch + ',"endDateTime":' + $endDateEpoch + '}'
            }
        
        if ($DeviceDisplayName)
            {
                $data = '{"sdtType":' + $sdtType + ',"type":"' + $type + '","deviceDisplayName":"' + $DeviceDisplayName + '","startDateTime":' + $startDateEpoch + ',"endDateTime":' + $endDateEpoch + '}'
            }

        submit-LMdata -resource $resource -Data $data
    }