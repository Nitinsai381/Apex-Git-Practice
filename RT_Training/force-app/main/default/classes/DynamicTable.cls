public with sharing class DynamicTable {
    @AuraEnabled(cacheable = true)
    public static List<DynamicTableWrapper> getData(Id accId , String objectName){
        List<ObjectFieldConfig__mdt> mdtData = [SELECT Field_Config__r.Field_Api_Name__c, Field_Config__r.label from	ObjectFieldConfig__mdt where Object_Config__r.Object_Api_Name__c =:objectName];
        System.debug('metadata' + mdtData);
        List<DynamicTableWrapper> lst = new List<DynamicTableWrapper>();
        List<ObjectFieldConfig__mdt> cols = new  List<ObjectFieldConfig__mdt>();
        lst.add(new DynamicTableWrapper(cols));
       // Map<String , Schema.SObjectField> validfields = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap(); // Map<String, Schema.SObjectType> , Schema.DescribeSObjectResult , Map<String, Schema.SObjectField>
      Map<String, Schema.SObjectType> obj = Schema.getGlobalDescribe();
       Schema.DescribeSObjectResult res = obj.get(objectName).getDescribe();
       Map<String, Schema.SObjectField> validfields = res.fields.getMap();

         Set<String> fields = new Set<String>();
        for(ObjectFieldConfig__mdt data : mdtData){
           String Name = data.Field_Config__r.Field_Api_Name__c;
           if(validfields.containsKey(Name)){
              fields.add(Name);
              cols.add(data);
           }
        }
        // for(ObjectFieldConfig__mdt data : mdtData){
        //     fields.add(data.Field_Config__r.Field_Api_Name__c);
        // }
        System.debug('fields' + fields);
        String query = 'SELECT Id, ' ;
        query += String.join(fields , ',') + ' FROM ' +objectName+ ' WHERE AccountId =: accId ORDER BY LastModifiedDate DESC' ;
        List<SObject> objData = Database.query(query);
        lst.add(new DynamicTableWrapper(objData));
        System.debug('objects' + objData);
        System.debug('query' + query);

        return lst;
    }

}