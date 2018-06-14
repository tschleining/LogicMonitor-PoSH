# LogicMonitorPOSH
An unofficial PowerShell module for managing a LogicMonitor instance

# Current Cmdlets
* Add-LMAccount
* Add-LMAlertNote
* Add-LMCollector
* Add-LMCollectorGroup
* Add-LMDatasourceInstance
* Add-LMDevice
* Add-LMDeviceOneTimeSDT
* Add-LMDeviceRepeatingSDT
* Add-LMRole
* Add-LMService
* Add-LMServiceOneTimeSDT
* Confirm-LMAlert
* Confirm-LMCollectorDown
* Get-LMAlert
* Get-LMAuditLog
* Get-LMCollector
* Get-LMCollectorGroup
* Get-LMCollectorInstaller
* Get-LMDevice
* Get-LMDeviceGroup
* Get-LMDeviceGroupResources
* Get-LMDeviceProperties
* Get-LMOpsNote
* Get-LMRole
* Get-LMService
* Get-LMServiceAlert
* Get-LMServiceSDT
* Get-LMSMCheckPoint
* Get-LMUnmonitoredDevice
* Get-LMUser
* Remove-LMCollector
* Remove-LMCollectorGroup
* Update-LMCollector
* Update-LMCollectorGroup

# Installing the Module
This module can now, and should, be installed using 'install-module xLogicMonitor' which will download the module from the [PowerShell Gallery](https://www.powershellgallery.com/).
Next run 'Import-Module xLogicMonitor'.  To find available commands run 'Get-Command -Module xLogicMonitor'.


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
