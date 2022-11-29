#############################################################
# This script creates a basic BIM property diff index using the
# parameters supplied below and downloads the fields to an 
# .\out\fields.json file, and the manifest to an
# .\out\manifest.json file.
#############################################################
param 
( 
    # The project containing the files to be indexed
    [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
    [guid] $ProjectId,  
    # The the JSON specificaiton for the index
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

    $response = New-BimPropertyDiff -ProjectId $ProjectId -SpecificationJson $SpecificationJson;

    $toDownload = $response.diffs;

    while($true)
    {
        $polling = 0;

        for ($i = 0; $i -lt $toDownload.Length; $i++) {
            if ($toDownload[$i].state -eq 'PROCESSING') {                
                Write-Verbose "Index $($toDownload[$i].diffId) state $($toDownload[$i].state), polling status...";
                $toDownload[$i] = Get-BimPropertyDiff -ProjectId $ProjectId -DiffId $toDownload[$i].diffId;
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

    foreach ($diff  in $toDownload) 
    {
        # dump the diff...
        $diffPath = "$outDir\$($diff.diffId).json";
        $diff | ConvertTo-Json | Out-File -FilePath $diffPath -Encoding utf8 -Force | Out-Null;

        if ($DownloadAll -and ($diff.state -eq 'FINISHED')) 
        {
            # download the manifest resource
            $manifestPath = "$outDir\$($diff.diffId).manifest.json";
            Get-ResourceUrl -Url $diff.manifestUrl -Path $manifestPath;

            # download the fields resource
            $fieldPath = "$outDir\$($diff.diffId).fields.json";
            Get-ResourceUrl -Url $diff.fieldsUrl -Path $fieldPath;

            # download the properties resource
            $propsPath = "$outDir\$($diff.diffId).properties.json";
            Get-ResourceUrl -Url $diff.propertiesUrl -Path $propsPath;

            if ($null -ne $diff.queryId)
            {
                # download the retsults to file
                $resultsPath = "$outDir\$($diff.diffId).$($diff.queryId).results.json";
                Get-ResourceUrl -Url $diff.queryResultsUrl -Path $resultsPath;
            }
        }
    }
}
catch {
    $_;
}

