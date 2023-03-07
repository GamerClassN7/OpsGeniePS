function Get-OGRotations{
    [cmdletbinding()]
    param (
        [Nullable[String]] $ScheduleId = $null
    )
    Begin {
        $uri = "$script:OpsGenieBaseUri/schedules/{scheduleId}/rotations"
    }
    Process {
        if ($null -eq $ScheduleId){
            $ScheduleId = $script:OpsGenieScheduleId;
        }

        $tempUri = $uri -replace "{scheduleId}", $ScheduleId

        $response = Invoke-WebRequest -Uri $tempUri -Method GET -Headers $script:OpsGenieInvokeHeaders
        if ( $response.StatusCode -eq 200){
            return ($response | ConvertFrom-Json).data
        }
        return $false;
    }    
}