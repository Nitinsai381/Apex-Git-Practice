import { LightningElement , wire} from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAccountNames from '@salesforce/apex/GetAccountNames.getAccountNames';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import FIRST_NAME from '@salesforce/schema/Contact.FirstName';
import LAST_NAME from '@salesforce/schema/Contact.LastName';
import EMAIL from '@salesforce/schema/Contact.Email';
import PHONE from '@salesforce/schema/Contact.Phone';
import ACCOUNT_ID from '@salesforce/schema/Contact.AccountId';


export default class RecordCreationUsingConForm extends LightningElement {
firstName;
lastName;
email;
phone;
accName;
options =[];
showPop = true;
disableSave = false;
@wire(getAccountNames) wiredAccounts({data , error}){
    if(data){
        this.options = data.map(con => {
            return { label : con.Name , value : con.Id}
        }); 
        console.log('accounts', JSON.stringify(this.options));
        
    }else if(error){
        console.log(error);
        
    }
}
handleInput(event){
    const data=event.target.value;
    if(event.target.name === 'fName'){
        this.firstName = data;
    }else if(event.target.name === 'lName'){
        this.lastName = data;
    }else if(event.target.name === 'Email'){
        this.email = data;
    }else if(event.target.name === 'Phone'){
        this.phone = data;
    }else if(event.target.name === 'account'){
        this.accName = data;
    }
    console.log('selectd account', this.accName);
     
}
handleClose(){
    this.showPop = false;
}
handleCreate(){
    this.disableSave=true;
    const fields = {};
    fields[FIRST_NAME.fieldApiName] = this.firstName;
    fields[LAST_NAME.fieldApiName] = this.lastName;
    fields[EMAIL.fieldApiName] = this.email;
    fields[PHONE.fieldApiName] = this.phone;
    fields[ACCOUNT_ID.fieldApiName] = this.accName;
    const recordInput = {apiName : CONTACT_OBJECT.objectApiName , fields};
    createRecord(recordInput)
    .then(contact => {
        this.dispatchEvent(new ShowToastEvent({
            title : 'success',
            message : 'record created  ' + contact.id,
            variant : 'success'
        }))
    this.showPop = false;
    })
    .catch(error => {
        this.dispatchEvent(new ShowToastEvent ({
            title : 'error',
            message : 'please fill the required fields',
            variant : 'error'
        }))
    console.log('error' , error);
    this.disableSave = false;
    
    })
}
handleCancel(){
    console.log('inside cancel');
    this.template.querySelectorAll('lightning-input').forEach(input => {input.value = null});
    this.accName = null;
    this.phone = null;
    this.email = null;
    this.lastName = null;
    this.firstName = null;
    
}
}