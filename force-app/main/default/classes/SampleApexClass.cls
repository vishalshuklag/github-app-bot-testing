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
}