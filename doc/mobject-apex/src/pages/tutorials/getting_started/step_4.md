---
title: "Manipuate MObjects"
description: "Manipuate MObjects"
buttonTitle: "Done"
parentId: "getting_started"
layout: "tutorial"
time: 90
weight: 4
---

## {$page.title}

MObjects are designed to be easy to use. You can easily access the fields of the MObjects.

```javascript
Pricebook2 pb = [ ... ];
MObject mo = MObject.create(pb);
// Get value
String name = (String)mo.get('Name');
// Set value
mo.put('Name', 'New ' + name);
// Get nested value with default value
String modifiedBy = (String)mo.get('LastModifiedBy.Name', 'Unknown');
// Update nested value in a list
mo.put('Opportunities.0.Name', 'New op');
```

MObjects maintain a pure object relation network, and therefore fields like 'Pricebook2Id' are not used in MObjects to refer to references, as you can already access it directly by 'Pricebook.Id'.

Calls of `put(xxx)` will mark the MObject as dirty, and update operation will be carried out for the dirty MObjects during persistence.
