$apsCli  = Get-ChildItem -Path $PSScriptRoot\APSCLI\*.ps1;

foreach ($import in $apsCli)
{
    try
    {
        . $import.FullName;
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($import.FullName): $_";
    }
}

# Script variables
New-Variable -Name APSApiBaseAddress -Value 'https://developer.api.autodesk.com' -Scope Script;
New-Variable -Name NucleusQaSuffix -Value '' -Scope Script;
New-Variable -Name APSOAuthToken -Value $null -Scope Script;