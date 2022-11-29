function New-BimPropertyIndex {
    param (        
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [guid] $ProjectId,
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string] $SpecificationJson
    )
    
    $headers = @{
        'Content-Type' = 'application/json'
        'Accept' = '*/*'        
        'Accept-Encoding' = 'gzip, deflate, br'
    };

    $url = "$ForgeApiBaseAddress/construction/index$NucleusQaSuffix/v2/projects/$ProjectId/indexes:batch-status";

    Write-Verbose "POST $url";

    return Invoke-RestMethod -Uri $url `
                             -Method Post `
                             -Body $SpecificationJson `
                             -Headers $headers `
                             -Authentication OAuth `
                             -Token $ForgeOAuthToken;
}

function Get-BimPropertyIndex {
    param (        
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [guid] $ProjectId,
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [string] $IndexId      
    )    

    $headers = @{
        'Accept' = '*/*'        
        'Accept-Encoding' = 'gzip, deflate, br'
    };

    $url = "$ForgeApiBaseAddress/construction/index$NucleusQaSuffix/v2/projects/$ProjectId/indexes/$IndexId";

    Write-Verbose "GET $url";

    return Invoke-RestMethod -Uri $url `
                             -Method Get `
                             -Headers $headers `
                             -Authentication OAuth `
                             -Token $ForgeOAuthToken;
}

function New-BimPropertyIndexQuery {
    param (        
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [guid] $ProjectId,
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [string] $IndexId,
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string] $QueryJson       
    )

    $headers = @{
        'Content-Type' = 'application/json'
        'Accept' = '*/*'        
        'Accept-Encoding' = 'gzip, deflate, br'
    };

    $url = "$ForgeApiBaseAddress/construction/index$NucleusQaSuffix/v2/projects/$ProjectId/indexes/$IndexId/queries";

    Write-Verbose "POST $url";

    return Invoke-RestMethod -Uri $url `
                             -Method Post `
                             -Body $QueryJson `
                             -Headers $headers `
                             -Authentication OAuth `
                             -Token $ForgeOAuthToken;
}

function Get-BimPropertyIndexQuery {
    param (        
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [guid] $ProjectId,
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [string] $IndexId,
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [string] $QueryId      
    )    

    $headers = @{
        'Accept' = '*/*'        
        'Accept-Encoding' = 'gzip, deflate, br'
    };

    $url = "$ForgeApiBaseAddress/construction/index$NucleusQaSuffix/v2/projects/$ProjectId/indexes/$IndexId/queries/$QueryId";

    Write-Verbose "GET $url";

    return Invoke-RestMethod -Uri $url `
                             -Method Get `
                             -Headers $headers `
                             -Authentication OAuth `
                             -Token $ForgeOAuthToken;
}