import { LightningElement, wire , api } from 'lwc';
import objectsRelatedToAccount from '@salesforce/apex/DynamicTable.getData'

export default class DynamicTable extends LightningElement {
    objectToDisplay ; 
    @api searchterm ;
    //wire
    @api record ; // object data
    cloumnData ;
    rowData ;
    sendData ;
    isRecordsPresent = false ;
    recordsOnPage =[];
    start = 0;
    perpage = 5;
    currentpage; 
    totalpages;
   // disableSearch = false ;
    disbaleButtons = false ;
     filteredData ;
     obj ;
     check;
     check1 ;
     @api name ;
     
   
    @wire (objectsRelatedToAccount, ({accId : '$record' , objectName : '$name'} ))
    wireData({data , error}){
        if(data){ 
            console.log('data' , data);
            this.obj = Object.assign({} , ...data);
            this.cloumnData = this.obj.labels.map(a => {
                return a.Field_Config__r ;
            });
            console.log('test col' , JSON.stringify(this.cloumnData));
            this.rowData = this.obj.objectData.map( value => {
                let obj ={};
                obj.Id = value.Id ;
                obj.record = this.buildRecord(value);
                return obj ;

            }) ;
            console.log('enable search bar: ' , this.rowData.length > 5);
            this.check = this.rowData.length > 5 ;
           // this.check1 = this.check > 5 ;
            console.log('check', this.check);            
            this.dispatchEvent(new CustomEvent("showsearch", { detail : this.check }));
            this.isRecordsPresent = this.rowData.length > 0 ;
            console.log('isRecordsPresent' , this.isRecordsPresent);
            this.filteredData = this.rowData;
            this.totalpages = Math.ceil(this.filteredData.length/this.perpage);
            console.log('tottalpages' , this.totalpages);
            console.log('filteredData ',JSON.stringify(this.filteredData));
            this.displayContacts();
                   
        }
        else if(error){
            console.log('error' ,error);
        }
    }
   
    buildRecord(value){
        let record = [] ;
        this.cloumnData.map(column => 
            record.push(value[column.Field_Api_Name__c])
        );
        return record;
    }
  


    // search 
    @api searched(input){
        console.log('check', input);
        this.start = 0;
        console.log('search trem' , input);
        if (input) {
            console.log('inside if');
            // this.check = this.rowData.map(row => row.record);
            // console.log('check' , JSON.stringify(this.check));
            // this.check1 = this.check.filter(every =>   every.toString().toLowerCase().includes(this.searchTerm.toLowerCase()))
            // console.log('check 1' , JSON.stringify(this.check1));
            console.log('just for check data' , JSON.stringify(this.filteredData));
            
            this.filteredData = this.rowData.filter(row => 
            row.record.some(value => 
            value && value.toString().toLowerCase().includes(input.toLowerCase())));
            if(this.filteredData.length > 5){
                this.disbaleButtons = true ;
            }else{
                this.disbaleButtons = false ;
            }
        }
         else {
            console.log('search trem' ,input);
            console.log('insde else');
            this.filteredData = this.rowData;
        }
        console.log('filtered dsta' , JSON.stringify(this.filteredData));
        this.totalpages = Math.ceil(this.filteredData.length / this.perpage);
        this.displayContacts();
        
    }
    @api change(){
        this.start = 0 ;
    }
    
    //pagination
    displayContacts(){
        this.disbaleButtons = false;
        console.log("inside display");
        console.log('length' , this.rowData.length);
        if(this.filteredData.length > 5){
           // this.disableSearch = true ;
            this.disbaleButtons = true ;
        }
        // console.log('disablesearch' , this.disableSearch);
        this.recordsOnPage = this.filteredData.slice(this.start , this.start+this.perpage)
        console.log('start ' ,this.start);
        
        console.log("records on page -->",JSON.stringify(this.recordsOnPage));
        this.currentpage = Math.floor(this.start / this.perpage) + 1;

    }
    onNext(){
        console.log("inside next");
        if(this.start+this.perpage < this.rowData.length){
            this.start += this.perpage;
            this.displayContacts();
        }
    }
    onPrevious(){
        console.log("inside previous");
        if(this.start-this.perpage >= 0){
            this.start -= this.perpage;
            this.displayContacts();
        }
    }
    get disablePrevious(){
        return this.start === 0;
    }
    get disableNext(){
        return this.currentpage === this.totalpages;
    }   
}