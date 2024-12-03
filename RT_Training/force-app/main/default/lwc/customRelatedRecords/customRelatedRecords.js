import { api, LightningElement, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import Name from '@salesforce/schema/Account.Name';

export default class CustomRelatedRecords extends LightningElement {
    @api recordId
    showSearch = false
    disableDropDown = false
    columns = []
    data = []
    showSpinner = false
    selectedOption;
    searchTerm ;

    @wire(getRecord, { recordId: '$recordId', fields: [Name] })
    propertyOrFunction(data, error){
        console.log(data)
        console.log('record id' , this.recordId);
        
        this.showSpinner = true;
        if(data){
            this.disableDropDown = ! ['Account'].includes(data?.data?.apiName)
            this.objectApiName = data?.data?.apiName
        }else if(error){
            console.error(error)
        }
        this.showSpinner = false 
    }

    handleOption(event){
       // this.showSearch = true ;
       this.template.querySelector('c-dynamic-table').change() ;
        console.log(event.target);
        this.selectedOption = event.detail ;
        console.log('selected option' , this.selectedOption);
        
    }
    handleSearchInput(event){
        this.searchTerm = event.detail ;
        console.log('search data' ,JSON.stringify(this.searchTerm ));
        this.template.querySelector('c-dynamic-table').searched(this.searchTerm);
       // this.searched();
    }

    handleSearch(event){
        this.showSearch = event.detail ;
        console.log('show search' , this.showSearch);
    }
}