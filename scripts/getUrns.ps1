#############################################################
# This script gets URNs of some model of specific folder using Data Management API of APS.
# It only extracts first page of the folder. The response data will be output to
# .\out\folder-contents.json file
#############################################################
param 
( 
    # The project containing the files to be indexed
    [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
    [string] $ProjectId,
    # The folder containing the files to be indexed
    [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
    [string] $FolderUrn,
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

    #Data Management API requires project id with 'b.'
    $response = Get-APSFolderContents -ProjectId $ProjectId -FolderUrn $FolderUrn;
    
    # create the output dir if it does not exist
    if (-not(Test-Path $outDir))
    {
        New-Item -Path $outDir -ItemType Directory | Out-Null;
    }    
    
    if ($null -ne $response) {
        $response | ConvertTo-Json -depth 10 | Out-File "$outDir\folder-contents.json";
    } else {
        $_;
    }
}
catch {
    $_;
}
