---
title: "Funcs"
description: "MObject Funcs"
layout: "guide"
icon: "code-file"
weight: 2
---

###### {$page.description}

<article id="1">

## create

Create an instance of MObject

```javascript
MObject mo = (MObject)MObject.F.create.run(new Pricebook2(Name='test'));
```

</article>

<article id="2">

## toMap

Convert the MObject to map

```javascript
 Map<String, Object> data = (Map<String, Object>)MObject.F.toMap.run(false, mo);
```

</article>

<article id="3">

## get

Get the value mapped by the path

```javascript
Object value = MObject.F.get.run('default', 'Name', mo);
```

</article>

<article id="4">

## put

Set the value mapped by the path

```javascript
MObject.F.put.run('Name', 'new Name', mo);
```

</article>

<article id="5">

## markDeleted

Mark the MObject as deleted

```javascript
MObject.F.markDeleted.run(true, mo);
```

</article>

<article id="6">

## persist

Persist the MObject(s)

```javascript
MObject.F.persist.run(mos);
```

</article>
