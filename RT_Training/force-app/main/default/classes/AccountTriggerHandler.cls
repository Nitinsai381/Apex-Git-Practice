public class AccountTriggerHandler {
  public void afterUpdate(List<Account> listacc, Map<Id, Account> oldaccs) {
    Map<Id, Account> Mapacc = new Map<Id, Account>();
    for (Account acc : listacc) {
      Account oldacc = oldaccs.get(acc.Id);
      if (acc.Status__c != oldacc.Status__c) {
        Mapacc.put(acc.Id, acc);
      }
    }

    List<Contact> con = [SELECT Id, Status__c, AccountId FROM Contact WHERE AccountId IN :Mapacc.keySet()];
    List<Contact> updatedcon = new List<Contact>();
    for (Contact c : con) {
      if (Mapacc.containsKey(c.AccountId)) {
        Account acc = Mapacc.get(c.AccountId);
        c.Status__c = acc.Status__c;
        updatedcon.add(c);
      }
    }
    update updatedcon;
  }

  // public void beforeInsert(List<Account> newAcc){
  //   Set<String> accNames = new Set<String>();
  //   List<Account> accToInsert = new List<Account>();
  //   for(Account acc : newAcc){
  //     accNames.add(acc.Name);
  //   }
  //   Map<String , Account> existingAcc = new Map<String , Account>();
  //   for(Account a : [ SELECT Id , Name FROM Account WHERE Name IN : accNames]){
  //     existingAcc.put(a.Name , a);
  //   }
  //   for(Account accounts : newAcc){
  //     if(existingAcc.containsKey(accounts.Name)){
  //       accounts.addError('An Account already exist with the name ' + accounts.Name );
  //     }
  //     else{
  //       accToInsert.add(accounts);
  //     }
  //   }
  //   insert accToInsert;

  // }
}