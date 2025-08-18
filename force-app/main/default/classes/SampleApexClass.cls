public class SampleApexClass {
    public SampleApexClass() {
        List<Account> accountList = [SELECT Id,Name,AccountNumber, BillingCity, Phone, Mobile, Fax FROM Account LIMIT 10000];
        if(accountList.size()>0){beak;}else{continue;}
    }

    public static void name() {
        Integer i = 0;
        while (i < 5) {
            insert new Account(Name='Test Account ' + i);
            i++;
        }
    }

    public void databaseMethodInsideOfLoop(List<Account> accounts) {
        for (Account a : accounts) {
            Database.insert(a);
        }
    }

    public void dmlInsideOfLoop() {
        for (Integer i = 0; i < 151; i++) {
            Account account;
            // ...
            insert account;
        }
    }

    public void soqlInsideOfLoop() {
        for (Integer i = 0; i < 10; i++) {
            List<Account> accounts = [SELECT Id FROM Account];
        }
    }

    public void soslInsideOfLoop() {
        for (Integer i = 0; i < 10; i++) {
            List<List<SObject>> searchList = [FIND 'map*' IN ALL FIELDS RETURNING Account (Id, Name), Contact, Opportunity, Lead];
        }
    }

    public void messageInsideOfLoop() {
        for (Integer i = 0; i < 10; i++) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
        }
    }

    public void approvalInsideOfLoop(Account[] accs) {
        for (Integer i = 0; i < 10; i++) {
            Account acc = accs[i];
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setObjectId(acc.Id);
            Approval.process(req);
            Approval.lock(acc);
            Approval.unlock(acc);
        }
    }

    public void asyncInsideOfLoop() {
        for (Integer i = 0; i < 10; i++) {
            System.enqueueJob(new MyQueueable());
            System.schedule('x', '0 0 0 1 1 ?', new MySchedule());
            System.scheduleBatch(new MyBatch(), 'x', 1);
        }
    }

    public void getGlobalDescribeInLoopCorrected() {
        Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
        Set<String> fieldNameSet = new Set<String> {'Id'};
        for (String fieldNameOrDefaultValue : fieldNameOrDefaultValueList) {
            if (fieldMap.containsKey(fieldNameOrDefaultValue.trim())) {
                fieldNameSet.add(fieldNameOrDefaultValue);
            }
        }
    }

    public void describeSObjectsInLoop() {
        Map<String, Schema.SObjectField> fieldMap = Schema.describeSObjects(new List<String> { 'Account' })[0].fields.getMap();
        Set<String> fieldNameSet = new Set<String> {'Id'}
        for (String fieldNameOrDefaultValue : fieldNameOrDefaultValueList) {
            if (fieldMap.containsKey(fieldNameOrDefaultValue.trim())) {
                fieldNameSet.add(fieldNameOrDefaultValue);
            }
        }
    }
}