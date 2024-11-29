import { LightningElement , wire} from 'lwc';
import { deleteRecord } from 'lightning/uiRecordApi';
import getAccountNames from '@salesforce/apex/GetAccountNames.getAccountNames';
import ShowToastEvent from 'lightning/platformShowToastEvent'

export default class IdsDeleteRecord extends LightningElement {
    accounts ;
    error;
    @wire(getAccountNames) wiredAccounts({data, error}){
        if(data){
            this.accounts = data;
        }else if(error){
            this.error = error;
        }
    }
    handleDelete(event){
        const recordId = event.taget.dataset.recordId
        deleteRecord(recordId)
        .then(record =>{
            this.dispatchEvent(new ShowToastEvent({
                title : 'success',
                message : 'successfully deleted record',
                variant : ''
            }) )
        })
    }

}