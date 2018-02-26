function Get-LMDevice {
        [CmdletBinding()]
         Param (
             [Parameter(ParameterSetName="ID", Mandatory=$false)]
             [string]$Id,
             [Parameter(ParameterSetName="Name", Mandatory=$false)]
             [string]$Name
         )
         Confirm-LMPortalConnection
        $resource = 'Devices'
        switch ($PSCmdlet.ParameterSetName)
        {
            ID
                {
                    Get-LMData -resource $resource -Id $Id
                }

            Name
                {
                    Get-LMData -resource $resource
                }
            Default
                {
                    Get-LMdata -resource $resource
                }
        }
    }