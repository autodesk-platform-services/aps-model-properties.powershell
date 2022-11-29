# APSCLI PowerShell Script Module

[APSCLI.psd1](./APSCLI.psd1) is a PowerShell script module containing a set of cmdlets for working with the ACC Model Properties (Indexing) service. In addition to cmdlets for creating and querying indexes, APSCLI also contains utility cmdlets for querying [APS Data Management](https://forge.autodesk.com/en/docs/data/v2/developers_guide/overview/) converting APS OAuth tokens to `SecureString`.

### Usage

```PowerShell
PS > Import-Module ./APSCLI.ps1
```

### Cmdlets

| Cmdlets                         | Description                                                     |
| ------------------------------- | --------------------------------------------------------------- |
| [utils](../doc/cmdlet/utils.md) | Utility cmdlets for web download and secure string manipulation |
| [data](../doc/cmdlet/data.md)   | APS Data Management cmdlets                                   |
| [admin](../doc/cmdlet/admin.md) | ACC/B360 Admin cmdlets				                            |
| [index](../doc/cmdlet/index.md) | Basic index cmdlets, create/query index                         |
| [diff](../doc/cmdlet/diff.md)   | Diff index cmdlets, create/query index                          |

[back](../README.md)