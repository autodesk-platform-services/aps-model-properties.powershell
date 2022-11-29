# Index Tables

## Understanding Index Rows and Columns 

The index _tables_ created by the server are stored as line delimited JSON. Each _row_ in an index _table_ (line in an index file) is a JSON document. The _columns_ in each row are therefore described as JSON document property paths prefixed with an `s.` table alias. In the example row below, taken from a diff index, the individual _columns_ available for querying are listed as a `// comment` at the end of each line.

```jsonc
{
    "type": "OBJECT_CHANGED",                                         // s.type
    "changeType": "Geometry",                                         // s.changeType
    "svf2Id": 127,                                                    // s.svf2Id
    "externalId": "4fcbe8e4-7bda-49d6-8863-f0ba387a7892-000ccf8f",    // s.externalId
    "lmvId": 2608,                                                    // s.lmvId
    "lineageId": "2b856593",                                          // s.lineageId
    "databaseId": "3d0bd846",                                         // s.databaseId
    "props": {
        "p002932a2": 0e0,                                             // s.props.p002932a2
        "p01bbdcf2": "Arch-FIRST FLOOR",                              // s.props.p01bbdcf2
        "p0337db30": true,                                            // s.props.p0337db30
        "p07bfebb5": 14e0,                                            // s.props.p07bfebb5
        "p09faf620": "1 D",                                           // s.props.p09faf620
        "p13b6b3a0": "1 D",                                           // s.props.p13b6b3a0
        "p153cb174": "Round Elbow [839567]",                          // s.props.p153cb174
        "p1b2aabe1": 8750000000000028e-15,                            // s.props.p1b2aabe1
        "p20d8441e": "Duct Fittings",                                 // s.props.p20d8441e
        "p240c30c1": "Coefficient from ASHRAE Table",                 // s.props.p240c30c1
        "p2508403c": "14\"Ã¸-14\"Ã¸",                                 // s.props.p2508403c
        "p271e8080": 9000000000000009e-14,                            // s.props.p271e8080
        "p2c0bde18": "Return Air",                                    // s.props.p2c0bde18
        "p30db51f9": "Round Elbow",                                   // s.props.p30db51f9
        "p3c57b64e": "New Construction",                              // s.props.p3c57b64e
        "p40adfd90": 13999999999999996e-15,                           // s.props.p40adfd90
        "p4709f0b8": "14\"Ã¸-14\"Ã¸",                                 // s.props.p4709f0b8
        "p512a7a70": 0e0,                                             // s.props.p512a7a70
        "p52f36fef": 7e0,                                             // s.props.p52f36fef
        "p5eddc473": "Revit Duct Fittings",                           // s.props.p5eddc473
        "p86cd967d": 0e0,                                             // s.props.p86cd967d
        "p875a6521": "14\"Ã¸-14\"Ã¸",                                 // s.props.p875a6521
        "p8d70f1c5": "1460",                                          // s.props.p8d70f1c5
        "p8f7dfe92": 0e0,                                             // s.props.p8f7dfe92
        "pa7275c45": -2008010,                                        // s.props.pa7275c45
        "pab5862eb": "Return Air",                                    // s.props.pab5862eb
        "pc9829743": "Air Ductwork",                                  // s.props.pc9829743
        "pccae2592": 1e0,                                             // s.props.pccae2592
        "pdbb511ef": "RA",                                            // s.props.pdbb511ef
        "pdbc25565": "23.75.70.14",                                   // s.props.pdbc25565
        "pe36ff9a6": "Mechanical Return Air 2",                       // s.props.pe36ff9a6
        "pe61a57c3": 0e0,                                             // s.props.pe61a57c3
        "pee815a7f": "None"                                           // s.props.pee815a7f
    },
    "propsHash": "608b8f68",                                          // s.propsHash
    "propsIgnored": {
        "p6a81eafd": 2588,                                            // s.propsIgnored.p6a81eafd
        "p93e93af5": 2589                                             // s.propsIgnored.p93e93af5
    },
    "geomHash": "H8DdjIogd96G82hB2WHU3A",                             // s.geomHash
    "bboxMin": {                                      
        "x": 9616518030372494e-14,                                    // s.bboxMin.x
        "y": -5901049337414818e-14,                                   // s.bboxMin.y
        "z": 10816666659712786e-14                                    // s.bboxMin.z
    },
    "bboxMax": {                                      
        "x": 9616518030372494e-14,                                    // s.bboxMax.x
        "y": -5901049337414818e-14,                                   // s.bboxMax.y
        "z": 10816666659712786e-14                                    // s.bboxMax.z
    },
    "views": [                                                        // s.views
        "f109b687",                                                   // s.views[0]
        "f24d458"                                                     // s.views[1]
    ],
    "prev": {
        "lmvId": 2608,                                                // s.prev.lmvId
        "lineageId": "b28c3429",                                      // s.prev.lineageId
        "databaseId": "936acb06",                                     // s.prev.databaseId
        "props": {
            "p1b2aabe1": 10666666666666671e-15                        // s.prev.props.p1b2aabe1
        },
        "propsHash": "95064165",                                      // s.prev.propsHash
        "propsIgnored": {
            "p6a81eafd": 2588,                                        // s.prev.propsIgnored.p6a81eafd
            "p93e93af5": 2589                                         // s.prev.propsIgnored.p93e93af5
        },
        "geomHash": "z0icZkdHx+XIRb6MSjg/2w",                         // s.prev.geomHash
        "bboxMin": {                                      
            "x": 9616518030372494e-14,                                // s.prev.bboxMin.x
            "y": -5901049337414818e-14,                               // s.prev.bboxMin.y
            "z": 10816666659712786e-14                                // s.prev.bboxMin.z
        },
        "bboxMax": {                                      
            "x": 9616518030372494e-14,                                // s.prev.bboxMax.x
            "y": -5901049337414818e-14,                               // s.prev.bboxMax.y
            "z": 10816666659712786e-14                                // s.prev.bboxMax.z
        },
        "views": [                                                    // s.prev.views
            "f109b687",                                               // s.prev.views[0]
            "8e525582"                                                // s.prev.views[1]
        ]
    }
}
```

