public with sharing class SampleApexClass {
    public SampleApexClass() {
        List<Account> accountList = [SELECT Id,Name,AccountNumber, BillingCity, Phone, Mobile, Fax FROM Account LIMIT 10000];
        if(accountList.size()>0){beak;}else{continue;}
    }
}