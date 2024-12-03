public class ReparentingCustomObj extends ReparentingLookupRecords {

   public override void doReparenting(Id parentId, List<Id> childIds){
        List<PlatformDemo__c> customList = [SELECT Id , Contact__c FROM PlatformDemo__c WHERE Id In :childIds ];
        for(PlatformDemo__c demo : customList){
            demo.Contact__c = parentId ;
        }
        if(!customList.isEmpty()){
            update customList ;
        }
     //    Schema.SObjectType parentSObjectType = parentId.getSObjectType();
     //    String objectName = parentSObjectType.getDescribe().getName();
     //     Map<String, Schema.SObjectField> validLookup = getFieldsByObjectType( objectName ,childIds[0].getSobjectType());
    }
}