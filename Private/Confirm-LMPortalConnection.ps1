function Confirm-LMPortalConnection {
        if ($Global:LogicMonitor) {
        }

        else {
                clear-host
                write-warning "No connection to LogicMonitor API.  Prior to running LM module comands use Login-LMPortal
                "
                Login-LMportal
             }
}