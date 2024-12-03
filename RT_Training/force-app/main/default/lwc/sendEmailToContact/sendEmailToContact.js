import { LightningElement , wire} from 'lwc';
import getContactNames from '@salesforce/apex/GetAccountRelatedContacts.getContactNames';
import getEmailTemplateFolders from '@salesforce/apex/GetAccountRelatedContacts.getEmailTemplateFolders';
import sendEmail from '@salesforce/apex/GetAccountRelatedContacts.sendEmail';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class SendEmailToContact extends LightningElement {
    contacts = [];
    searchedContact;
    matchedEmail = '';
    conEmail;
    isDisableToEmail = true;
    isDisableTemplate = true;
    isDisableSendButton = true;
    isShowPop = false;
    emailTemplates;
    valudIds = [];
    tableValue;
    selectedSubject = '';
    selectedRow;
    selectedBody;
    rowList =[];
    defaultTemplate = '';
    @wire(getEmailTemplateFolders) wiredEmails({data , error}){
        if(data){
            this.emailTemplates = data;
            console.log('email templates', JSON.stringify(this.emailTemplates));
            this.valudIds = Object.keys(this.emailTemplates);
            console.log('ids' , JSON.stringify(this.valudIds));
            this.options = [  {label :' Unified public classic email Template'  , value : this.valudIds[0]},
                              {label : 'My Email Template' , value : this.valudIds[1]}
                           ];
            this.defaultTemplate = this.valudIds[0];    
            this.tableValue = this.emailTemplates[this.defaultTemplate];           
            
        }else if(error){
            console.log(error);
            
        }
    }
    @wire(getContactNames) wiredContacts({data ,error}){
        if(data){
            this.contacts = data;
            console.log('contact data' , JSON.stringify(this.contacts));
            
        }else if(error){
            console.log(error);
            
        }
    }
    handleContactName(event){
         this.searchedContact = event.detail.value;  
         if(!this.searchedContact.length){
            this.isDisableTemplate =true;
            this.matchedEmail = '';
            this.isDisableSendButton = true;
            this.selectedBody = '';
            this.selectedRow = '';
            this.selectedSubject = '';
            this.isDisableToEmail = true;
         }
    }

    handleEnter(event){
        if(event.keyCode === 13 ){
            this.conEmail = '';
            this.matchedEmail = '';
            this.isDisableToEmail = true;
            this.isDisableTemplate = true;
            console.log('inside the if');
            this.contacts.forEach(match => {
                if(match.Name === this.searchedContact.trim()){
                    this.conEmail = match.Email;
                    this.isDisableToEmail = false;
                    this.isDisableTemplate = false;
                }
            })
            this.matchedEmail = this.conEmail;
            console.log('email' , this.conEmail);
        }
    }
    handleTemplate(){
        this.isShowPop = true;
    }
    handleClose(){
        this.isShowPop = false;
        this.tableValue = this.emailTemplates[this.defaultTemplate]; 
    }
    handleSelectTemplate(event){
        const value1 = event.target.value;
        this.tableValue = this.emailTemplates[value1];
        console.log('tablevalue', JSON.stringify(this.tableValue));
    }

    handleRowClick(event) {
        const rowId = event.currentTarget.dataset.id;
        this.selectedRow = this.tableValue.find(row => row.Id === rowId); 
        console.log('Row selected:', this.selectedRow);

        console.log('email body', this.selectedRow.Body.replace('{!Contact.Name}' , this.searchedContact));
    }
    handleSaveEmailData(){
        this.selectedSubject = this.selectedRow.Subject;
        this.selectedBody = this.selectedRow.Body.replace('{!Contact.Name}' , this.searchedContact);
        this.isShowPop = false;
        this.isDisableSendButton = false;
        this.tableValue = this.emailTemplates[this.defaultTemplate]; 

    }
    handleCancelButton(){
        this.isShowPop=false;
    }
    sendEmail(){
        console.log('inside send email');
        
        sendEmail({ emailAddress : this.matchedEmail , subject : this.selectedSubject , body : this.selectedBody})
        .then(() => {
            this.dispatchEvent(new ShowToastEvent({title : 'Success' ,  message :  'Email Sent Successfully', variant : 'success'}));
        })
        .catch(error => {
            this.dispatchEvent(new ShowToastEvent({ title : 'Error' , message : 'Failed To send Email'+ error, variant : 'error'}))
        })
        this.selectedBody = '';
        this.selectedSubject = '';
        this.matchedEmail = '';
        this.isDisableSendButton = true;
    }
    handleCancelForSearch(event){
        if(!event.target.value.length){
            console.log('clear');
            this.selectedBody = '';
            this.selectedSubject = '';
            this.matchedEmail = '';
            this.isDisableSendButton = true;
            this.isDisableTemplate = true;
        }
    }

    
}