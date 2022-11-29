#############################################################
# This script creates a basic BIM property index using the
# parameters supplied below and downloads the fields to an 
# .\out\fields.json file, and the manifest to an
# .\out\manifest.json file.
#############################################################
param 
( 
    # The project containing the files to be indexed
    [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
    [guid] $ProjectId,  
    # The JSON index specification
    [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
    [string] $SpecificationJson,   
    # APS auth token.
    [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
    [string] $APSToken,
    # set to download all resources
    [Parameter(Mandatory=$false, ValueFromPipeline=$false)]
    [switch] $DownloadAll
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

    Write-Verbose "Create index $SpecificationJson";

    $response = New-BimPropertyIndex -ProjectId $ProjectId -SpecificationJson $SpecificationJson;

    $toDownload = $response.indexes;

    while($true)
    {
        $polling = 0;

        for ($i = 0; $i -lt $toDownload.Length; $i++) {
            if ($toDownload[$i].state -eq 'PROCESSING') {                
                Write-Verbose "Index $($toDownload[$i].indexId) state $($toDownload[$i].state), polling status...";
                $toDownload[$i] = Get-BimPropertyIndex -ProjectId $ProjectId -IndexId $toDownload[$i].indexId;
                $polling++;
            }
        }

        if ($polling -gt 0) {
            Write-Verbose 'Sleep 5 seconds...';
            Start-Sleep -Seconds 5;
        }
        else {
            break;
        }
    }

    # create the output dir if it does not exist
    if (-not(Test-Path $outDir))
    {
        New-Item -Path $outDir -ItemType Directory | Out-Null;
    }

    foreach ($index in $toDownload) 
    {
        # dump the index...
        $indexPath = "$outDir\$($index.indexId).json";
        $index | ConvertTo-Json | Out-File -FilePath $indexPath -Encoding utf8 -Force | Out-Null;

        if ($DownloadAll -and ($index.state -eq 'FINISHED'))
        {
            # download the manifest resource
            $manifestPath = "$outDir\$($index.indexId).manifest.json";
            Get-ResourceUrl -Url $index.manifestUrl -Path $manifestPath;

            # download the fields resource
            $fieldPath = "$outDir\$($index.indexId).fields.json";
            Get-ResourceUrl -Url $index.fieldsUrl -Path $fieldPath;

            # download the properties resource
            $propsPath = "$outDir\$($index.indexId).properties.json";
            Get-ResourceUrl -Url $index.propertiesUrl -Path $propsPath;

            if ($null -ne $index.queryId)
            {
                # download the retsults to file
                $resultsPath = "$outDir\$($index.indexId).$($index.queryId).results.json";
                Get-ResourceUrl -Url $index.queryResultsUrl -Path $resultsPath;
            }
        }
    }
}
catch {
    $_;
}
