public with sharing class CTLocationController {
    public static List<Location__c> getRecentStatusChanges(){
        return [SELECT Id, name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c FROM Location__c ORDER BY Status_Update_Date__c DESC NULLS LAST LIMIT 100];
    }

    public static List<Location__c> searchLocations(String searchTerm){
        searchTerm = searchTerm + '%';
        return [SELECT Id, name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c FROM Location__c 
            WHERE Name like :searchTerm 
                OR Pincode__c like :searchTerm
                OR Address__c like :searchTerm
            ORDER BY Status_Update_Date__c DESC ];
    }

    public static Location__c getLocationById(String locationId){
        List<Location__c> loc = [SELECT Id, name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c FROM Location__c WHERE Id=:locationId];
        if(loc != null && loc.size() > 0){
            return loc[0];
        }

        return null;
    }

    public static Map<String,Integer> getStatusCount(){
        Map<String,Integer> statusCountMap = new Map<String,Integer>();

        for(AggregateResult ar : [SELECT Status__c, Count(Id) total FROM Location__c GROUP BY Status__c]){
            String status = String.valueOf(ar.get('Status__c'));
            Integer count = Integer.valueOf(ar.get('total'));
            statusCountMap.put(status, count);
        }
        return statusCountMap;
    }
}