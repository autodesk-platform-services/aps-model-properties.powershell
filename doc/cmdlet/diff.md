![alt text](../img/autodesk-logo.png "Autodesk (c)")

# Cmdlets

[New-BimPropertyDiff](#New-BimPropertyDiff)

[Get-BimPropertyDiff](#Get-BimPropertyDiff)

[New-BimPropertyDiffQuery](#New-BimPropertyDiffQuery)

[Get-BimPropertyDiffQuery](#Get-BimPropertyDiffQuery)

# <a name="New-BimPropertyDiff"></a>New-BimPropertyDiff

### Syntax

```PowerShell
New-BimPropertyDiff 
    [-ProjectId] <guid>
    [-SpecificationJson] <string>
```

### Description

Create a new diff index with the specified file tuples

### Examples

```PowerShell
New-BimPropertyDiff 
    -ProjectId 'f83cef12-beef-4771-97eb-4f85643e3c46' `
    -SpecificationJson '{
        "diffs": [
            {
                "prevVersionUrn": "urn:adsk.wipprod:fs.file:vf.OGB3DgCdTQq--zcEsvlm6A?version=9",
                "curVersionUrn": "urn:adsk.wipprod:fs.file:vf.OGB3DgCdTQq--zcEsvlm6A?version=20"
            },
            {
                "prevVersionUrn": "urn:adsk.wipprod:fs.file:vf.HdCtnuXlRVGYJsJI7pS90Q?version=1",
                "curVersionUrn": "urn:adsk.wipprod:fs.file:vf.HdCtnuXlRVGYJsJI7pS90Q?version=2"
            },
            {
                "prevVersionUrn": "urn:adsk.wipprod:fs.file:vf.3F_w-tXFS3eabQ1RyR_PFg?version=2",
                "curVersionUrn": "urn:adsk.wipprod:fs.file:vf.3F_w-tXFS3eabQ1RyR_PFg?version=5"
            }
        ]
    }';
```

### Parameters

#### `-ProjectId`

| Attribute                  | Value           |
| -------------------------- |---------------- |
| Type    	                 | `System.Guid`   |
| Position                   | Named           |
| Default value              | None            |
| Accept pipeline input      | False           |
| Accept wildcard characters | False           |

#### `-SpecificationJson`

The JSON specification for the index.

| Attribute                  | Value           |
| -------------------------- |---------------- |
| Type    	                 | `string`        |
| Position                   | Named           |
| Default value              | None            |
| Accept pipeline input      | False           |
| Accept wildcard characters | False           |

### Outputs

The diff index, see the [Model Properties APS documentation](https://forge.autodesk.com/en/docs/acc/v1/reference/http/index-v2-diff-merge-status-post/) for full details.

# <a name="Get-BimPropertyDiff"></a>Get-BimPropertyDiff

### Syntax

```PowerShell
Get-BimPropertyDiff 
    [-ProjectId] <guid>
    [-DiffId] <string>
```

### Description

Get the status of an executing diff indexing job by diff index ID.

### Examples

```PowerShell
Get-BimPropertyDiff 
    -ProjectId 'f83cef12-beef-4771-97eb-4f85643e3c46' `
    -DiffId 'qTmPiKJZ7siqxkTNpWGANw'
```

### Parameters

#### `-ProjectId`

| Attribute                  | Value           |
| -------------------------- |---------------- |
| Type    	                 | `System.Guid`   |
| Position                   | Named           |
| Default value              | None            |
| Accept pipeline input      | False           |
| Accept wildcard characters | False           |

The project ID to target.

#### `-DiffId`

| Attribute                  | Value           |
| -------------------------- |---------------- |
| Type    	                 | `string`        |
| Position                   | Named           |
| Default value              | None            |
| Accept pipeline input      | False           |
| Accept wildcard characters | False           |

The ID of the Diff to target.

### Outputs

The diff index, see the [Model Properties Forge documentation](https://forge.autodesk.com/en/docs/acc/v1/reference/http/index-v2-diff-status-get/) for full details.

# <a name="New-BimPropertyDiffQuery"></a>New-BimPropertyDiffQuery

### Syntax

```PowerShell
New-BimPropertyDiffQuery 
    [-ProjectId] <guid>
    [-DiffId] <string>
    [-QueryJson] <string>
```

### Description

Execute a new BIM diff query against a specific diff index, identified by ID.

### Examples

```PowerShell
New-BimPropertyDiffQuery 
    -ProjectId 'f83cef12-beef-4771-97eb-4f85643e3c46' `
    -DiffId 'qTmPiKJZ7siqxkTNpWGANw' `
    -QueryJson '{
        "query": {
            "$ne": [
                "s.props.p1b2aabe1",
                "s.prev.props.p1b2aabe1"
            ]
        }
    }';
```

### Parameters

#### `-ProjectId`

| Attribute                  | Value           |
| -------------------------- |---------------- |
| Type    	                 | `System.Guid`   |
| Position                   | Named           |
| Default value              | None            |
| Accept pipeline input      | False           |
| Accept wildcard characters | False           |

The project ID to target.

#### `-DiffId`

| Attribute                  | Value           |
| -------------------------- |---------------- |
| Type    	                 | `string`        |
| Position                   | Named           |
| Default value              | None            |
| Accept pipeline input      | False           |
| Accept wildcard characters | False           |

The ID of the diff index to target.

#### `-QueryJson`

| Attribute                  | Value           |
| -------------------------- |---------------- |
| Type    	                 | `string`        |
| Position                   | Named           |
| Default value              | None            |
| Accept pipeline input      | False           |
| Accept wildcard characters | False           |

The diff query JSON to run.

### Outputs

The diff index query, see the [Model Properties Forge documentation](https://forge.autodesk.com/en/docs/acc/v1/reference/http/index-v2-diff-query-post/) for full details.

# <a name="Get-BimPropertyDiffQuery"></a>Get-BimPropertyDiffQuery

### Syntax

```PowerShell
Get-BimPropertyDiffQuery 
    [-ProjectId] <guid>
    [-DiffId] <string>
    [-QueryId] <string>
```

### Description

Get the status of a diff index query via the index ID and query ID.

### Examples

```PowerShell
Get-BimPropertyDiffQuery 
    -ProjectId 'f83cef12-beef-4771-97eb-4f85643e3c46' `
    -DiffId 'qTmPiKJZ7siqxkTNpWGANw' `
    -QueryId '_ukKZbcA8TN9CLMgLchgnA';
```

### Parameters

#### `-ProjectId`

| Attribute                  | Value           |
| -------------------------- |---------------- |
| Type    	                 | `System.Guid`   |
| Position                   | Named           |
| Default value              | None            |
| Accept pipeline input      | False           |
| Accept wildcard characters | False           |

The project ID to target.

#### `-DiffId`

| Attribute                  | Value           |
| -------------------------- |---------------- |
| Type    	                 | `string`        |
| Position                   | Named           |
| Default value              | None            |
| Accept pipeline input      | False           |
| Accept wildcard characters | False           |

The Diff to target.

#### `-QueryId`

| Attribute                  | Value           |
| -------------------------- |---------------- |
| Type    	                 | `string`        |
| Position                   | Named           |
| Default value              | None            |
| Accept pipeline input      | False           |
| Accept wildcard characters | False           |

The Diff query ID corresponding to the executed query.

### Outputs

The diff index query, see the [Model Properties APS documentation](https://stg.forge.autodesk.com/en/docs/acc/v1/reference/http/index-v2-diff-query-job-status-get/) for full details.