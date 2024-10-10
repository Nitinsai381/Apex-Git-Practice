public class ContactsDisplay {
    @AuraEnabled(cacheable = true)
   
   public static List<Contact> fetchContacts(){
    return [SELECT Id , Name , Email ,  Birthdate , Department FROM Contact];
   }
}           