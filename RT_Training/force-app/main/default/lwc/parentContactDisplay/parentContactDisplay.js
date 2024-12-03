import { LightningElement , wire } from 'lwc';
import contactsData from '@salesforce/apex/ContactsDisplay.fetchContacts'
export default class ChildContactDisplay extends LightningElement {
    contactsInfo ;
    selectedContact;
    displayCheck  = false;
 @wire (contactsData) wireData({data , error}){
 if(data){
  console.log('coming inside');
  console.log('data',JSON.stringify(data));
  this.contactsInfo = data;
  console.log('contactsInfo' , JSON.stringify(this.contactsInfo));
  
 }
 else if(error){
    console.log('data is not available');
 }
 }
 contactDataDisplay(event){
    // this.displayCheck = true;
    const contactId = event.target.dataset.id;
    console.log('contactId-->',contactId);
    this.selectedContact = this.contactsInfo.find(contact => contact.Id === contactId);
    console.log('this.selectedContact-->',this.selectedContact);
}
}