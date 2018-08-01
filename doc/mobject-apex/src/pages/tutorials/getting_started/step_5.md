---
title: "Delete MObjects"
description: "Delete MObjects"
buttonTitle: "Done"
parentId: "getting_started"
layout: "tutorial"
time: 90
weight: 5
---

## {$page.title}

You cannot directly delete MObjects. You can only mark them as deleted, so that deletion operation will be carried out on them during persistence.

```javascript
Pricebook2 pb = [ ... ];
MObject mo = MObject.create(pb);
mo.markDeleted();
```

You can mark an MObject as cascading delete, and this will in turn mark all the children MObjects to be deleted.

```javascript
Pricebook2 pb = [ ... ];
MObject mo = MObject.create(pb);
// All referencing opportunities will be marked as deleted
mo.markDeleted(true);
```
