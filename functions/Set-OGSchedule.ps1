function Set-OGSchedule{
    [cmdletbinding()]
    param (
        [string] $scheduleId = $null
    )
    $script:OpsGenieScheduleId = $scheduleId
}