import { LightningElement, wire } from 'lwc';
import getAccountNames from '@salesforce/apex/GetAccountNames.getAccountNames';
import { createRecord } from 'lightning/uiRecordApi';
import OPPORTUNITY_OBJECT from '@salesforce/schema/Opportunity';
import OPP_NAME from '@salesforce/schema/Opportunity.Name';
import CLOSE_DATE from '@salesforce/schema/Opportunity.CloseDate';
import AMOUNT from '@salesforce/schema/Opportunity.Amount';
import STAGE from '@salesforce/schema/Opportunity.StageName';
import ACCOUNT_ID from '@salesforce/schema/Opportunity.AccountId';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class RecordCreationUsingOppForm extends LightningElement {
    oppName;
    closeDate;
    amount;
    showPop = true;
    disableSave = false;
    accountsForOptions = [];
    selectedAccount;
    selectedStage;
    options = [
        {value : 'Prospecting' , label : 'Prospecting'},
        {value : 'Qualification' , label : 'Qualification'},
        {value : 'Value Proposition' , label : 'Value Proposition'},
        {value : 'Closed Lost' , label : 'Closed Lost'},
        {value : 'Closed Won' , label : 'Closed Won'},
        
    ];
    @wire(getAccountNames) wiredAccounts({data , error}){
        if (data) {
            this.accountsForOptions = data.map(acc =>{
                return {label : acc.Name , value : acc.Id};
            });
            console.log('accounts' , JSON.stringify(this.accountsForOptions));
          //  JSON.parse()
            
        } else if(error){
            console.log(error);
            
        }
        
    }
    handleInput(event){
        const data = event.target.value;
        if(event.target.name === 'Name'){
            this.oppName = data;
        }else if(event.target.name === 'Amount'){
            this.amount = data;
        }else if(event.target.name === 'CloseDate'){
            this.closeDate = data;
        }else if(event.target.name === 'Account'){
            this.selectedAccount = data;
        }else if(event.target.name === 'Stage'){
            this.selectedStage = data;
        }
        
    }
    handleClose(){
        this.showPop = false;
    }
    handleCancel(){
        this.template.querySelectorAll('lightning-input').forEach(input => {input.value = null});
        this.template.querySelectorAll('lightning-combobox').forEach(input => {input.value = null});
        this.selectedStage = null;
        this.selectedAccount = null;
        this.amount = null;
        this.closeDate = null;
        this.oppName = null;
    }
    handleCreate(){
        this.disableSave = true;
     const fields = {};
     fields[OPP_NAME.fieldApiName] = this.oppName;
     fields[AMOUNT.fieldApiName] = this.amount;
     fields[STAGE.fieldApiName] = this.selectedStage;
     fields[CLOSE_DATE.fieldApiName] = this.closeDate;
     fields[ACCOUNT_ID.fieldApiName]= this.selectedAccount;
     const recordInput = {apiName : OPPORTUNITY_OBJECT.objectApiName , fields};
     createRecord(recordInput)
     .then(opp => {
        this.dispatchEvent(new ShowToastEvent({
            title : 'success',
            message : 'record created '+ opp.id,
            variant : 'success'
        }));
        this.showPop = false;
     })
     .catch(error => {
        this.dispatchEvent(new ShowToastEvent({
            title : 'error ',
            message : 'please filled the required fields',
            variant : 'error'
        }));
        console.log(error);
        this.disableSave = false;
     })

    }
    

}