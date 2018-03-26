<#
.SYNOPSIS
    Download LogicMonitor Collector Installer file
.DESCRIPTION
    When Provided with an ID of a collector, this Cmdlet will download an installer file for Windows or Linux for 32 or 64bit systems.
.PARAMETER Id
    ID of the Collector
.PARAMETER collectorVersion
    The version of the installer you'd like to download. This defaults to the latest GD Collector, unless useEA is true
.PARAMETER collectorSize
    The size of the Collector you'd like to install. Options are nano, small (requires 2GB memory), medium (requires 4GB memory), large (requires 8GB memory). Requires collector version 22.180 or higher. Defaults to small.
.PARAMETER useEA
    If true, the latest EA Collector version will be used. Defaults to false
.PARAMETER platform
    Platform of the machine the LogicMonitor collector will be installed on.  Options are 'Win' or 'Linux'
.PARAMETER architecture
    Architecture of the machine the LogicMonitor collector will be installed on.  Options are '32' or '64'
.EXAMPLE
    Get-LMCollectorInstaller -Id 100 -collectorSize 'Medium' -Platform 'Win' -Architecture '64' -filePath 'C:\LogicMonitor\'
.EXAMPLE
    Get-LMCollectorInstaller -Id 100 -Platform 'Win' -Architecture '64' -filePath 'C:\LogicMonitor\'
#>
function Get-LMCollectorInstaller {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $Id,
        [Parameter(Mandatory=$false)]
        [string]
        $collectorVersion,
        [Parameter(Mandatory=$false)]
        [ValidateSet("nano", "small", "large")]
        [string]
        $collectorSize,
        [Parameter(Mandatory=$false)]
        [bool]
        $useEA,
        [Parameter(Mandatory=$true)]
        [ValidateSet("Win", "Linux")]
        $Platform,
        [Parameter(Mandatory=$true)]
        [ValidateSet("32", "64")]
        $Architecture,
        [Parameter(Mandatory=$true)]
        [string]
        $filePath
    )
    
    begin {
        Confirm-LMPortalConnection
        if ($platform -eq $linux) {
            $fileName = 'LogicMonitorCollector.bin'
        }
        else { $fileName = 'LogicMonitorCollector.exe' }
        
        $httpVerb = 'GET'
        $resource = 'CollectorInstallers'
        $platArch = $Platform + $Architecture


        if ($collectorSize) {
            $collectorSizeParam = '?collectorSize=' + $collectorSize
        }
        if ($collectorVersion) {
                $collectorVersionParam = '&collectorVersion=' + $CollectorVersion
        }
        if ($useEA) {
            $useEAParam = '&useEA=' + $useEA
        }

        $queryParams = $collectorSizeParam + $collectorVersionParam + $useEAParam
    }
    
    process {
        $resourcePath = Convert-LMResourcePath -resource $resource -Id $Id
        $resourcePathFull = $resourcePath + $platArch
        #duplicate code from get-lmdata.  May need refactoring.
        $url = $Global:LogicMonitor.restEndpoint + $resourcePathFull + $queryParams
        [string]$epoch = [Math]::Round((New-TimeSpan -start (Get-Date -Date "1/1/1970") -end (Get-Date).ToUniversalTime()).TotalMilliseconds)
        $requestVars = $httpVerb + $epoch + $resourcePathFull

        $hmac = New-Object System.Security.Cryptography.HMACSHA256
        $hmac.Key = [Text.Encoding]::UTF8.GetBytes($Global:LogicMonitor.accessKey)
        $signatureBytes = $hmac.ComputeHash([Text.Encoding]::UTF8.GetBytes($requestVars))
        $signatureHex = [System.BitConverter]::ToString($signatureBytes) -replace '-'
        $signature = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($signatureHex.ToLower()))

        $auth = 'LMv1 ' + $Global:LogicMonitor.accessId + ':' + $signature + ':' + $epoch
        $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
        $headers.Add("Authorization",$auth)
        $headers.Add("Content-Type",'application/json')
        Invoke-RestMethod -Uri $url -Method $httpVerb -Header $headers -OutFile ($filePath + $fileName)
    }
    
    end {
    }
}