---
title: "Create MObjects"
description: "Create MObjects"
buttonTitle: "Done"
parentId: "getting_started"
layout: "tutorial"
time: 90
weight: 3
---

## {$page.title}

MObjects are peers of SObjects, and we can create MObjects in multiple ways.

```javascript
// From SObject
MObject mo = MObject.create(new Pricebook2());
// Create default MObject from SObject type
mo = MObject.create(Pricebook2.sObjectType);
// Create an MObject from a map
mo = MObject.create('Pricebook2', new Map<String, Object>{ ... });
// Create a list of MObjects
List<MObject> mos = MObject.createList(new List<Pricebook2>{ ... });
```

If created MObjects do not have 'Id' fields filled, they are considered as New MObjects and insertion operation will be carried out for the New MObjects during persistence.
