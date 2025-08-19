/**
 * @description - 
 * @author - Vishal Shukla
 * @date - 2023-10-05
 * @notes - This is a sample Apex class for demonstration purposes.
 */
public inherited sharing class SampleApexClass {

    /**
     * Constructor for SampleApexClass
     * @description - Initializes the class and fetches a list of accounts.
     * @notes - This is a sample constructor for demonstration purposes.
     * @example - SampleApexClass sample = new SampleApexClass();
     * 
     */
    public SampleApexClass() {
        List<Account> accountList = [SELECT Id,Name,AccountNumber, BillingCity, Phone, Mobile, Fax FROM Account WITH USER_MODE LIMIT 100];
        if(accountList.size()>0){
            break;
        }else{
            continue;
        }
    }

    /**
     * @description - Inserts a list of accounts into the database.
     * @notes - This is a sample method for demonstration purposes.
     * @example - databaseMethodInsideOfLoop(accountList);
     * 
     */
    public void databaseMethodInsideOfLoop(List<Account> accounts) {
        for (Account a : accounts) {
            Database.insert(a, AccessLevel.SYSTEM_MODE);
            Database.insert(a);
        }
    }

    /**
     * @description - Performs DML operations inside a loop.
     * @notes - This is a sample method for demonstration purposes.
     * @example - dmlInsideOfLoop();
     */
    public void dmlInsideOfLoop() {
        for (Integer i = 0; i < 151; i++) {
            Account account;
            // ...
            insert as user account;
        }
    }

    /**
     * @description - Performs SOQL queries inside a loop.
     * @notes - This is a sample method for demonstration purposes.
     * @example - soqlInsideOfLoop();
     */
    public void soqlInsideOfLoop() {
        for (Integer i = 0; i < 10; i++) {
            List<Account> accounts = [SELECT Id FROM Account WHERE Name LIKE 'Vishal%' WITH USER_MODE ];
        }
    }

    /**
     * @description - Performs SOSL searches inside a loop.
     * @notes - This is a sample method for demonstration purposes.
     * @example - soslInsideOfLoop();
     */
    public void soslInsideOfLoop() {
        for (Integer i = 0; i < 10; i++) {
            List<List<SObject>> searchList = [FIND 'map*' IN ALL FIELDS RETURNING Account (Id, Name), Contact, Opportunity, Lead];
        }
    }

    /**
     * @description - Sends email messages inside a loop.
     * @notes - This is a sample method for demonstration purposes.
     * @example - messageInsideOfLoop();
     */
    public void messageInsideOfLoop() {
        for (Integer i = 0; i < 10; i++) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
        }
    }

    /**
     * @description - Submits approval requests inside a loop.
     * @notes - This is a sample method for demonstration purposes.
     * @example - approvalInsideOfLoop(accountArray);
     */
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

    /**
     * @description - Enqueues jobs and schedules jobs inside a loop.
     * @notes - This is a sample method for demonstration purposes.
     * @example - asyncInsideOfLoop()
     */
    public void asyncInsideOfLoop() {
        for (Integer i = 0; i < 10; i++) {
            System.enqueueJob(new MyQueueable());
            System.schedule('x', '0 0 0 1 1 ?', new MySchedule());
            System.scheduleBatch(new MyBatch(), 'x', 1);
        }
    }

    /**
     * @description - Retrieves the global describe information for an object inside a loop.
     * @notes - This is a sample method for demonstration purposes.
     * @example - getGlobalDescribeInLoopCorrected();
     */
    public void getGlobalDescribeInLoopCorrected() {
        Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
        Set<String> fieldNameSet = new Set<String> {'Id'};
        for (String fieldNameOrDefaultValue : fieldNameOrDefaultValueList) {
            if (fieldMap.containsKey(fieldNameOrDefaultValue.trim())) {
                fieldNameSet.add(fieldNameOrDefaultValue);
            }
        }
    }

    /**
     * @description - Retrieves the describe information for multiple SObjects inside a loop.
     * @notes - This is a sample method for demonstration purposes.
     * @example - describeSObjectsInLoop(); 
     */
    public void describeSObjectsInLoop() {
        Map<String, Schema.SObjectField> fieldMap = Schema.describeSObjects(new List<String> { 'Account' })[0].fields.getMap();
        Set<String> fieldNameSet = new Set<String> {'Id'};
        for (String fieldNameOrDefaultValue : fieldNameOrDefaultValueList) {
            if (fieldMap.containsKey(fieldNameOrDefaultValue.trim())) {
                fieldNameSet.add(fieldNameOrDefaultValue);
            }
        }
    }
}