function New-BimPropertyDiff {
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

    $url = "$ForgeApiBaseAddress/construction/index$NucleusQaSuffix/v2/projects/$ProjectId/diffs:batch-status";

    Write-Verbose "POST $url";

    return Invoke-RestMethod -Uri $url `
                             -Method Post `
                             -Body $SpecificationJson `
                             -Headers $headers `
                             -Authentication OAuth `
                             -Token $ForgeOAuthToken;
}

function Get-BimPropertyDiff {
    param (        
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [guid] $ProjectId,
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [string] $DiffId       
    )    

    $headers = @{
        'Accept' = '*/*'        
        'Accept-Encoding' = 'gzip, deflate, br'
    };

    $url = "$ForgeApiBaseAddress/construction/index$NucleusQaSuffix/v2/projects/$ProjectId/diffs/$DiffId";

    Write-Verbose "GET $url";

    return Invoke-RestMethod -Uri $url `
                             -Method Get `
                             -Headers $headers `
                             -Authentication OAuth `
                             -Token $ForgeOAuthToken;
}

function New-BimPropertyDiffQuery {
    param (        
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [guid] $ProjectId,
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [string] $DiffId,
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string] $QueryJson       
    )

    $headers = @{
        'Content-Type' = 'application/json'
        'Accept' = '*/*'        
        'Accept-Encoding' = 'gzip, deflate, br'
    };

    $url = "$ForgeApiBaseAddress/construction/index$NucleusQaSuffix/v2/projects/$ProjectId/diffs/$DiffId/queries";

    Write-Verbose "POST $url";

    return Invoke-RestMethod -Uri $url `
                             -Method Post `
                             -Body $QueryJson `
                             -Headers $headers `
                             -Authentication OAuth `
                             -Token $ForgeOAuthToken;
}

function Get-BimPropertyDiffQuery {
    param (        
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [guid] $ProjectId,
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [string] $DiffId,
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [string] $QueryId       
    )    

    $headers = @{
        'Accept' = '*/*'        
        'Accept-Encoding' = 'gzip, deflate, br'
    };

    $url = "$ForgeApiBaseAddress/construction/index$NucleusQaSuffix/v2/projects/$ProjectId/diffs/$DiffId/queries/$QueryId";

    Write-Verbose "GET $url";

    return Invoke-RestMethod -Uri $url `
                             -Method Get `
                             -Headers $headers `
                             -Authentication OAuth `
                             -Token $ForgeOAuthToken;
}