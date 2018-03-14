# LogicMonitorPOSH
An unofficial PowerShell module for managing a LogicMonitor instance

# Current Cmdlets
* Add-LMAccount
* Add-LMCollector
* Add-LMCollectorGroup
* Add-LMDatasourceInstance
* Add-LMDevice
* Add-LMDeviceOneTimeSDT
* Add-LMAccount
* Add-LMCollector
* Add-LMCollectorGroup
* Add-LMDatasourceInstance
* Add-LMDevice
* Add-LMDeviceOneTimeSDT
* Add-LMDeviceRepeatingSDT
* Add-LMServiceOneTimeSDT
* Confirm-LMAlert
* Get-LMAlert
* Get-LMAuditLog
* Get-LMCollector
* Get-LMCollectorGroup
* Get-LMDevice
* Get-LMDeviceGroup
* Get-LMDeviceProperties
* Get-LMOpsNote
* Get-LMRole
* Get-LMService
* Get-LMServiceSDT
* Get-LMSMCheckPoint
* Get-LMUnmonitoredDevice
* Get-LMUser
* Remove-LMCollector
* Remove-LMCollectorGroup
* Update-LMCollector
* Update-LMCollectorGroup
* Add-LMDeviceRepeatingSDT
* Add-LMServiceOneTimeSDT
* Confirm-LMAlert
* Get-LMAlert
* Get-LMAuditLog
* Get-LMCollector
* Get-LMCollectorGroup
* Get-LMDevice
* Get-LMDeviceGroup
* Get-LMDeviceProperties
* Get-LMOpsNote
* Get-LMRole
* Get-LMService
* Get-LMServiceSDT
* Get-LMSMCheckPoint
* Get-LMUnmonitoredDevice
* Get-LMUser
* Remove-LMCollector
* Remove-LMCollectorGroup
* Update-LMCollector
* Update-LMCollectorGroup

# Installing the Module
There are a couple of locations the module can be installed.

* **Current User** %UserProfile%\Documents\WindowsPowerShell\Modules
* **Machine Wide** %ProgramFiles%\WindowsPowerShell\Modules

To install the module, click the 'Clone or Download' and then click 'Download ZIP', buttons on this page.  Open the ZIP file and copy the xLogicMonitor folder into one of the above locations.  Next run 'Import-Module xLogicMonitor'.  To find available commands run 'Get-Command -Module xLogicMonitor'.


# Obtaining API Keys
When using this module, you must use Add-LMAccount, which requires three pieces of information.

* accessID
* accessKey
* accountName

Instructions on obtaining an AccessID and AccessKey can be found [here](https://www.logicmonitor.com/support/settings/users-and-roles/api-tokens/).  Your account name will be the ACCOUNTNAME portion of the url you use to log in to LogicMonitor.

Ex: https://ACCOUNTNAME.logicmonitor.com/


# Cmdlet Filters
Filters the response according to the operator and value specified. Note that you can use * to match on more than one character. Multiple filters can be separated by a comma. Operators include:

* Greater than or equals: >:
* Less than or equals: <:
* Greater than: >
* Less than: <
* Does not equal: !:
* Equals: :
* Includes: ~
* Does not include: !~

Some examples are:

* 'type:dataSourceAlert,acked:False'
* 'ip:192.168.1.25'
* 'collectorSize:medium,numberOfHosts>50'
* ''description~readonly'
* 'type:webservice,name~app*,alertStatus!:none'