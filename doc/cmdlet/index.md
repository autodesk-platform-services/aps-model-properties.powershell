![alt text](../img/autodesk-logo.png "Autodesk (c)")

# Cmdlets

[New-BimPropertyIndex](#New-BimPropertyIndex)

[Get-BimPropertyIndex](#Get-BimPropertyIndex)

[New-BimPropertyIndexQuery](#New-BimPropertyIndexQuery)

[Get-BimPropertyIndexQuery](#Get-BimPropertyIndexQuery)

# <a name="New-BimPropertyIndex"></a>New-BimPropertyIndex

### Syntax

```PowerShell
New-BimPropertyIndex 
    [-ProjectId] <guid>
    [-SpecificationJson] <string>
```

### Description

Create individual or merged BIM index.

### Examples

```PowerShell
New-BimPropertyIndex `
    -ProjectId 'f83cef12-deef-4771-9feb-4f8564388c46' `
    -SpecificationJson '{
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
```

### Parameters

#### `-ProjectId`

The project ID to target.

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

The index, see the [Model Properties APS documentation](https://forge.autodesk.com/en/docs/acc/v1/reference/http/index-v2-index-merge-status-post/) for full details.

# <a name="Get-BimPropertyIndex"></a>Get-BimPropertyIndex

### Syntax

```PowerShell
Get-BimPropertyIndex 
    [-ProjectId] <guid>
    [-IndexId] <string>
```

### Description
  
Get the status of a running index job using the unique index ID.

### Examples

```PowerShell
Get-BimPropertyIndex `
    -ProjectId 'f83cef12-deef-4771-9feb-4f8564388c46' `
    -IndexId 'qTmPiKJZ7siqxkTNpWGANw';
```

### Parameters

#### `-ProjectId`

The project ID to target.

| Attribute                  | Value           |
| -------------------------- |---------------- |
| Type    	                 | `System.Guid`   |
| Position                   | Named           |
| Default value              | None            |
| Accept pipeline input      | False           |
| Accept wildcard characters | False           |

#### `-IndexId`

The index to target.

| Attribute                  | Value           |
| -------------------------- |---------------- |
| Type    	                 | `string`        |
| Position                   | Named           |
| Default value              | None            |
| Accept pipeline input      | False           |
| Accept wildcard characters | False           |

### Outputs

The index, see the [Model Properties APS documentation](https://forge.autodesk.com/en/docs/acc/v1/reference/http/index-v2-index-status-get/) for full details.

# <a name="New-BimPropertyIndexQuery"></a>New-BimPropertyIndexQuery

### Syntax

```PowerShell
New-BimPropertyIndexQuery 
    [-ProjectId] <guid>
    [-IndexId] <string>
    [-QueryJson] <string>
```

### Description

Execute a new BIM index query against an existing index.

### Examples

```PowerShell
New-BimPropertyIndexQuery `
    -ProjectId 'f83cef12-deef-4771-9feb-4f8564388c46' `
    -IndexId 'qTmPiKJZ7siqxkTNpWGANw' `
    -QueryJson '{
        "query": {
            "$gt": [ { "$count": "s.views" }, 0 ]
        }
    }';
```

### Parameters

#### `-ProjectId`

The project ID to target.

| Attribute                  | Value           |
| -------------------------- |---------------- |
| Type    	                 | `System.Guid`   |
| Position                   | Named           |
| Default value              | None            |
| Accept pipeline input      | False           |
| Accept wildcard characters | False           |

#### `-IndexId`

The index to target.

| Attribute                  | Value           |
| -------------------------- |---------------- |
| Type    	                 | `string`        |
| Position                   | Named           |
| Default value              | None            |
| Accept pipeline input      | False           |
| Accept wildcard characters | False           |

#### `-QueryJson`

The index query JSON to run.

| Attribute                  | Value           |
| -------------------------- |---------------- |
| Type    	                 | `string`        |
| Position                   | Named           |
| Default value              | None            |
| Accept pipeline input      | False           |
| Accept wildcard characters | False           |

### Outputs

The index query, see the [Model Properties APS documentation](https://forge.autodesk.com/en/docs/acc/v1/reference/http/index-v2-index-query-post/) for full details.

# <a name="Get-BimPropertyIndexQuery"></a>Get-BimPropertyIndexQuery

### Syntax

```PowerShell
Get-BimPropertyIndexQuery 
    [-ProjectId] <guid>
    [-IndexId] <string>
    [-QueryId] <string>
```

### Description

### Examples

```PowerShell
Get-BimPropertyIndexQuery `
    -ProjectId 'f83cef12-deef-4771-9feb-4f8564388c46' `
    -IndexId 'qTmPiKJZ7siqxkTNpWGANw' `
    -QueryId '1uqaSYj39pOIaAuQutmZpg';
```

### Parameters

#### `-ProjectId`

The project ID to target.

| Attribute                  | Value           |
| -------------------------- |---------------- |
| Type    	                 | `System.Guid`   |
| Position                   | Named           |
| Default value              | None            |
| Accept pipeline input      | False           |
| Accept wildcard characters | False           |

#### `-IndexId`

The index to target.

| Attribute                  | Value           |
| -------------------------- |---------------- |
| Type    	                 | `string`        |
| Position                   | Named           |
| Default value              | None            |
| Accept pipeline input      | False           |
| Accept wildcard characters | False           |

#### `-QueryId`

The index query ID corresponding to the executed query.

| Attribute                  | Value           |
| -------------------------- |---------------- |
| Type    	                 | `string`        |
| Position                   | Named           |
| Default value              | None            |
| Accept pipeline input      | False           |
| Accept wildcard characters | False           |

### Outputs

The index query, see the [Model Properties APS documentation](https://forge.autodesk.com/en/docs/acc/v1/reference/http/index-v2-index-query-job-status-get/) for full details.