public  class ReparentingContacts extends ReparentingLookupRecords {
//    override void doReparenting(Id parentId , List<Id> childIds){
//         List<Case> caseList = [SELECT Id , ContactId FROM Case WHERE Id In : childIds];
//      if (caseList.size() != childIds.size()) {
//       System.debug('One or more IDs are not of type Case. Reparenting aborted.');
//      return;  // Exit if any ID is not a Case ID
//     }
//         for(Case case : caseList){
//             case.ContactId = parentId;
//         }
//         if(!caseList.isEmpty()){
//             update caseList ;
//         }
//     }


     public override void doReparenting(Id parentId , List<Id> childIds){
          List<Case> caseList = [SELECT Id , ContactId FROM Case WHERE Id In : childIds];
               if (caseList.size() != childIds.size()) {
                System.debug('One or more IDs are not of type Case.');
               return;  // Exit if any ID is not a Case ID
              }
                  for(Case c : caseList){
                      c.ContactId = parentId;
                  }
                  if(!caseList.isEmpty()){
                      update caseList ;
                  }
     //    Schema.SObjectType parentSObjectType = parentId.getSObjectType();
     //    String objectName = parentSObjectType.getDescribe().getName();
     //     Map<String, Schema.SObjectField> validLookup = this.getFieldsByObjectType( objectName ,childIds[0].getSobjectType());
      
    }
    
}