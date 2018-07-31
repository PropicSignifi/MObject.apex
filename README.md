# MObject.apex
MObject.apex is a library to take care of persisting SObjects.

## Why MObject.apex?
Usually when we do insertion/update/deletion on multiple SObjects that correlate each other, we need to sort out the DML operations and batch them. Sometimes this turns to be a pain point. MObject.apex is created to resolve this by taking care of the SObject persistence for you. It uses MObjects, the peer of SObjects, to track all the changes and flushes all the changes to DML operations in one run.

## Dependencies
MObject.apex has a dependency over [R.apex](https://github.com/Click-to-Cloud/R.apex/) .

Please include it before including MObject.apex.

## Preliminary Knowledge
MObject.apex has a dependency over R.apex, so that it can fully integrate with functional programming. You don't need any knowledge of R.apex to start using MObject.apex, though.

## Getting Started

### Create MObjects
MObjects are peers of SObjects, and we can create MObjects in multiple ways.

```java
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

### Manipuate MObjects
MObjects are designed to be easy to use. You can easily access the fields of the MObjects.

```java
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

### Delete MObjects
You cannot directly delete MObjects. You can only mark them as deleted, so that deletion operation will be carried out on them during persistence.

```java
Pricebook2 pb = [ ... ];
MObject mo = MObject.create(pb);
mo.markDeleted();
```

You can mark an MObject as cascading delete, and this will in turn mark all the children MObjects to be deleted.

```java
Pricebook2 pb = [ ... ];
MObject mo = MObject.create(pb);
// All referencing opportunities will be marked as deleted
mo.markDeleted(true);
```

### Persistence
Carrying out persistence is only one call and MObject.apex will do everything for you behind the scene.

```java
Pricebook2 pb = [ ... ];
MObject mo = MObject.create(pb);
mo.put('Opportunities', new List<Opportunity>{ ... });
mo.persist();
```

Or you can persist a list of MObjects at one time.

```java
List<MObject> mos = MObject.createList(new List<SObject>{ ... });
MObject.persist(mos);
```

### Namespace Free
When specifying the field names in MObject.apex, we don't need to consider the namespaces, as they are taken care of. MObject.apex will detect the namespace for us.

```java
Pricebook2 pb = [ ... ];
MObject mo = MObject.create(pb);
mo.put('Code__c', 'New code');
// Equivalent to this
mo.put('yourapp__Code__c', 'New code');
```

### Functional Support
MObject.apex has builtin functional support. We can use functional chaining like this:

```java
MObject.create(pb)
    .put('Name', 'new pricebook')
    .put('Opportunities', new List<Opportunity>{ ... })
    .persist();
```

