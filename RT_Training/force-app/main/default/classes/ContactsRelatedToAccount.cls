// public  with sharing class ContactsRelatedToAccount {
//     // @AuraEnabled(cacheable = true)
//     // public static List<Contact> contactsWithAccounts(Id accId) {
//     //     return [SELECT Id , Name ,Email , Phone ,Owner.Name FROM Contact WHERE AccountId =: accId  ORDER BY LastModifiedDate DESC];
//     // }
//    @AuraEnabled(cacheable = true)
//     public static List<Contact> getColumnMetadata(Id accId){
//         List<ContactsRelatedToAccounts__mdt> columns = [SELECT Column__c , Column_Api_Name__c FROM ContactsRelatedToAccounts__mdt];
//         List<String> fields = new List<String>();
//         for(ContactsRelatedToAccounts__mdt col : columns){
//             fields.add(col.Column_Api_Name__c);
//         }
//         String query = 'SELECT ';
//         query += String.join(fields, ', ') + ' FROM Contact WHERE AccountId =: accId ORDER BY LastModifiedDate DESC' ;
//         List<Contact> cons = Database.query(query);
//         System.debug('query' + query);
//         System.debug('con' +cons);
//         return cons;
//     }
//     @AuraEnabled(cacheable = true)
//     public static List<ContactsRelatedToAccounts__mdt> getColumnLabels(){
//        return [SELECT Column__c, Column_Api_Name__c FROM ContactsRelatedToAccounts__mdt];
//     }
// }
public  with sharing class ContactsRelatedToAccount {  
    @AuraEnabled(cacheable = true)
    public static List<ContactsRelatedToAccTable> getColumnData(Id accId){
        List<ContactsRelatedToAccounts__mdt> mtData = [SELECT Column__c , Column_Api_Name__c FROM ContactsRelatedToAccounts__mdt];
        ContactsRelatedToAccTable obj;//  = new ContactsRelatedToAccTable();
        List<ContactsRelatedToAccTable> lst = new List<ContactsRelatedToAccTable>();
        Set<String> fields = new Set<String>();
        for(ContactsRelatedToAccounts__mdt mdt : mtData){
            // obj.columnNames = mdt.Column__c;
            // obj.columnAPINames = mdt.Column_Api_Name__c;
            // lst.add(obj);
            fields.add(mdt.Column_Api_Name__c);
        }
        lst.add(new ContactsRelatedToAccTable(mtData));
        
        System.debug('list---->' +lst);
        String query = 'SELECT Id, ';
        query += String.join(fields, ', ') + ' FROM Contact  WHERE AccountId =: accId  ORDER BY LastModifiedDate DESC' ;
        List<Contact> cons = Database.query(query);
        lst.add(new ContactsRelatedToAccTable(cons));
        System.debug('query' +query);
        System.debug('cons' +cons);
        return lst;
    }

}