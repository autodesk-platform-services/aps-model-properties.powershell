function ConvertTo-ForgeDataFilter {
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [hashtable] $Filters        
    )
    
    $encoded = '';
    $clear = ''

    foreach ($key in $Filters.keys) 
    {
        if ($encoded -eq '') 
        {
            if ($Filters[$key] -match '^(\-[a-z]+=){1}(.+)$') {
                $encoded += ("filter[$key]" + $Matches[1] + [System.Web.HttpUtility]::UrlEncode($Matches[2]));
                $clear += ("filter[$key]" + $Filters[$key]);
            } else {
                $encoded += ("filter[$key]=" + [System.Web.HttpUtility]::UrlEncode($Filters[$key]));
                $clear += ("filter[$key]=" + $Filters[$key]);
            }
        } 
        else 
        {
            if ($Filters[$key].StartsWith('-')) {
                $encoded += ("&filter[$key]" + $Matches[1] + [System.Web.HttpUtility]::UrlEncode($Matches[2]));
                $clear += ("&filter[$key]" + $Filters[$key]);
            } else {
                $encoded += ("&filter[$key]=" + [System.Web.HttpUtility]::UrlEncode($Filters[$key]));
                $clear += ("&filter[$key]=" + $Filters[$key]);
            }
        }
    }

    return [PSCustomObject]@{
        Encoded = $encoded
        Clear = $clear
    };
}

function Get-ForgeHubs {
    param (        
        [Parameter(Mandatory=$false, ValueFromPipeline=$false)]
        [hashtable] $Filter       
    )    

    $headers = @{
        'Accept' = '*/*'        
        'Accept-Encoding' = 'gzip, deflate, br'
    };

    $urlPostfix = '';

    if ($null -ne $Filter) {
        $f = ConvertTo-ForgeDataFilter -Filters $Filter;
        Write-Verbose $f;
        $urlPostfix = '?' + $f.Encoded;
    }

    $url = "$ForgeApiBaseAddress/project/v1/hubs$urlPostfix";

    Write-Verbose $url;

    return Invoke-RestMethod -Uri $url `
                             -Method Get `
                             -Headers $headers `
                             -Authentication OAuth `
                             -Token $ForgeOAuthToken;
}

function Get-ForgeHub {
    param ( 
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string] $HubId      
    )    

    $headers = @{
        'Accept' = '*/*'        
        'Accept-Encoding' = 'gzip, deflate, br'
    };

    $url = "$ForgeApiBaseAddress/project/v1/hubs/$HubId";

    Write-Verbose $url;

    return Invoke-RestMethod -Uri $url `
                             -Method Get `
                             -Headers $headers `
                             -Authentication OAuth `
                             -Token $ForgeOAuthToken;
}

function Get-ForgeProjects {
    param ( 
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string] $HubId,  
        [Parameter(Mandatory=$false, ValueFromPipeline=$false)]
        [hashtable] $Filter      
    )    

    $headers = @{
        'Accept' = '*/*'        
        'Accept-Encoding' = 'gzip, deflate, br'
    };

    $urlPostfix = '';

    if ($null -ne $Filter) {
        $f = ConvertTo-ForgeDataFilter -Filters $Filter;
        Write-Verbose $f;
        $urlPostfix = '?' + $f.Encoded;
    }

    $url = "$ForgeApiBaseAddress/project/v1/hubs/$HubId/projects$urlPostfix";

    Write-Verbose $url;

    return Invoke-RestMethod -Uri $url `
                             -Method Get `
                             -Headers $headers `
                             -Authentication OAuth `
                             -Token $ForgeOAuthToken;
}

function Get-ForgeProject {
    param ( 
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [string] $HubId,  
        [Parameter(Mandatory=$false, ValueFromPipeline=$false)]
        [string] $ProjectId      
    )    

    $headers = @{
        'Accept' = '*/*'        
        'Accept-Encoding' = 'gzip, deflate, br'
    };

    $url = "$ForgeApiBaseAddress/project/v1/hubs/$HubId/projects/$ProjectId";

    Write-Verbose $url;

    return Invoke-RestMethod -Uri $url `
                             -Method Get `
                             -Headers $headers `
                             -Authentication OAuth `
                             -Token $ForgeOAuthToken;
}

function Get-ForgeProjectTopFolders {
    param ( 
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [string] $HubId,  
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string] $ProjectId      
    )    

    $headers = @{
        'Accept' = '*/*'        
        'Accept-Encoding' = 'gzip, deflate, br'
    };

    $url = "$ForgeApiBaseAddress/project/v1/hubs/$HubId/projects/$ProjectId/topFolders";

    Write-Verbose $url;

    return Invoke-RestMethod -Uri $url `
                             -Method Get `
                             -Headers $headers `
                             -Authentication OAuth `
                             -Token $ForgeOAuthToken;
}

