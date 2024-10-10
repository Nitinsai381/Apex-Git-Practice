trigger AccountTrigger on Account(after update, before insert) {
  AccountTriggerHandler a = new AccountTriggerHandler();
  if (Trigger.isAfter && Trigger.isUpdate) {
    a.afterUpdate(Trigger.new, Trigger.oldMap);
  }
  //if(Trigger.isBefore && Trigger.isInsert){
   // a.beforeInsert(Trigger.new);
  //}
}