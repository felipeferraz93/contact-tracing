public with sharing class PersonTriggerHandler {
    public static void beforeInsertHandler(List<Person__c> newRecords){
        for(Person__c p : newRecords){
            p.Health_Status__c = 'Green';
            p.Token__c = CTPersonController.getToken(p.Mobile__c);
        }
        return;
    }

    public static void beforeUpdateHandler(List<Person__c> newRecords, Map<Id, Person__C> oldRecords){
        for(Person__c p : newRecords){
            if(p.Health_Status__c != oldRecords.get(p.Id).Health_Status__c){
                p.Status_Update_Date__c = Date.today();
            }
        }
        return;
    }
}