function Get-ForgeFolderContents {
    param ( 
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [string] $ProjectId,  
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string] $FolderUrn,   
        [Parameter(Mandatory=$false, ValueFromPipeline=$false)]
        [hashtable] $Filter      
    )    

    $headers = @{
        'Accept' = '*/*'        
        'Accept-Encoding' = 'gzip, deflate, br'
    };

    $urlPostfix = '';

    if ($null -ne $Filter) {
        $f = ConvertTo-ForgeDataFilter -Filters $Filter;
        Write-Verbose $f;
        $urlPostfix = '?' + $f.Encoded;
    }

    $url = "$ForgeApiBaseAddress/data/v1/projects/$ProjectId/folders/$FolderUrn/contents$urlPostfix";

    Write-Verbose $url;

    return Invoke-RestMethod -Uri $url `
                             -Method Get `
                             -Headers $headers `
                             -Authentication OAuth `
                             -Token $ForgeOAuthToken;
}

function Search-ForgeFolder {
    param ( 
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [string] $ProjectId,  
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [string] $FolderUrn,   
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [hashtable] $Filter      
    )    

    $headers = @{
        'Accept' = '*/*'        
        'Accept-Encoding' = 'gzip, deflate, br'
    };

    $urlPostfix = '';

    if ($null -ne $Filter) {
        $f = ConvertTo-ForgeDataFilter -Filters $Filter;
        Write-Verbose $f;
        $urlPostfix = '?' + $f.Encoded;
    }

    $url = "$ForgeApiBaseAddress/data/v1/projects/$ProjectId/folders/$FolderUrn/search$urlPostfix";

    Write-Verbose $url;

    return Invoke-RestMethod -Uri $url `
                             -Method Get `
                             -Headers $headers `
                             -Authentication OAuth `
                             -Token $ForgeOAuthToken;
}

function Get-ForgeFolderByPath {
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [string] $HubId,  
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [string] $ProjectId,          
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string] $Path 
    )
    
    if (-not $Path.StartsWith('//'))
    {
        throw "Invalid Path, $Path. Item path must be format //folder/.../item_name"
    }

    $parts = $Path.Substring(2).Split('/');
    $currentFolder = $null;

    for ($i = 0; $i -lt $parts.Length; $i++)
    {
        if ($i -eq 0)
        {        
            $topFolders = Get-ForgeProjectTopFolders `
                -HubId $HubId `
                -ProjectId $ProjectId;

            foreach ($folder in $topFolders.data) {
                if ($folder.attributes.displayName -eq $parts[0]) {
                    $currentFolder = $folder;
                    break;
                }
            }

            if ($null -eq $currentFolder) {
                throw "Could not find root folder $($parts[0])";
            }
        }
        else {
            $filter = @{ 
                'attributes.displayName' = $parts[$i]
                'extension.type' = 'folders:autodesk.bim360:Folder'
            }
                        
            $contents = Get-ForgeFolderContents `
                -ProjectId $ProjectId `
                -FolderUrn $currentFolder.id `
                -Filter $filter;

            if ($contents.data.length -ne 1) {
                $contents | ConvertTo-Json -Depth 5 | Write-Verbose;
                throw "Could not find folder for path part $($parts[$i])";
            }

            $currentFolder = $contents.data[0];
        }
    }

    return $currentFolder;
}

function Get-ForgeItemByPath {
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [string] $HubId,  
        [Parameter(Mandatory=$true, ValueFromPipeline=$false)]
        [string] $ProjectId,          
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string] $Path 
    )
    
    if (-not $Path.StartsWith('//'))
    {
        throw "Invalid Path, $Path. Item path must be format //folder/.../item_name"
    }

    $folderPath = $Path.Substring(0, $Path.LastIndexOf('/'));
    $itemName = $Path.Substring($Path.LastIndexOf('/') + 1);

    Write-Verbose "Find item $itemName in $folderPath";

    $folder = Get-ForgeFolderByPath `
        -HubId $HubId `
        -ProjectId $ProjectId `
        -Path $folderPath;
    
    $filter = @{ 
        'attributes.displayName' = $itemName
        'extension.type' = 'items:autodesk.bim360:File'
    }
                
    $contents = Get-ForgeFolderContents `
        -ProjectId $ProjectId `
        -FolderUrn $folder.id `
        -Filter $filter;

    if ($contents.data.length -ne 1) {
        $contents | ConvertTo-Json -Depth 5 | Write-Verbose;
        throw "Could not find folder for path part $($parts[$i])";
    }

    return $contents.data[0];
}