$forgeCli  = Get-ChildItem -Path $PSScriptRoot\ForgeCLI\*.ps1;

foreach ($import in $forgeCli)
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
New-Variable -Name ForgeApiBaseAddress -Value 'https://developer.api.autodesk.com' -Scope Script;
New-Variable -Name NucleusQaSuffix -Value '' -Scope Script;
New-Variable -Name ForgeOAuthToken -Value $null -Scope Script;