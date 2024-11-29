public class EventPublisher {
    public static void publishReparentEvent(){
        ReparentingRecord__e event = new ReparentingRecord__e();
        event.ParentId__c = '001NS00000Qu10rYAB';//parentId;
        List<Id> Ids = new List<Id>{
            '003NS00000Cf95TYAR',
            '003NS00000Cf95KYAR'
          };
          String childIds = JSON.serialize(Ids);
        event.ChildId__c =  childIds;//childIdString;
        event.ClassName__c = 'ReparentingContacts';
        Database.SaveResult res = EventBus.publish(event);
        if(res.isSuccess()){
            System.debug('event published successfully');
        }else {
            System.debug('Failed to publish event: ' + res.getErrors()[0].getMessage());

        }
     
    }
}








