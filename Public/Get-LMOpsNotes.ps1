function Get-LMOpsNotes {
        Param (
            [int]$ID
        )

        Confirm-LMPortalConnection
        $response = send-LMdata -httpVerb GET -resource 'OpsNotes' 
}