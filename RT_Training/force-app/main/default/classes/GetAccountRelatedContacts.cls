public with sharing class GetAccountRelatedContacts {
    //get all account related contacts
    @AuraEnabled (cacheable = true)
    public static List<Contact> getContactNames(){
        return [SELECT Id , Name ,Email, AccountId FROM Contact WHERE AccountId != null];
    }

    
    //emailtemplates with their folder ids 
    @AuraEnabled (cacheable = true)
    public static Map<Id , List<EmailTemplate>> getEmailTemplateFolders() {
        Map<String,Id> folderMap = new Map<String , Id>();
        String orgId = UserInfo.getOrganizationId();
        folderMap.put( 'Unified public classic email Template' ,UserInfo.getOrganizationId() );
        for(Folder f : [SELECT Id, Name FROM Folder WHERE Type = 'email']){
            folderMap.put(f.Name,f.Id);
        }
        System.debug(folderMap);
        Map<Id , List<EmailTemplate>> emailMap = new Map<Id , List<EmailTemplate>>();
        List<EmailTemplate> emailList = [SELECT Name ,Subject , Body, FolderId FROM EmailTemplate WHERE FolderId = :folderMap.values()];
        for (EmailTemplate email : emailList) {
            if (!emailMap.containsKey(email.FolderId)) {
                emailMap.put(email.FolderId, new List<EmailTemplate>());
            }
            emailMap.get(email.FolderId).add(email);
        }
        System.debug('email' +emailMap);
        return emailMap;
    }



    //dropdown values



    //send email 
    @AuraEnabled (cacheable = true)
    public static void sendEmail(String emailAddress , String subject , String body){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new List<String> {emailAddress});
        mail.setSubject(subject);
        mail.setHtmlBody(body);
        Messaging.sendEmail(new List<Messaging.Email> {mail});
    }

    
}