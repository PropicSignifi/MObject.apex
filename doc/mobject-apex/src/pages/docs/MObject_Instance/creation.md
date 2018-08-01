---
title: "Creation Methods"
description: "Creation methods of MObjects"
layout: "guide"
icon: "cloud"
weight: 1
---

###### {$page.description}

<article id="1">

## create

Static methods to create MObject instances.

```javascript
MObject mo = MObject.create(Pricebook2.sObjectType, new Map<String, Object>());
```

Methods are as below:

| Name | Description |
| ---- | ----------- |
| create(Schema.SObjectType, Object) | Create an MObject from SObject type and source |
| create(Schema.SObjectType) | Create a default MObject from SObject type |
| create(String, Object) | Create an MObject from type name and source |
| create(String) | Create a default MObject from type name |
| create(Object) | Create an MObject from source |

</article>

<article id="2">

## createList

Static methods to create a list of MObject instances.

```javascript
List<MObject> mos = MObject.createList(Pricebook2.sObjectType, new List<Map<String, Object>>());
```

Methods are as below:

| Name | Description |
| ---- | ----------- |
| createList(Schema.SObjectType, List&lt;Object&gt;) | Create MObjects from SObject type and list of objects |
| createList(String, List&lt;Object&gt;) | Create MObjects from type name and list of objects |
| createList(List&lt;Object&gt;) | Create MObjects from list of objects |

</article>
