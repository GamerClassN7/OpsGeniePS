
$token = (Get-Content -Raw -Path .\tests\token.json | ConvertFrom-Json).token

https://rudimartinsen.com/2018/01/31/creating-a-powershell-module-as-an-api-wrapper/

$script:OpsGenieBaseUri = "https://api.eu.opsgenie.com/v2"
$script:OpsGenieInvokeHeaders = @{
    ContentType = "application/json"
} 

function Set-OGAuthToken{
    [cmdletbinding()]
    param (
        [string] $apiToken = $null
    )
    $script:OpsGenieInvokeHeaders["Authorization"] = ("GenieKey {0}" -f $apiToken)
}

function Get-OGOnCall{
    [cmdletbinding()]
    param (
        [Nullable[DateTime]] $Date = $null,
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [String]$ScheduleId
    )
    Begin {
        $uri = "$script:OpsGenieBaseUri/schedules/{scheduleId}/on-calls"
    }
    Process {
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

function Get-OGSchedules{
    [cmdletbinding()]
    param ()
    Begin {
        $uri = "$script:OpsGenieBaseUri/schedules/"
    }
    Process {
        $response = Invoke-WebRequest -Uri $uri -Method GET -Headers $script:OpsGenieInvokeHeaders
        if ( $response.StatusCode -eq 200){
            return ($response | ConvertFrom-Json).data
        }
        return $false;
    }    
}

function Get-OGRotations{
    [cmdletbinding()]
    param (
        [String]$ScheduleId
    )
    Begin {
        $uri = "$script:OpsGenieBaseUri/schedules/{scheduleId}/rotations"
    }
    Process {
        $tempUri = $uri -replace "{scheduleId}", $ScheduleId
        $tempUri
        $response = Invoke-WebRequest -Uri $tempUri -Method GET -Headers $script:OpsGenieInvokeHeaders
        if ( $response.StatusCode -eq 200){
            return ($response | ConvertFrom-Json).data
        }
        return $false;
    }    
}

Set-OGAuthToken -apiToken $token
Write-Host (Get-OGSchedules)
Write-Host (Get-OGOnCall -ScheduleId "33aa1b29-2ddd-455d-92a5-f41f55952900").onCallParticipants.name
Write-Host (Get-OGRotations -ScheduleId "33aa1b29-2ddd-455d-92a5-f41f55952900")