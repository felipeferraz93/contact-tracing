public with sharing class CTPersonController {

    public static String getToken(String mobileNo){
        Blob targetBlob = Blob.valueOf(mobileNo);
        Blob hash = Crypto.generateDigest('MD5', targetBlob);

        return EncodingUtil.base64Encode(hash);
    }

    public static List<Person__c> getRecentHealthChanges(){
        return [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c FROM Person__C ORDER BY Status_Update_Date__c DESC LIMIT 100];
    }

    public static List<Person__c> searchPeople(String searchTerm){
        searchTerm = searchTerm + '%';
        return [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c 
            FROM Person__C 
            WHERE Name LIKE :searchTerm 
                OR Mobile__c LIKE :searchTerm 
                OR Token__c LIKE :searchTerm
            ORDER BY Status_Update_Date__c DESC NULLS LAST];
    }

    public static Person__c getPersonById(String personId){
        return [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c FROM Person__C WHERE Id=:personId LIMIT 1];
    }

}