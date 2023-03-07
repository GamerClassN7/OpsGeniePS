function Set-OGAuthToken{
    [cmdletbinding()]
    param (
        [string] $apiToken = $null
    )
    $script:OpsGenieInvokeHeaders["Authorization"] = ("GenieKey {0}" -f $apiToken)
}