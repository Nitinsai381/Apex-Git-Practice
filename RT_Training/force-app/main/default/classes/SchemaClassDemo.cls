public with sharing class SchemaClassDemo {
    public static void getGlobalDiscribeDemo() {
        Map<String , Schema.SObjectType>  globalDiscribe = Schema.getGlobalDescribe();
        System.debug('schema'+ globalDiscribe);
        Schema.DescribeSObjectResult obj = globalDiscribe.get('Account').getDescribe();
        System.debug('account' +obj);
        System.debug('name' +obj.getName());
        System.debug('isupdatable'+obj.isUpdateable());
        System.debug('custom' +obj.isCustom());
        
        Map<String, Schema.SObjectField> fieldMap =globalDiscribe.get('Account').getDescribe().fields.getMap();
        System.debug('fieldMap' +fieldMap);
        List<Schema.ChildRelationship> childList = globalDiscribe.get('Account').getDescribe().getChildRelationships();
        System.debug('childRelation' +childList);
        List<Schema.RecordTypeInfo> recordType = globalDiscribe.get('Contact').getDescribe().getRecordTypeInfos();
        System.debug('recordType' +recordType);
       // System.debug('nameOfRecordType'+recordType.getName());


    }

    public static void describeSObjectDemo(){
        List<String> obj = new List<String>{'Account'};

        List<Schema.DescribeSObjectResult> result = Schema.describeSObjects(obj);
        System.debug('sObjectRes'+result);
    }
}