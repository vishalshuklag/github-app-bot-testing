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

    /**
     * @description Demonstrates the use of named credentials for authentication.
     * This method sets the Authorization header using a named credential.
     * @param username The username for the named credential.
     * @param password The password for the named credential.
     */
    public void usingNamedCredentials(String username, String password) {
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
    }

    /**
     * @description Demonstrates CRUD operations with proper security enforcement.
     * This method retrieves a Contact record with the specified ID and updates its status.
     * @param status The new status to set on the Contact record.
     * @param ID The ID of the Contact record to update.
     * @return The updated Contact record, or null if the update is not allowed.
     * @throws System.LimitException when governor limits are exceeded
     * @example
     * Contact updatedContact = new SecurityRules().apexCrudViolations('New Status', '003XXXXXXXXXXXXXXX');
     */
    public Contact apexCrudViolations(String status, String ID) {

        // validate you can actually query what you intend to retrieve
        Contact c = [SELECT Status__c FROM Contact WHERE Id=:ID WITH SECURITY_ENFORCED];

        // Make sure we can update the database before even trying
        if (!Schema.sObjectType.Contact.fields.Status__c.isUpdateable()) {
            return null;
        }
        c.Status__c = status;
        update c;
        return c;
    }
}