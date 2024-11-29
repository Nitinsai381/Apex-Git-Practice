public with sharing class ReparentingEventHandler {
    public static void  handleReparenting(List<ReparentingRecord__e> eventList) {
        // System.debug(eventList);
        // Map<Id , Map<String , List<Id>>> data = new Map<Id , Map<String , List<Id>>>();
        // for(ReparentingRecord__e event : eventList){
        //     if(event.ChildId__c != null && event.ParentId__c != null && event.ClassName__c != null){
        //         String classname = event.ClassName__c;
        //         Id parentid = event.ParentId__c ;
        //         List<Id> childIds = (List<Id>) JSON.deserialize(event.ChildId__c , List<Id>.class);
        //     data.put(event.ParentId__c , new Map<String , List<Id>>());
        //     data.get(event.ParentId__c).put(classname , childIds);
        //     ReparentingLookupRecords instance = (ReparentingLookupRecords) Type.forName(classname).newInstance();
            //instance.doReparenting(data);

            for(ReparentingRecord__e event : eventList){
                if(event.ChildId__c != null && event.ParentId__c != null && event.ClassName__c != null){
                    String classname = event.ClassName__c;
                    Id parentid = event.ParentId__c ;
                    List<Id> childIds = (List<Id>) JSON.deserialize(event.ChildId__c , List<Id>.class);
                    ReparentingLookupRecords instance = (ReparentingLookupRecords) Type.forName(classname).newInstance();
                    instance.doReparenting(parentid , childIds);
            }
        }
    }






        // for(ReparentingRecord__e event : eventList){
        //     Id parentId  = event.ParentId__c;
        //     List<Id> childIds = (List<Id>) JSON.deserializeUntyped(event.ChildId__c);
        //     System.debug('eventlist' + eventList);
        //     ReparentingLookupRecords instance =  handleInstantiate(event.ClassName__c);
        //     instance.doReparenting(parentId , childIds);
        // }
    //}
    // private static ReparentingLookupRecords handleInstantiate(String className){
    //     if(className == 'ReparentingContacts'){
    //         return new ReparentingContacts();
    //     } else if(className == 'ReparentingCustomObj'){
    //         return new ReparentingCustomObj();
    //     }else {
    //         return null;
    //     }
    // }
}