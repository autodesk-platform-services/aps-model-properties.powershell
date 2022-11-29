![alt text](../doc/img/autodesk-logo.png "Autodesk (c)")

# Models

![alt text](../doc/img/audubon-banner.png "Autodesk (c)")

The models folder contains sample versions of the Audubon project. The Audubon project consists of an architectural, structural and mechanical model. The samples provided with this repo include a [pure revit version of Audubon](./audubon/revit/v1), where all three disciplines, architecture, structure and mechanical are modelled in Revit and a [_mixed_ version](./audubon/mixed), where only the architecture model is Revit with the mechanical model converted to DWG and the structural model converted into IFC. In addition an [updated V2 mechanical Revit model](./audubon/revit/v2) is provided which will allow the diff features of the service to be explored.

## Setting up Audubon in Docs

The following steps describe uploading the models in this folder to ACC/BIM 360 Docs and obtain the file version URNs for these models which will be required as input into the indexing and querying process.

### Step 1: Create Working Folders

Sign into Docs and create folders to contain test files. The following instructions are based on creating and uploading files to the following folder structure. You are free to use whatever folder structure you desire, however you will need to adjust the example paths in the script below.
<br/>
<br/>
![alt text](../doc/img/img-1-create-folders.png "Autodesk (c)")
</br>
</br>

### Step 2: Upload Audubon RVT

Take the three `RVT` files from the [/audubon/revit/v1](./audubon/revit/v1) folder and upload them to the `//Projects Files/API Testing/Audubon/Revit` folder created in Step 1.
<br/>
<br/>
![alt text](../doc/img/img-2-upload-rvt.png "Autodesk (c)")
</br>
</br>

### Step 3: Upload Audubon Mixed

Take the, `RVT`, `DWG` and `IFC` files from the [/audubon/mixed](./audubon/mixed) folder and upload them to the `//Projects Files/API Testing/Audubon/Mixed` folder created in Step 1.
<br/>
<br/>
![alt text](../doc/img/img-3-upload-mixed.png "Autodesk (c)")
</br>
</br>

### Step 4: Get the tip version URNs for the uploaded models

In order to build an index you will need the URNs of the files you have just uploaded. The [APSCLI](../src/APSCLI.psd1) script module contains various cmdlets which call the APS Data Management API. The example below shows how they can be used to get the version URNs of the files uploaded in the previous step.
</br>
</br>

> Note the use of the default `$PSScriptRoot` variable in the snippet below. `$PSScriptRoot` is set to the folder containing the script currently being executed by the PowerShell host. In order to get the sample to run you would need to save a script containing these lines in the [src](../src) folder. The [.gitignore](../.gitignore) file in this repo is configured to ignore any file with a name ending `.test.ps1`. When running this script you will also need to supply a `3LO` (user) OAuth token as the indexing service does not currently support `2LO` or `2LO+I`.

</br>
</br>

```PowerShell
# import the APSCLI script module
Import-Module "$PSScriptRoot\APSCLI.psd1";

# OAuth APS token
Set-APSToken -Token 'Your OAuth Token Here'; 

# hub and project GUID
$hubId = [guid]('Your Account GUID here - no b. prefix!');
$projectId = [guid]('Your Project GUID here - no b. prefix!');

# Adjust paths as necessary. In the example below the RVT and mixed versions of Audubon
# have been placed in a /Project Files/API Testing/Audubon/ test folder...
$paths = @(
    '//Project Files/API Testing/Audubon/Mixed/Audubon_Arch.rvt',
    '//Project Files/API Testing/Audubon/Mixed/Audubon_Mechanical.dwg',
    '//Project Files/API Testing/Audubon/Mixed/Audubon_Structure.ifc',
    '//Project Files/API Testing/Audubon/Revit/Audubon_Architecture.rvt',
    '//Project Files/API Testing/Audubon/Revit/Audubon_Mechanical.rvt',
    '//Project Files/API Testing/Audubon/Revit/Audubon_Structure.rvt'
);

$items = $paths | %{ 
    [PSCustomObject]@{
        Item = Get-APSItemByPath -HubId "b.$hubId" -ProjectId "b.$projectId" -Path $_ -Verbose
        Path = $_
    } 
}

$items | % { "$($_.Path) -> $($_.Item.relationships.tip.data.id)" }
```

Sample output

```PowerShell
PS > .\get-uploaded-files.test.ps1
//Project Files/API Testing/Audubon/Revit/Audubon_Architecture.rvt -> urn:adsk.wipprod:fs.file:vf.OGB3DgCdTQq--zcEsvlm6A?version=1
//Project Files/API Testing/Audubon/Revit/Audubon_Mechanical.rvt -> urn:adsk.wipprod:fs.file:vf.HdCtnuXlRVGYJsJI7pS90Q?version=1
//Project Files/API Testing/Audubon/Revit/Audubon_Structure.rvt -> urn:adsk.wipprod:fs.file:vf.3F_w-tXFS3eabQ1RyR_PFg?version=1
//Project Files/API Testing/Audubon/Mixed/Audubon_Arch.rvt -> urn:adsk.wipprod:fs.file:vf.jVZqhVFrT-uYHUyJBQw0Fw?version=1
//Project Files/API Testing/Audubon/Mixed/Audubon_Mechanical.dwg -> urn:adsk.wipprod:fs.file:vf.r3FFvBNpS0yMY_tCId5rCA?version=1
//Project Files/API Testing/Audubon/Mixed/Audubon_Structure.ifc -> urn:adsk.wipprod:fs.file:vf.dHJseGsXTc2eIVXRz_Xxvw?version=1
PS > 
```

### Step 5: Upload the updated Mechanical RVT

Take the V2 `Audubon_Mechanical.rvt` files from the [/audubon/revit/v2](./audubon/revit/v2) folder and upload them to the `//Projects Files/API Testing/Audubon/Revit` folder created in Step 1. This will update the version of the mechanical model in this folder. The V1 model will still be in Docs however the UI should display the V2 version of this model.
<br/>
<br/>
![alt text](../doc/img/img-4-upload-new-mechanical.png "Autodesk (c)")
</br>
</br>

### Step 6: Verify the updated Version URNs

Re-running the script in Step 4 and verify the updated version number, sample output below.

```PowerShell
PS > .\get-uploaded-files.test.ps1
//Project Files/API Testing/Audubon/Revit/Audubon_Architecture.rvt -> urn:adsk.wipprod:fs.file:vf.OGB3DgCdTQq--zcEsvlm6A?version=1
//Project Files/API Testing/Audubon/Revit/Audubon_Mechanical.rvt -> urn:adsk.wipprod:fs.file:vf.HdCtnuXlRVGYJsJI7pS90Q?version=2
//Project Files/API Testing/Audubon/Revit/Audubon_Structure.rvt -> urn:adsk.wipprod:fs.file:vf.3F_w-tXFS3eabQ1RyR_PFg?version=1
//Project Files/API Testing/Audubon/Mixed/Audubon_Arch.rvt -> urn:adsk.wipprod:fs.file:vf.jVZqhVFrT-uYHUyJBQw0Fw?version=1
//Project Files/API Testing/Audubon/Mixed/Audubon_Mechanical.dwg -> urn:adsk.wipprod:fs.file:vf.r3FFvBNpS0yMY_tCId5rCA?version=1
//Project Files/API Testing/Audubon/Mixed/Audubon_Structure.ifc -> urn:adsk.wipprod:fs.file:vf.dHJseGsXTc2eIVXRz_Xxvw?version=1
PS > 
```
[home](../README.md)