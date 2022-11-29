#############################################################
# This script runs a basic query using the parameters
# supplied below and downloads the restults to an 
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
    # The query JSON
    [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
    [string] $QueryJson,       
    # APS auth token.
    [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
    [string] $APSToken
)

#############################################################
# APS CLI module import
#############################################################
$modulePath = Join-Path $PSScriptRoot '..\src\APSCLI.psd1' -Resolve;
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
    Set-APSToken -Token $APSToken; 

    # create the output dir if it does not exist
    if (-not(Test-Path $outDir))
    {
        New-Item -Path $outDir -ItemType Directory | Out-Null;
    }

    Write-Verbose "Run query $QueryJson";

    # start a new query
    $response = New-BimPropertyIndexQuery -ProjectId $ProjectId -IndexId $IndexId -QueryJson $QueryJson;

    # poll the query for success
    while ($response.state -eq 'PROCESSING')
    {
        Write-Verbose "Query $($response.queryId) state $($response.state), retrying...";
        Start-Sleep -Seconds 5;        
        $response = Get-BimPropertyIndexQuery -ProjectId $ProjectId -IndexId $response.indexId -QueryId $response.queryId;
    }

    # serialize the query
    $queryPath = "$outDir\$($response.indexId).$($response.queryId).query.json";
    $response | ConvertTo-Json | Out-File -FilePath $queryPath -Encoding utf8 -Force | Out-Null;

    if ($response.state -eq 'FINISHED')
    {
        # download the retsults to file
        $resultsPath = "$outDir\$($response.indexId).$($response.queryId).results.json";
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
