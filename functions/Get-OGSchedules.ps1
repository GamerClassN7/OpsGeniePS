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