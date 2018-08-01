---
title: "Namespace Free"
description: "Namespace Free"
buttonTitle: "Done"
parentId: "getting_started"
layout: "tutorial"
time: 90
weight: 7
---

## {$page.title}

When specifying the field names in MObject.apex, we don't need to consider the namespaces, as they are taken care of. MObject.apex will detect the namespace for us.

```javascript
Pricebook2 pb = [ ... ];
MObject mo = MObject.create(pb);
mo.put('Code__c', 'New code');
// Equivalent to this
mo.put('yourapp__Code__c', 'New code');
```
