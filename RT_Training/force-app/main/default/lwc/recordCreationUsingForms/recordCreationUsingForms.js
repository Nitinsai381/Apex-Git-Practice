import { LightningElement } from 'lwc';

export default class RecordCreationUsingForms extends LightningElement {
    selectedOption ;
    isAccount = false ;
    isContact = false ;
    isOpportunity = false;
    handleOption(event){
        console.log('change');
        this.isAccount = false;
        this.isContact = false;
        this.isOpportunity = false;
        this.selectedOption = event.detail ;
        console.log('selected option' , this.selectedOption)
        if(this.selectedOption === 'Account'){
            this.isAccount = true;
        } else if(this.selectedOption === 'Contact'){
            this.isContact = true;
        }else if(this.selectedOption === 'Opportunity'){
            this.isOpportunity =true;
        }
        
    }
   

} 