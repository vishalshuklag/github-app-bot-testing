/**
 * @description Demonstrates various Salesforce performance anti-patterns and governor limit violations.
 * This class serves as an educational example of what NOT to do in Apex development.
 * Each method illustrates common mistakes that can lead to poor performance or runtime exceptions.
 * 
 * @author GitHub Copilot
 * @since API Version 58.0
 */
public with sharing class PerformanceRules {

    /**
     * @description Demonstrates non-restrictive SOQL queries that can hit governor limits.
     * Shows the difference between unrestricted queries (bad) and limited queries (better).
     * Also includes an example of overly broad SOSL queries.
     * 
     * @example
     * PerformanceRules.avoidNonRestrictiveQueries();
     */
    public static void avoidNonRestrictiveQueries( ) {
        Account[] accs1 = [ select id from account ];  // Bad
        Account[] accs2 = [ select id from account limit 10 ];  // better

        List<List<SObject>> searchList = [FIND 'map*' IN ALL FIELDS RETURNING Account (Id, Name), Contact, Opportunity, Lead]; // bad
    }
 
    /**
     * @description Anti-pattern: Performs DML operations inside a loop using Database methods.
     * This approach will hit governor limits when processing large datasets.
     * 
     * @param accounts List of Account records to insert
     * @throws System.LimitException when DML governor limits are exceeded
     * 
     * @example
     * List<Account> accounts = new List<Account>();
     * // populate accounts list
     * new PerformanceRules().databaseMethodInsideOfLoop(accounts);
     */
    public void databaseMethodInsideOfLoop(List<Account> accounts) {
        for (Account a : accounts) {
            Database.insert(a);
        }
    }

    /**
     * @description Anti-pattern: Performs DML operations inside a loop.
     * This method will fail after 150 iterations due to DML statement governor limits.
     * Demonstrates why bulk DML operations should be performed outside loops.
     * 
     * @throws System.LimitException when DML governor limits (150 statements) are exceeded
     * 
     * @example
     * new PerformanceRules().dmlInsideOfLoop();
     */
    public void dmlInsideOfLoop() {
        for (Integer i = 0; i < 151; i++) {
            Account account;
            // ...
            insert as system account;
        }
    }

    /**
 * @description Anti-pattern: Executes SOQL queries inside a loop.
 * This approach will hit the 100 SOQL query limit quickly and cause runtime exceptions.
 * Demonstrates why data should be queried once and processed in bulk.
 * 
 * @throws System.LimitException when SOQL query governor limits are exceeded
 * 
 * @example
 * new PerformanceRules().soqlInsideOfLoop();
 */
    public void soqlInsideOfLoop() {
        for (Integer i = 0; i < 10; i++) {
            List<Account> accounts = [SELECT Id FROM Account];
        }
    }

    /**
 * @description Anti-pattern: Executes SOSL searches inside a loop.
 * This approach will hit governor limits and cause poor performance.
 * SOSL searches should be performed outside of loops and results cached.
 * 
 * @throws System.LimitException when SOSL search governor limits are exceeded
 * 
 * @example
 * new PerformanceRules().soslInsideOfLoop();
 */
    public void soslInsideOfLoop() {
        for (Integer i = 0; i < 10; i++) {
            List<List<SObject>> searchList = [FIND 'map*' IN ALL FIELDS RETURNING Account (Id, Name), Contact, Opportunity, Lead];
        }
    }

    /**
 * @description Anti-pattern: Sends email messages inside a loop.
 * This approach will hit email invocation limits and cause runtime exceptions.
 * Email operations should be bulkified outside of loops.
 * 
 * @throws System.LimitException when email invocation limits are exceeded
 * 
 * @example
 * new PerformanceRules().messageInsideOfLoop();
 */
    public void messageInsideOfLoop() {
        for (Integer i = 0; i < 10; i++) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
        }
    }

    /**
 * @description Anti-pattern: Performs approval processes inside a loop.
 * This demonstrates multiple approval operations that should be bulkified.
 * Each approval operation counts against governor limits.
 * 
 * @param accs List of Account records to process for approval
 * @throws System.LimitException when approval process limits are exceeded
 * 
 * @example
 * List<Account> accounts = [SELECT Id FROM Account LIMIT 10];
 * new PerformanceRules().approvalInsideOfLoop(accounts);
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
     * @description Anti-pattern: Enqueues asynchronous jobs inside a loop.
     * This approach will quickly hit limits for queueable jobs, scheduled jobs, and batch jobs.
     * Asynchronous operations should be carefully managed to avoid governor limits.
     * 
     * @throws System.LimitException when asynchronous job limits are exceeded
     * 
     * @example
     * new PerformanceRules().asyncInsideOfLoop();
     */
    public void asyncInsideOfLoop() {
        for (Integer i = 0; i < 10; i++) {
            System.enqueueJob(new MyQueueable());
            System.schedule('x', '0 0 0 1 1 ?', new MySchedule());
            System.scheduleBatch(new MyBatch(), 'x', 1);
        }
    }

    /**
     * @description Demonstrates proper use of deferred describe calls to improve performance.
     * Uses SObjectDescribeOptions.DEFERRED to avoid eagerly loading describe information
     * until it's actually needed, which can improve performance in some scenarios.
     * 
     * @param accounts List of Account records to potentially insert
     * 
     * @example
     * List<Account> accounts = new List<Account>();
     * // populate accounts list
     * PerformanceRules.eagerlyLoadedDescribeSObjectResult(accounts);
     */

    public static void eagerlyLoadedDescribeSObjectResult(List<Account> accounts) {
        if (Account.SObjectType.getDescribe(SObjectDescribeOptions.DEFERRED).isCreateable()) {
            insert accounts;
        }
    }
}