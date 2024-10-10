public with sharing class DynamicTable {
    @AuraEnabled(cacheable = true)
    public static List<DynamicTableWrapper> getData(Id accId , String objectName){
        List<ObjectFieldConfig__mdt> mdtData = [SELECT Field_Config__r.Field_Api_Name__c, Field_Config__r.label from	ObjectFieldConfig__mdt where Object_Config__r.Object_Api_Name__c =:objectName];
        System.debug('metadata' + mdtData);
        List<DynamicTableWrapper> lst = new List<DynamicTableWrapper>();
        lst.add(new DynamicTableWrapper(mdtData));
        Set<String> fields = new Set<String>();
        for(ObjectFieldConfig__mdt data : mdtData){
            fields.add(data.Field_Config__r.Field_Api_Name__c);
        }
        System.debug('fields' + fields);
        String query = 'SELECT Id, ' ;
        query += String.join(fields , ',') + ' FROM ' +objectName+ ' WHERE AccountId =: accId' ;
        List<SObject> objData = Database.query(query);
        lst.add(new DynamicTableWrapper(objData));
        System.debug('objects' + objData);
        System.debug('query' + query);

        return lst;
    }

}