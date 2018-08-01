---
title: "Methods"
description: "methods of MObjects"
layout: "guide"
icon: "cloud"
weight: 3
---

###### {$page.description}

<article id="1">

## toMap

Convert the MObject to a map

```javascript
MObject mo = MObject.create(new Pricebook2(Name='pricebook'));
Map<String, Object> data = mo.toMap(true);
```

| Name | Description |
| ---- | ----------- |
| toMap(Boolean) | Convert to map, whether to trim namespace |
| toMap() | Convert to map, keeping namespace |

</article>

<article id="2">

## get

Get the value from MObjects

```javascript
MObject mo = MObject.create(new Pricebook2(Name='pricebook'));
String name = (String)mo.get('LastModifiedBy.Name', 'Unknown');
```

| Name | Description |
| ---- | ----------- |
| get(String, Object) | Get the value of the path, returning default value if null |
| get(String) | Get the value of the path |
| get(List&lt;String&gt;, Object) | Get the value of the path, returning default value if null |
| get(List&lt;String&gt;) | Get the value of the path |

</article>

<article id="3">

## put

Update the value of the MObjects

```javascript
MObject mo = MObject.create(new Pricebook2(Name='pricebook'));
mo.put('LastModifiedBy.Name', 'Wilson');
```

| Name | Description |
| ---- | ----------- |
| put(String, Object) | Update the value of the path |
| put(List&lt;String&gt;, Object) | Update the value of the path |

</article>

<article id="4">

## markAsDeleted

Mark the MObjects as deleted

```javascript
MObject mo = MObject.create(new Pricebook2(Name='pricebook'));
mo.markDeleted(true);
```

| Name | Description |
| ---- | ----------- |
| markAsDeleted() | Mark the MObject as deleted |
| markAsDeleted(Boolean) | Mark the MObject as deleted, cascadingly |

</article>

<article id="5">

## isDirty

Check if the MObject is dirty

```javascript
MObject mo = MObject.create(new Pricebook2(Name='pricebook'));
Boolean dirty = mo.isDirty();
```

</article>

<article id="6">

## isDeleted

Check if the MObject is marked as deleted

```javascript
MObject mo = MObject.create(new Pricebook2(Name='pricebook'));
Boolean deleted = mo.isDeleted();
```

</article>

<article id="7">

## persist

Persist the MObject

```javascript
MObject mo = MObject.create(new Pricebook2(Name='pricebook'));
mo.put('Name', 'new name');
mo.persist();

List<MObject> mos = MObject.createList(new List<Pricebook2>());
for(MObject mo : mos) {
    mo.put('Name', 'new name');
}
MObject.persist(mos);
```

</article>
