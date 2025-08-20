public with sharing class SecurityRules {
    
    public void apexBadCrypto() {
        Blob hardCodedIV = Blob.valueOf('Hardcoded IV 123');
        Blob hardCodedKey = Blob.valueOf('0000000000000000');
        Blob data = Blob.valueOf('Data to be encrypted');
        Blob encrypted = Crypto.encrypt('AES128', hardCodedKey, hardCodedIV, data);
    }

    public void soqlInjection(String t1) {
        Database.query('SELECT Id FROM Account' + t1);
    }

    public void usingNamedCredentials(String username, String password) {
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
    }

    public Contact apexCrudViolations(String status, String ID) {

        // validate you can actually query what you intend to retrieve
        Contact c = [SELECT Status__c FROM Contact WHERE Id=:ID WITH SECURITY_ENFORCED];

        // Make sure we can update the database before even trying
        if (!Schema.sObjectType.Contact.fields.Status__c.isUpdateable()) {
            return null;
        }

        c.Status__c = status;
        update as system c;
        return c;
    }
}