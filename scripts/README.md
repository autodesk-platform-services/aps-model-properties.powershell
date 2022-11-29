# Demo Walkthough Scripts

## getUrns.ps1

### Description

This script can be used to get contents of one folder in one project, in order to get URNs of the models which can be used in subsequent tests of the Model Properties API. This script calls the APS [Data Management API](https://forge.autodesk.com/en/docs/data/v2/reference/http/). This script only returns one page of folder content. Note: project ID for Data Management API calls requires 'b.' prefix to the project GUID. 

### Example

```PowerShell
# set a token and project
$3loToken = 'YOUR 3LO APS TOKEN HERE';

#Data Management API requires project id with 'b.' 
#e.g. b.55b9a76f-ff85-4831-8bee-e2cedc10b967 
$dmProjectId = 'YOUR PROJECT GUID HERE'; 
$folderUrn = 'YOUR FOLDER URN HERE'; 

# extract contents of one folder, and get some model urns.
& $PSScriptRoot\getUrns.ps1 -ProjectId $dmProjectId -FolderUrn $folderUrn -APSToken $3loToken;
```
 
### Parameters

| Parameter            | Type     | Description                                                          |
| -------------------- | -------- | -------------------------------------------------------------------- |
| `-dmProjectId`         | `string`   | A ACC/BIM 360 project ID (with b.)  
| `-folderUrn`         | `string`   | Urn of one folder|
| `-APSToken`        | `string` | A APS OAuth 2.0 3LO token string                                   |

### Output

This script  will output the response data to **.\out\folder-contents.json**. 


## createIndex.ps1

### Description

This script can be used to create single file or batch indexes. It imports the [CLI](../src) module and wraps the `New-BimPropertyIndex` cmdlet. The `Get-BimPropertyIndex` cmdlet is used to poll the index for progress. Finally the `Get-ResourceUrl` cmdlet is used to download the fields, manifest and properties JSON resources if the `-DownloadAll` switch is set.

In the process of [get index response](./createIndex.ps1#L47), it tells available index id array. One of which can be used for the subquent test of Query. Or you can find the index id in the file names of **out** folder.


### Example

```PowerShell
# set a token and project
$3loToken = 'YOUR 3LO APS TOKEN HERE';
$projectId = 'YOUR PROJECT GUID HERE';

# spec the index, in this case 3 files
$json = 
'{
    "versions": [
        {
            "versionUrn": "urn:adsk.wipprod:fs.file:vf.OGB3DgCdTQq--zcEsvlm6A?version=1"
        },
        {
            "versionUrn": "urn:adsk.wipprod:fs.file:vf.HdCtnuXlRVGYJsJI7pS90Q?version=1"
        },
        {
            "versionUrn": "urn:adsk.wipprod:fs.file:vf.3F_w-tXFS3eabQ1RyR_PFg?version=1"
        }
    ]
}';

# download the manifest, fields and properties for each indexed file, to merge add the -Merge switch
& $PSScriptRoot\createIndex.ps1 -ProjectId $projectId -SpecificationJson $json -APSToken $3loToken -DownloadAll;
```

### Parameters

| Parameter            | Type     | Description                                                          |
| -------------------- | -------- | -------------------------------------------------------------------- |
| `-ProjectId`         | `guid`   | A ACC/BIM 360 project GUID                                           |
| `-SpecificationJson` | `string` | The JSON specification for the index                                 |
| `-APSToken`        | `string` | A APS OAuth 2.0 3LO token string                                   |
| `-DownloadAll`       | `switch` | Set to download all resources for index                              |

### Output

This script will download the response from the [index status get endpoint](https://forge.autodesk.com/en/docs/acc/v1/reference/http/index-v2-index-status-get/). If the `-DownloadAll` switch is set the manifest, fields and properties resources for the index will be downloaded to an `./out` folder lazily created in the executing folder.

## runIndexQuery.ps1

### Description

This script can be used to create an run property breakdown queries against an existing index. This script imports the [APSCLI](../src) module and wraps the `New-BimPropertyIndexQuery` cmdlet. The `Get-BimPropertyIndexQuery` cmdlet is used to poll the index for progress. Finally the `Get-ResourceUrl` cmdlet is used to download the result JSON resource. For a detailed explanation of index building and querying see the [indexing and querying by example guide which accompanies this repo](../doc/README.md).

### Example

```PowerShell
# set a token, project and index ID to query
$3loToken = 'YOUR 3LO APS TOKEN HERE';
$projectId = 'YOUR PROJECT GUID HERE';
$indexId = 'THE INDEX ID TO TARGET';

# spec the query
$json = 
'{
    "query": 
    {
        "$gt": [{ "$count": "s.views" }, 0]
    }
}';


& $PSScriptRoot\runIndexQuery.ps1 -ProjectId $projectId -IndexId $indexId -QueryJson $json -APSToken $3loToken;
``` 


### Parameters

| Parameter     | Type     | Description                           |
| ------------- | -------- | ------------------------------------- |
| `-ProjectId`  | `guid`   | A ACC/BIM 360 project GUID            |
| `-IndexId`    | `string` | An index ID to target with the query  |
| `-QueryJson`  | `string` | The JSON query specification          |
| `-APSToken` | `string` | A APS OAuth 2.0 3LO token string    |

### Output

This script will write the response from the [index query status get endpoint](https://forge.autodesk.com/en/docs/acc/v1/reference/http/index-v2-index-query-job-status-get/) to the console. In addition it will also download the query results  resource to an `./out` folder it lazily creates in the scripts directory.

## createDiffIndex.ps1


### Description

This script can be used to create single file and merged diff indexes. This script imports the [APSCLI](../src) module and wraps the `New-BimPropertyDiff` cmdlet. The `Get-BimPropertyDiff` cmdlet is used to poll the index for progress. Finally the `Get-ResourceUrl` cmdlet is used to download the fields, manifest and properties JSON resources if the `-DownloadAll` switch is set. To create a merge model simply supply the `-Merge` switch.

### Example

```PowerShell
# set a token and project
$3loToken = 'YOUR 3LO APS TOKEN HERE';
$projectId = 'YOUR PROJECT GUID HERE';

# the index specification
$json = 
'{
    "diffs": [
        {
            "prevVersionUrn": "urn:adsk.wipprod:fs.file:vf.HdCtnuXlRVGYJsJI7pS90Q?version=1",
            "curVersionUrn": "urn:adsk.wipprod:fs.file:vf.HdCtnuXlRVGYJsJI7pS90Q?version=2"
        },
        {
            "prevVersionUrn": "urn:adsk.wipprod:fs.file:vf.3F_w-tXFS3eabQ1RyR_PFg?version=4",
            "curVersionUrn": "urn:adsk.wipprod:fs.file:vf.3F_w-tXFS3eabQ1RyR_PFg?version=6"
        }
    ]
}';

# download the manifest, fields and properties for each indexed file, to merge add the -Merge switch
& $PSScriptRoot\createDiffIndex.ps1 -ProjectId $projectId -SpecificationJson $json -APSToken $3loToken -DownloadAll;
```


### Parameters

| Parameter            | Type     | Description                                                          |
| -------------------- | -------- | -------------------------------------------------------------------- |
| `-ProjectId`         | `guid`   | A ACC/BIM 360 project GUID                                           |
| `-SpecificationJson` | `string` | The JSON specification for the index                                 |
| `-APSToken`        | `string` | A APS OAuth 2.0 3LO token string                                   |
| `-DownloadAll`       | `switch` | Set to download all resources for index                              |

### Output

This script will write the response from the [diff index status get endpoint](https://forge.autodesk.com/en/docs/acc/v1/reference/http/index-v2-diff-status-get/) to the console. In addition it will also download the manifest and fields resources for the index to an `./out` folder it lazily creates in the scripts directory.

## runDiffQuery.ps1

### Description
This script can be used to create an run diff queries against an existing index. This script imports the [APSCLI](../src) module and wraps the `New-BimPropertyDiffQuery` cmdlet. The `Get-BimPropertyDiffQuery` cmdlet is used to poll the index for progress. Finally the `Get-ResourceUrl` cmdlet is used to download the result JSON resource.

### Example

```PowerShell
# set a token, project and index ID to query
$3loToken = 'YOUR 3LO APS TOKEN HERE';
$projectId = 'YOUR PROJECT GUID HERE';
$indexId = 'THE INDEX ID TO TARGET';

$json = 
'{
    "query": 
    {
        "$ne": ["s.props.p1b2aabe1", "s.prev.props.p1b2aabe1"]
    }
}';

& $PSScriptRoot\runDiffQuery.ps1 -ProjectId $projectId -IndexId $indexId -QueryJson $json -APSToken $3loToken;
```


### Parameters

| Parameter     | Type     | Description                           |
| ------------- | -------- | ------------------------------------- |
| `-ProjectId`  | `guid`   | A ACC/BIM 360 project GUID            |
| `-IndexId`    | `string` | An index ID to target with the query  |
| `-QueryJson`  | `string` | The JSON query specification          |
| `-APSToken` | `string` | A APS OAuth 2.0 3LO token string    |

### Output

This script will write the response from the [diff index query status get endpoint](https://forge.autodesk.com/en/docs/acc/v1/reference/http/index-v2-diff-query-job-status-get/) to the console. In addition it will also download the query results  resource to an `./out` folder it lazily creates in the scripts directory.

[Home ReadMe](../README.md)