function Get-AdminAccounts {
 
    $headers = @{
        'Accept' = '*/*'        
        'Accept-Encoding' = 'gzip, deflate, br'
    };

    $url = "$ForgeApiBaseAddress/bim360/admin/v1/accounts";

    Write-Verbose $url;

    return Invoke-RestMethod -Uri $url `
                             -Method Get `
                             -Headers $headers `
                             -Authentication OAuth `
                             -Token $ForgeOAuthToken;
}