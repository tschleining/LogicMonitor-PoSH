function Add-LMDeviceRepeatingeSDT
    {
        [CmdletBinding()]
        Param (
            [Parameter(ParameterSetName="DeviceID", Mandatory=$true)]
            $DeviceID,
            [Parameter(ParameterSetName="DeviceDisplayName", Mandatory=$true)]
            $DeviceDisplayName,
            [Parameter(Mandatory=$true, ParameterSetName="DeviceID")]
            [Parameter(Mandatory=$true, ParameterSetName="DeviceDisplayName")]
            [ValidateSet("Weekly", "Monthly", "Daily")]
            [string]
            $RecurrenceType,
            [parameter(Mandatory=$true, ParameterSetName="DeviceID")]
            [parameter(Mandatory=$true, ParameterSetName="DeviceDisplayName")]
            [ValidateRange(0,23)]
            [int]
            $hour,
            [parameter(Mandatory=$true, ParameterSetName="DeviceID")]
            [parameter(Mandatory=$true, ParameterSetName="DeviceDisplayName")]
            [ValidateRange(0,59)]
            [int]
            $minute,
            [Parameter(Mandatory=$true, ParameterSetName="DeviceID")]
            [Parameter(Mandatory=$true, ParameterSetName="DeviceDisplayName")]
            [ValidateRange(0,23)]
            [int]
            $endHour,
            [Parameter(Mandatory=$true, ParameterSetName="DeviceID")]
            [Parameter(Mandatory=$true, ParameterSetName="DeviceDisplayName")]
            [ValidateRange(0,59)]
            [int]
            $endMinute
        )
        Confirm-LMPortalConnection
        DynamicParam
            {
                if ($RecurrenceType -eq "Weekly")
                    {
                        $arrSet = (
                            "Sunday",
                            "Monday",
                            "Tuesday",
                            "Wednesday",
                            "Thursday",
                            "Friday",
                            "Saturday"
                        )
                        $attributes = new-object System.Management.Automation.ParameterAttribute
                        $attributes.ParameterSetName = "__AllParameterSets"
                        $attributes.Mandatory = $true

                        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)

                        $attributeCollection = new-object -Type System.Collections.ObjectModel.Collection[System.Attribute]
                        $attributeCollection.Add($attributes)
                        $attributeCollection.Add($ValidateSetAttribute)

                        $dynParam1 = new-object -Type System.Management.Automation.RuntimeDefinedParameter('WeekDay', [string], $attributeCollection)

                        $paramDictionary = new-object -Type System.Management.Automation.RuntimeDefinedParameterDictionary
                        $paramDictionary.Add('WeekDay', $dynParam1)

                        return $paramDictionary
                    }

                if ($RecurrenceType -eq "Monthly")
                    {
                        $arrSet = (
                            0..31
                        )
                        $attributes = new-object System.Management.Automation.ParameterAttribute
                        $attributes.ParameterSetName = "__AllParameterSets"
                        $attributes.Mandatory = $true

                        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)

                        $attributeCollection = new-object -Type System.Collections.ObjectModel.Collection[System.Attribute]
                        $attributeCollection.Add($attributes)
                        $attributeCollection.Add($ValidateSetAttribute)

                        $dynParam1 = new-object -Type System.Management.Automation.RuntimeDefinedParameter('MonthDay', [string], $attributeCollection)

                        $paramDictionary = new-object -Type System.Management.Automation.RuntimeDefinedParameterDictionary
                        $paramDictionary.Add('MonthDay', $dynParam1)

                        return $paramDictionary
                    }
            }

            Begin
            {
                #list to allow conversion from text input to API values
                $sdtTypeList = @{
                    "Weekly" = "2";
                    "Monthly" = "3";
                    "Daily" = "4";
                }

                #list to allow conversion from text input to API values
                $weekDayList = @{
                    "Sunday" = "1";
                    "Monday" = "2";
                    "Tuesday" = "3";
                    "Wednesday" = "4";
                    "Thursday" = "5";
                    "Friday" = "6";
                    "Saturday" = "7";
                }

                $resource = 'SDT'
                $type = 'DeviceSDT'
                $sdtType = $sdtTypeList[$recurrenceType]
            }

            Process
            {
                
                #Depending on SDT Type, Monthly, Weekly, Daily, build data structure
                switch ($sdtType)
                {
                   2 {
                        $weekDayInt = $weekDayList[$PSBoundParameters['weekDay']]
                        $data = '{"sdtType":' + $sdtType + ',"type":"' + $type + '","deviceId":' + $DeviceID + ',"weekDay":' + $weekDayInt + ',"hour":' + $hour + ',"minute":' + $minute + ',"endHour":' + $endhour + ',"endMinute":' + $endminute + '}'
                     }

                   3 {
                        $data = '{"sdtType":' + $sdtType + ',"type":"' + $type + '","deviceId":' + $DeviceID + ',"monthDay":' + $PSBoundParameters['MonthDay'] + ',"hour":' + $hour + ',"minute":' + $minute + ',"endHour":' + $endhour + ',"endMinute":' + $endminute + '}'
                     }

                   4 {
                        $data = '{"sdtType":' + $sdtType + ',"type":"' + $type + '","deviceId":' + $DeviceID + ',"hour":' + $hour + ',"minute":' + $minute + ',"endHour":' + $endhour + ',"endMinute":' + $endminute + '}'
                     }
                }

                Submit-LMdata -resource $resource -Data $data
            }



    }