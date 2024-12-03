import { LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import ACCOUNT_NUMBER_FIELD from '@salesforce/schema/Account.AccountNumber';
import INDUSTRY from '@salesforce/schema/Account.Industry';
import AnnualRevenue_FIELD from '@salesforce/schema/Account.AnnualRevenue';


export default class RecordCreationUsingAccForm extends LightningElement {
    industry ;
    name ;
    phone;
    accNumber;
    annualRevenue;
    showPop = true;
    disableSave = false;
    //fields = {};
     options = [
        { value : 'Electronics' , label : 'Electronics' },
        {value : 'Banking' , label : 'Banking'},
        {value : 'Chemicals' , label : 'Chemicals'},
        {value : 'Agriculture' , label : 'Agriculture'}
    ];
    handleIndustry(event){
        this.industry = event.detail.value;
        console.log(" industry" , this.industry);
        
    }
    handleInput(event){
        this.name = event.detail.value;
        console.log("name" , this.name);
        
    }
    handlePhone(event){
        this.phone = event.detail.value;
        console.log("phone" , this.phone);
        
    }
    handleAccountNumber(event){
        this.accNumber=event.detail.value;
        console.log("accnumber" , this.accNumber);
        
    }
    handleRevenue(event){
        this.annualRevenue = event.detail.value;
        console.log("revenue" , this.annualRevenue);
       // this.handleCreate();
        
    }
    handleCreate(){
        this.disableSave = true;
       const fields = {};
        fields[NAME_FIELD.fieldApiName] = this.name;
        fields[PHONE_FIELD.fieldApiName] = this.phone;
        fields[ACCOUNT_NUMBER_FIELD.fieldApiName] = this.accNumber;
        fields[INDUSTRY.fieldApiName] = this.industry;
        fields[AnnualRevenue_FIELD.fieldApiName] = this.annualRevenue;
        console.log('fields' , JSON.stringify(this.fields));
        const recordInput = {apiName : ACCOUNT_OBJECT.objectApiName , fields };
        createRecord(recordInput)
        .then(result => {
            const event = new ShowToastEvent({
                title :  'Success!',
                message : 'record created ' + result.id,
                variant: 'success'
            });
            this.dispatchEvent(event);
            this.showPop=false;
            //this.template.querySelectorAll('lightning-input').forEach(input =>{ input.value = null});
            
            console.log("account is created succussfully" ,result.id);
        })
        .catch(error =>{
           const evt = new ShowToastEvent({
               title: 'Error',
               message: 'please fill the reqired fields',
               variant: 'error',
               mode: 'dismissable'
           });
           this.dispatchEvent(evt);
            console.log("failed to create record" , error); 
            this.disableSave = false;  
        })
        
    }
    handleCancel(){
        console.log('inside cancel');
        this.template.querySelectorAll('lightning-input').forEach(input =>{ input.value = null});
        this.template.querySelector('lightning-combobox').value = null;
        this.industry = null;
        this.name = null;
        this.phone = null;
        this.accNumber = null;
        this.annualRevenue = null;
    
    }
    handleClose(){
        this.showPop = false;
    }
    

    
}