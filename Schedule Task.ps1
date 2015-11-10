#Schedule Valid values are: MINUTE, HOURLY, DAILY, WEEKLY, MONTHLY, ONCE, ONLOGON, ONIDLE, and ONEVENT.
#For Task Scheduler 2.0 tasks, "NT AUTHORITY\LOCALSERVICE", and "NT AUTHORITY\NETWORKSERVICE" are also valid values.


#Minimum 2008 (/RL HIGHEST niet ondersteund in 2003)


Function Create-ScheduledTask
{
    param(
       [string]$ComputerName,
       [string]$RunAsUser = "System",
       [string]$TaskName,
       [string]$TaskRun = "'PowerShell.exe -NoLogo -File C:\Configure-DC1.ps1'",
       [string]$Schedule = "ONLOGON"
            )

   $Command = "schtasks.exe /create /s $ComputerName /ru $RunAsUser /tn $TaskName /tr $TaskRun /sc $Schedule /F /RL HIGHEST"

   Invoke-Expression $Command
   Write-host $LASTEXITCODE
   
}

Function Query-ScheduledTask
{
[string]$ComputerName,
[string]$TaskName

schtasks.exe /s $ComputerName /fo csv /v /s /TN $TaskName | convertfrom-csv
}

Function Run-ScheduledTask
{
[string]$ComputerName,
[string]$TaskName
schtasks.exe /run /s $ComputerName /TN $TaskName
}