# Columns

## Object/File Version Control Columns
  
The following columns describe the object in terms of the file version it was extracted from and the SVF(2) IDs which would be required to find the model element in the APS viewer. This includes columns which link back to the index manifest. For a full explanation of the structure of index manifests see the [APS API model properties field guide](https://forge.autodesk.com/en/docs/acc/v1/overview/field-guide/model-properties/). 

| Column         | Type     | Description                                                                |
| -------------- | -------- | -------------------------------------------------------------------------- |
| `s.svf2Id`     | `int`    | The SVF2 object ID corresponding to the row                                |
| `s.externalId` | `string` | The SVF2 external object ID corresponding to the row                       |
| `s.lmvId`      | `int`    | The SVF object ID corresponding to the row                                 |
| `s.lineageId`  | `string` | The index manifest key for the lineage (Item) containing this object row   |
| `s.databaseId` | `string` | The index manifest key for the SVF2 property db file used to build the row |

## Property Values

The property values set on any given object in a model vary from element to element. The properties for an index row representing a model object are stored in a `"props:" <object>` child object on the JSON document row. Each JSON property on the `props` object is an index property field which is set of this object row in the model. If a value is not set for a model element it will not appear as a property on the `props` object. The properties on the `props` object are keys into the index field resource which always start with a `p` prefix. The fields resource allows you to translate between a `p*` field key and its corresponding description in terms of an SVF2 model property category, data type, name, and depending on the class of property, a unit of measure. A full explanation of the fields resource can be found in the [APS API model properties field guide](https://forge.autodesk.com/en/docs/acc/v1/overview/field-guide/model-properties/).


| Column         | Type     | Description                                                           |
| -------------- | -------- | --------------------------------------------------------------------- |
| `s.props`      | `object` | The property field values for the current version of the object       |
| `s.props.p*`   | `*`      | A specific property field value for the current version of the object |

## Property Value Hashing

A property value hash is computed for each row using the values from the set of fields which are _known_ to be invariant between successive file versions unless a modeller deliberately removes a value, changes a value or adds a new field. Some fields are always set to different values between successive file versions and these are ignored when computing the hash. If you are looking at two consecutive versions of an object across two indexes and the property hash is identical then it is possible to infer that none of the user managed  property values have been changed between these two versions of the row (object).

| Column              | Type     | Description                                                                |
| --------------------| -------- | -------------------------------------------------------------------------- |
| `s.propsHash`       | `string` | A hash of the property values in the `s.props.*` object                    |
| `s.propsIgnored`    | `object` | The property value fields ignored when computing the property value hash   |
| `s.propsIgnored.p*` | `*`      | A specific field value ignored when computing the property value hash      |

### Viewable Objects

Not every object row in an index table is viewable in a the APS viewer. If an object row is _viewable_ then it will have a set of columns which characterise the geometry of the object. If the `s.views` array is null or empty then the object is NOT viewable. The `s.geomHash` is a hash of the mesh describing viewable objects. If this is the same between two consecutive versions of a object in two indexes then the object represented by the mesh as NOT changed shape or position in the model and the bounding boxes will also be expected to be equal.

| Column       | Type       | Description                                                                                                    |
| -------------| ---------- | -------------------------------------------------------------------------------------------------------------- |
| `s.views`    | `string[]` | The manifest keys describing the SVF2 viewable manifest to load in the APS viewer to display the object row  |
| `s.geomHash` | `string`   | The SVF2 geometry hash for the mesh describing this object in the model                                        |
| `s.bboxMin.x`| `double`   | The x value of the 3D coordinate of the minimum extent of the bounding box containing the mesh of this element |
| `s.bboxMin.y`| `double`   | The y value of the 3D coordinate of the minimum extent of the bounding box containing the mesh of this element |
| `s.bboxMin.z`| `double`   | The z value of the 3D coordinate of the minimum extent of the bounding box containing the mesh of this element |
| `s.bboxMax.x`| `double`   | The x value of the 3D coordinate of the maximum extent of the bounding box containing the mesh of this element |
| `s.bboxMax.y`| `double`   | The y value of the 3D coordinate of the maximum extent of the bounding box containing the mesh of this element |
| `s.bboxMax.z`| `double`   | The z value of the 3D coordinate of the maximum extent of the bounding box containing the mesh of this element |

### Diff Rows

The `"prev": <object>` child object and row `type` properties only appears in index document rows from diff indexes. Whilst `type` describes the kind of difference the row represents (object changed, added or removed), `prev` is an embedded object row which represents the _previous_ state of the row as defined by the current and previous file versions passed when defining the index. It has exactly the same properties as a standard object row, as described above, with the exception of the `s.prev.props.*` object. Instead of containing all of the property field values for the previous version of the object, this child object ONLY contains fields which are different in the previous version of the object, when compared to the outer, current version of the object. In the example document row at the top of this page taken form a diff index where this object has changed between file versions (`"type": "OBJECT_CHANGED"`) the values for `s.props.p1b2aabe1 = 8750000000000028e-15` and `s.prev.props.p1b2aabe1 = 10666666666666671e-15` are different. Also note the legacy SVF `lmvId` property value can be different between `s.lmvId` and `s.prev.lmvId`, whereas the SVF2 `s.svf2Id` is always stable in diff indexes and is thus identical for current and previous versions of the object. For this reason `s.prev.svf2Id` is not set as it would be identical to `s.svf2Id`. 

| Column        | Type     | Description                                                                                                   |
| --------------| -------- | ------------------------------------------------------------------------------------------------------------- |
| `s.type`      | `string` | For diff rows the kind of diff, `OBJECT_ADDED`, `OBJECT_CHANGED` or `OBJECT_REMOVED`                          |
| `s.changeType`| `string` | The change type if `OBJECT_CHANGED`. Possible values `Transform`, The position of the object has changed but  |
|               |          | its shape remains the same. `Geometry`, the shape of the object has changed (hashes do not match).            |
| `s.prev.*`    | `object` | The previous state of the object                                                                              |

[back](./README.md)