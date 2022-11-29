function Get-APSEvironment
{
    return $APSApiBaseAddress;
}

function Set-APSEvironment {
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [ValidateSet('ProductionUs','StagingUs','Default')]
        [string] $Environment
    )

    switch ($Environment) {
        ProductionUs {
            Set-Variable -Name APSApiBaseAddress -Value 'https://developer.api.autodesk.com' -Scope Script;
            Set-Variable -Name NucleusQaSuffix -Value '' -Scope Script;
        }
        StagingUs {
            Set-Variable -Name APSApiBaseAddress -Value 'https://developer-stg.api.autodesk.com' -Scope Script;
            Set-Variable -Name NucleusQaSuffix -Value '-dev' -Scope Script;
        }
        default {
            Set-Variable -Name APSApiBaseAddress -Value 'https://developer.api.autodesk.com' -Scope Script;
            Set-Variable -Name NucleusQaSuffix -Value '' -Scope Script;
        }
    }
}

function Set-APSToken
{
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [string] $Token
    )

    $nt = ConvertTo-SecureString -String $Token -AsPlainText -Force;

    Set-Variable -Name APSOAuthToken -Value $nt -Scope Script;
}

function Get-ResourceUrl {
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [string] $Url,
        [Parameter(Mandatory=$false, ValueFromPipeline=$false)]
        [System.IO.FileInfo] $Path
    )
    
    $headers = @{        
        'Accept' = '*/*'
        'Accept-Encoding' = 'gzip, deflate, br'
    };

    if ($null -ne $Path)
    {
        Invoke-RestMethod `
            -Uri $Url `
            -Method Get `
            -Headers $headers `
            -Authentication OAuth `
            -Token $APSOAuthToken `
            -OutFile $Path;
    }
    else
    {
        return Invoke-RestMethod `
            -Uri $Url `
            -Method Get `
            -Headers $headers `
            -Authentication OAuth `
            -Token $APSOAuthToken;
    }    
}