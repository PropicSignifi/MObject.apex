---
title: "Persistence"
description: "Persistence"
buttonTitle: "Done"
parentId: "getting_started"
layout: "tutorial"
time: 90
weight: 6
---

## {$page.title}

Carrying out persistence is only one call and MObject.apex will do everything for you behind the scene.

```javascript
Pricebook2 pb = [ ... ];
MObject mo = MObject.create(pb);
mo.put('Opportunities', new List<Opportunity>{ ... });
mo.persist();
```

Or you can persist a list of MObjects at one time.

```javascript
List<MObject> mos = MObject.createList(new List<SObject>{ ... });
MObject.persist(mos);
```
