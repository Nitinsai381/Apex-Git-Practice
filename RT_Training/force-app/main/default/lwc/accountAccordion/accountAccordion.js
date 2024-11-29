import { LightningElement , wire} from 'lwc';
import getAccountNames from '@salesforce/apex/GetAccountNames.getAccountNames';

export default class AccountAccordion extends LightningElement {
    accountData = [];
    conLabels = ['Name' ,'Phone' , 'Email'];
    oppLabels = ['Name' , 'StageName' , 'CloseDate'];
    caseLabels = ['Status','Subject'];
    @wire(getAccountNames) wiredAccounts({data,error}){
        if(data){
            this.accountData = data;
           
            console.log('con data' , JSON.stringify(this.contacts));
   
        }
        else if(error){
            console.log(error);  
        }
    }
    
}