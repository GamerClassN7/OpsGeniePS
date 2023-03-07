function Get-OGOnCall{
    [cmdletbinding()]
    param (
        [Nullable[DateTime]] $Date = $null,
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Nullable[String]] $ScheduleId = $null
    )
    Begin {
        $uri = "$script:OpsGenieBaseUri/schedules/{scheduleId}/on-calls"
    }
    Process {
        if ($null -eq $ScheduleId){
            $ScheduleId = $script:OpsGenieScheduleId;
        }

        $tempUri = $uri -replace "{scheduleId}", $ScheduleId

        if ($null -ne $Date) {
            $tempUri += ("?date={0}" -f $Date.toString('yyyy-MM-ddTHH:mm:ssZ'))
        }
    
        $response = Invoke-WebRequest -Uri $tempUri -Method GET -Headers $script:OpsGenieInvokeHeaders
        if ( $response.StatusCode -eq 200){
            return ($response | ConvertFrom-Json).data
        }
        return $false;
    }    
}