# OpsGeniePS


# Usage:
```powershell
Set-OGAuthToken -apiToken $token


$scheduleId = (Get-OGSchedules)[0].id
Set-OGSchedule -scheduleId $scheduleId

(Get-OGOnCall).onCallParticipants.name
Get-OGRotations
```

## Get List of Schedules 
```powershell
    Set-OGAuthToken -apiToken 'TOKEN'
    Get-OGSchedules
```

## Thank you for helping :)
[PS Script to publish Nuget Package by PureKrome](https://duckduckgo.com).

<https://gist.github.com/PureKrome/90a1587ea2b6c4f51269>
