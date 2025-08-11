public interface TriggerHandler {
    void beforeInsert(List&lt;SObject> newRecords);
    void beforeUpdate(List&lt;SObject> oldRecords, List&lt;SObject> newRecords, Map&lt;ID, SObject> oldRecordMap, Map&lt;ID, SObject> newRecordMap);
    void beforeDelete(List&lt;SObject> oldRecords, Map&lt;ID, SObject> oldRecordMap);
    void afterInsert(List&lt;SObject> newRecords, Map&lt;ID, SObject> newRecordMap);
    void afterUpdate(List&lt;SObject> oldRecords, List&lt;SObject> newRecords, Map&lt;ID, SObject> oldRecordMap, Map&lt;ID, SObject> newRecordMap);
    void afterDelete(List&lt;SObject> oldRecords, Map&lt;ID, SObject> oldRecordMap);
    void afterUndelete(List&lt;SObject> newRecords, Map&lt;ID, SObject> newRecordMap);
}