function Add-LMServiceOneTimeSDT
    {        
        [CmdletBinding()]
        Param (
            [Parameter(ParameterSetName="ServiceID", Mandatory=$true)]
            $ServiceID,
            [Parameter(ParameterSetName="ServiceName", Mandatory=$true)]
            $ServiceName,
            [parameter(Mandatory=$true, ParameterSetName="ServiceID")]
            [parameter(Mandatory=$true, ParameterSetName="ServiceName")]
            [DateTime]
            $StartDate,
            [parameter(Mandatory=$true, ParameterSetName="ServiceID")]
            [parameter(Mandatory=$true, ParameterSetName="ServiceName")]
            [DateTime]
            $EndDate
        )
        Confirm-LMPortalConnection
        $sdtType = '1'
        $type = 'ServiceSDT'
        $resource = 'SDT'

        [string]$startDateEpoch = [Math]::Round((New-TimeSpan -start (Get-Date -Date "1/1/1970") -end $StartDate).TotalMilliseconds)
        [string]$endDateEpoch = [Math]::Round((New-Timespan -start (get-date -date "1/1/1970") -end $EndDate).TotalMilliseconds)

        $data = '{"sdtType":' + $sdtType + ',"type":"' + $type + '","deviceId":' + $DeviceID + ',"startDateTime":' + $startDateEpoch + ',"endDateTime":' + $endDateEpoch + '}'

        Submit-LMdata -resource $resource -Data $data
    }