---
title: "MObject"
description: "MObject"
layout: "guide"
icon: "flash"
weight: 1
---

###### {$page.description}

<article id="1">

## What is an MObject?

MObjects are short for Managed Objects, peer of SObjects. MObjects have similar data as SObjects.

The difference between MObjects and SObjects is that MObjects track the changes and will flush the changes to persistence later.

| Aspect | MObject | SObject |
| ------ | ------- | ------- |
| Field Access | Support nested field access through method calls | Direct field access through '.' |
| Field Update | Support field update through method calls | Reference and relationship fields cannot be updated directly |
| DML Operations | Can be done in one method call | Have to sort out SObjects before doing DML operations |

</article>

<article id="2">

## Principals

MObjects are used to facilitate DML operations on SObjects.

Recommended usages are complicated DML operations spread in multiple SObjects.

Example:

```javascript
MObject mpb = MObject.create(new Pricebook2());
mpb.put('Name', 'Price Book');

MObject mop = MObject.create(new Opportunity());
mop.put('Name', 'Opportunity');
mop.put('Pricebook2', mpb);
mop.persist();
```

</article>

<article id="3">

## Object Network

MObjects attempt to maintain an object network and usages through object access is promoted.

This means that the lookup fields of SObjects will not be managed in MObjects. Instead, they
are contained in managing the reference objects.

```javascript
MObject mop = MObject.create(new Opportunity());
mop.put('Name', 'Opportunity');
mop.put('Pricebook2', mpb);
```

</article>

<article id="4">

## How MObjects are Managed

MObjects have some status fields to indicate the future DML operations on them.

If the MObjects are marked as deleted, deletion operation will be carried on them.

If the MObjects are marked as dirty, update operation will be carried on them.

If the MObjects have no Ids on them, insertion operation will be carried on them.

</article>

<article id="5">

## Managed Persistence

Below is the process of managed persistence.

1. A list of MObjects are accepted to be put into persistence.

2. Traverse the MObjects to find the ones to be deleted.

3. Perform deletion operations.

4. Traverse the MObjects to find the ones that can be inserted, without the needs for others' ids.

5. Perform insertion operations on these MObjects.

6. Continue Step.4 until no MObjects to be inserted are found.

7. Traverse the MObjects to find the ones to be updated.

8. Perform update operations.

The DML operations generated are as below:

| Operation Name | Count | Description |
| -------------- | ----- | ----------- |
| Insert | 0 to N | Depends on the complexity of SObjects referencing each other |
| Delete | 0 to 1 | All SObjects are deleted in one DML call |
| Update | 0 to 1 | All SObjects are updated in one DML call |

</article>
