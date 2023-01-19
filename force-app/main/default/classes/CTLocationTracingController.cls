public with sharing class CTLocationTracingController {
    public static List<Location_Tracing__c> getVisitors(String locationId){
        return [SELECT Id, Name, Person__c, Location__c, Visit_Date__c FROM Location_Tracing__c WHERE Location__r.Id=:locationId AND Visit_Date__c=LAST_N_DAYS:10];
    }

    public static List<Location_Tracing__c> getLocationsByPersonIds(Set<Id> personIds){
        return [SELECT Id, Name, Person__c, Location__c, Visit_Date__c FROM Location_Tracing__c WHERE Person__r.Id IN :personIds AND Visit_Date__c=LAST_N_DAYS:10];
    }

    public static List<Location_Tracing__c> getLocationIds(Set<Id> locationsIds){
        return [SELECT Id, Name, Person__c, Location__c, Visit_Date__c FROM Location_Tracing__c 
                    WHERE Location__r.Id IN :locationsIds 
                        AND Person__r.Health_Status__c='Green' 
                        AND Visit_Date__c=LAST_N_DAYS:10];
    }
}