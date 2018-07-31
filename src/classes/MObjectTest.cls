/**
 * MIT License
 *
 * Copyright (c) 2018 Click to Cloud Pty Ltd
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 **/
@isTest
private class MObjectTest {
    static {
        Pricebook2 pb = new Pricebook2(Name='test price book');
        insert pb;

        Opportunity op = new Opportunity(Name='test opportunity', StageName='Prospecting', CloseDate=Date.today().addDays(30));
        op.Pricebook2Id = pb.Id;
        insert op;
    }

    @isTest
    private static void testCreate() {
        MObject mo1 = MObject.create(Pricebook2.sObjectType, new Map<String, Object>{
            'Name' => 'test price book'
        });
        System.assert(mo1 != null);

        Pricebook2 pb = [ SELECT Id, (SELECT Id, Name FROM Opportunities) FROM Pricebook2 WHERE Name = 'test price book' ];
        MObject mo2 = MObject.create(pb);
        System.assert(mo2 != null);

        MObject mo3 = MObject.create(mo2);
        System.assert(mo3 != null);
    }

    @isTest
    private static void testToMap() {
        Pricebook2 pb = [ SELECT Id, (SELECT Id, Name FROM Opportunities) FROM Pricebook2 WHERE Name = 'test price book' ];
        MObject mo = MObject.create(pb);
        Map<String, Object> result = mo.toMap(true);
        System.assert(result.get('Opportunities') != null);
    }

    @isTest
    private static void testReference() {
        Opportunity op = [ SELECT Id, Name, Pricebook2.Id, Pricebook2.Name FROM Opportunity WHERE Name = 'test opportunity' ];
        MObject mo = MObject.create(op);
        System.assertEquals(mo.get('Name'), 'test opportunity');
        System.assertEquals(mo.get('Pricebook2.Name'), 'test price book');
    }

    @isTest
    private static void testUpdateReference() {
        Opportunity op = [ SELECT Id, Name, Pricebook2.Id, Pricebook2.Name FROM Opportunity WHERE Name = 'test opportunity' ];
        MObject mo = MObject.create(op);
        mo.put('Pricebook2.Name', 'New price book');
        mo.persist();

        op = [ SELECT Id, Name, Pricebook2.Id, Pricebook2.Name FROM Opportunity WHERE Name = 'test opportunity' ];
        mo = MObject.create(op);
        System.assertEquals(mo.get('Pricebook2.Name'), 'New price book');

        MObject mo1 = MObject.create('Pricebook2', new Map<String, Object>{
            'Name' => 'Mock Pricebook'
        });
        mo.put('Pricebook2', mo1);
        mo.put('Name', 'New Name');
        mo.persist();

        op = [ SELECT Id, Name, Pricebook2.Id, Pricebook2.Name FROM Opportunity WHERE Name = 'New Name' ];
        mo = MObject.create(op);
        System.assertEquals(mo.get('Pricebook2.Name'), 'Mock Pricebook');
    }

    @isTest
    private static void testInsertReference() {
        MObject mo1 = MObject.create('Pricebook2', new Map<String, Object>{
            'Name' => 'Mock Pricebook'
        });
        MObject mo = MObject.create(Opportunity.sObjectType, new Map<String, Object>{
            'Name' => 'Mock Opportunity',
            'StageName' => 'Prospecting',
            'CloseDate' => Date.today().addDays(30)
        });
        mo.put('Pricebook2', mo1);
        mo.persist();

        Opportunity op = [ SELECT Id, Name, Pricebook2.Id, Pricebook2.Name FROM Opportunity WHERE Name = 'Mock Opportunity' ];
        mo = MObject.create(op);
        System.assertEquals(mo.get('Name'), 'Mock Opportunity');
        System.assertEquals(mo.get('Pricebook2.Name'), 'Mock Pricebook');
    }

    @isTest
    private static void testIdentity() {
        Opportunity op = [ SELECT Id, Name, Pricebook2.Id, Pricebook2.Name FROM Opportunity WHERE Name = 'test opportunity' ];
        MObject mo1 = MObject.create(op);
        MObject mo2 = MObject.create(op);
        System.assertEquals(mo1.toString(), mo2.toString());
    }

    @isTest
    private static void testGet() {
        Pricebook2 pb = [ SELECT Id, (SELECT Id, Name FROM Opportunities) FROM Pricebook2 WHERE Name = 'test price book' ];
        MObject mo = MObject.create(pb);
        System.assertEquals(mo.get('Opportunities.0.Name'), 'test opportunity');
    }

    @isTest
    private static void testPut() {
        Pricebook2 pb = [ SELECT Id, (SELECT Id, Name FROM Opportunities) FROM Pricebook2 WHERE Name = 'test price book' ];
        MObject mo = MObject.create(pb);
        mo.put('Opportunities.0.Name', 'new name');
        System.assertEquals(mo.get('Opportunities.0.Name'), 'new name');
    }

    @isTest
    private static void testMarkDelete() {
        Pricebook2 pb = [ SELECT Id, (SELECT Id, Name FROM Opportunities) FROM Pricebook2 WHERE Name = 'test price book' ];
        MObject mo = MObject.create(pb);
        mo.markDeleted(true);

        MObject child = (MObject)mo.get('Opportunities.0');
        System.assert(child.isDeleted());
    }

    @isTest
    private static void testPersist() {
        MObject mo = MObject.create('Pricebook2', new Map<String, Object>{
            'Name' => 'Mock Pricebook'
        });
        MObject mo1 = MObject.create(Opportunity.sObjectType, new Map<String, Object>{
            'Name' => 'Mock Opportunity',
            'StageName' => 'Prospecting',
            'CloseDate' => Date.today().addDays(30)
        });
        mo.put('Opportunities', new List<MObject>{ mo1 });
        mo.persist();

        Pricebook2 pb = [ SELECT Id, Name, (SELECT Id, Name FROM Opportunities) FROM Pricebook2 WHERE Name = 'Mock Pricebook' ];
        mo = MObject.create(pb);
        System.assert(mo != null);
        System.assert(mo.get('Opportunities') != null);

        mo.put('Name', 'New Pricebook');
        mo.put('Opportunities.0.Name', 'New Opportunity');
        mo.persist();

        pb = [ SELECT Id, Name, (SELECT Id, Name FROM Opportunities) FROM Pricebook2 WHERE Name = 'New Pricebook' ];
        mo = MObject.create(pb);
        System.assert(mo != null);
        System.assertEquals(mo.get('Opportunities.0.Name'), 'New Opportunity');

        mo.markDeleted(true);
        mo.persist();

        List<Pricebook2> pbs = [ SELECT Id, Name, (SELECT Id, Name FROM Opportunities) FROM Pricebook2 WHERE Name = 'New Pricebook' ];
        System.assert(pbs.isEmpty());
    }
}
