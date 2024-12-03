public with sharing class GetAccountNames {
    @AuraEnabled(cacheable = true)
    public  static List<Account> getAccountNames() {
        return[SELECT Id, Name ,
        (SELECT Id , Name , Email, Phone FROM Contacts),
        (SELECT Id , Name , StageName , CloseDate FROM Opportunities),
        (SELECT Id , Subject , Status FROM Cases) FROM Account  ORDER BY LastModifiedDate  LIMIT 15];

    }
}