---
title: "Functional Support"
description: "Functional Support"
buttonTitle: "Done"
parentId: "getting_started"
layout: "tutorial"
time: 90
weight: 8
---

## {$page.title}

MObject.apex has builtin functional support. We can use functional chaining like this:

```javascript
MObject.create(pb)
    .put('Name', 'new pricebook')
    .put('Opportunities', new List<Opportunity>{ ... })
    .persist();
```
