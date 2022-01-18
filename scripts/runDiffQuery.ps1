#############################################################
# This script creates a runs a diff query using the
# parameters supplied below and downloads the restults to an 
# .\out\restults.json file.
#############################################################
param 
( 
    # The project containing the index
    [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
    [guid] $ProjectId,  
    # The index to run the query against
    [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
    [string] $IndexId,
    # The JSON query specification
    [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
    [string] $QueryJson,       
    # Forge auth token.
    [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
    [string] $ForgeToken
)

#############################################################
# Forge CLI module import
#############################################################
$modulePath = Join-Path $PSScriptRoot '..\src\ForgeCLI.psd1' -Resolve;
Import-Module $modulePath;

#############################################################
# Output variables
#############################################################

$outDir = "$PSScriptRoot\out";

#############################################################
# Main
#############################################################

try {
    # create the token
    Set-ForgeToken -Token $ForgeToken;    

    # create the output dir if it does not exist
    if (-not(Test-Path $outDir))
    {
        New-Item -Path $outDir -ItemType Directory | Out-Null;
    }

    Write-Verbose "Run query $QueryJson";

    # start a new query
    $response = New-BimPropertyDiffQuery -ProjectId $ProjectId -DiffId $IndexId -QueryJson $QueryJson;

    # poll the query for success
    while ($response.state -eq 'PROCESSING')
    {
        Write-Verbose "Query $($response.diffId) state $($response.state), retrying...";
        Start-Sleep -Seconds 5;        
        $response = Get-BimPropertyDiffQuery -ProjectId $ProjectId -DiffId $response.diffId -QueryId $response.queryId;
    }

    # serialize the query
    $queryPath = "$outDir\$($response.diffId).$($response.queryId).query.json";
    $response | ConvertTo-Json | Out-File -FilePath $queryPath -Encoding utf8 -Force | Out-Null;

    if ($response.state -eq 'FINISHED')
    {
        # download the retsults to file
        $resultsPath = "$outDir\$($response.diffId).$($response.queryId).results.json";
        Get-ResourceUrl -Url $response.queryResultsUrl -Path $resultsPath;        
    }
    else
    {
        throw "Query status $($response.state) != FINISHED, check $queryPath for more informaiton";
    }
}
catch {
    $_;
}

