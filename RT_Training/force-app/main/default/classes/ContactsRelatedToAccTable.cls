public class ContactsRelatedToAccTable {
    // @AuraEnabled
    //  public String columnNames;
    //  @AuraEnabled
    //  public String columnAPINames;
    @AuraEnabled
   public List<Contact> contacts;
   @AuraEnabled
   public List<ContactsRelatedToAccounts__mdt> columns;
    public ContactsRelatedToAccTable(List<ContactsRelatedToAccounts__mdt> columns ){
        // this.columnNames = columnNames;
        // this.columnAPINames =columnAPINames;
        this.columns = columns;
    }
    public ContactsRelatedToAccTable(List<Contact> contacts){
        this.contacts = contacts;
    }
  
}