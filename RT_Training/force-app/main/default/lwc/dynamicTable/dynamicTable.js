import { LightningElement, wire , api } from 'lwc';
import objectsRelatedToAccount from '@salesforce/apex/DynamicTable.getData'

export default class DynamicTable extends LightningElement {
    objectToDisplay ; 
    searchedrecords = [] ;
    search = false ;
    //wire
    @api recordId ;
    cloumnData ;
    rowData ;
    sendData ;
    isRecordsPresent = false ;
    newData ;
    recordsOnPage =[];
    start = 0;
    perpage = 5;
    currentpage;
    totalpages;
    disableSearch = false ;
    handleParent(event){
        this.objectToDisplay = event.detail ;
        this.search = false;
        console.log('objectName----->',this.objectToDisplay);
    }
    handleSearch(event){
        this.searchedrecords = event.detail.value ;
        this.search = event.detail.checksearch ;
        console.log('search data' ,JSON.stringify(this.searchedrecords));
        this.structure() 
        
    }
   
  
    @wire (objectsRelatedToAccount, ({accId : '$recordId' , objectName : '$objectToDisplay'}))
    wireData({data , error}){
        if(data){
            
            console.log('data' , data);
            this.sendData = data[1].objectData ;
            console.log('senddata' , JSON.stringify(this.sendData));
            
            this.cloumnData = data[0].labels.map(col => {
                return col.Field_Config__r ; 
            });
            console.log('col' , JSON.stringify(this.cloumnData));
           this.structure() 
           this.displayContacts()
                   
        }
        else if(error){
            console.log('error' ,error);
        }
    }
    structure() {
        if(this.search){
            this.newData = this.searchedrecords ;
            console.log('from search' , JSON.stringify(this.newData));
            
        } else{
            this.newData = this.sendData ;
            console.log('from display default' ,JSON.stringify(this.newData) );
            
        }
        this.rowData = this.newData.map(value => {
            let obj ={};
            obj.Id = value.Id ;
            obj.record = this.buildRecord(value);
            return obj ;
        });
        this.isRecordsPresent = this.rowData.length > 0 ;
        this.totalpages = Math.ceil(this.rowData.length/this.perpage);
        console.log('rowData ',JSON.stringify(this.rowData));
        this.start = 0;
        this.displayContacts()
        
    }
    buildRecord(value){
        let record = [];
        this.cloumnData.map(column => {
            record.push(value[column.Field_Api_Name__c]);
        });
        return record;
    }







    //pagination
    displayContacts(){
        console.log("inside display");
        console.log("contacts length" +this.rowData);
        console.log('length' , this.rowData.length);
        
        if(this.rowData.length > 5){
            this.disableSearch = true ;
        }
        console.log('disablesearch' , this.disableSearch);
        
        this.recordsOnPage = this.rowData.slice(this.start , this.start+this.perpage)
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
    






















































































    //   @api recordId ;
    //     columnData ;
    // @wire (objectsRelatedToAccount , {accId : '$recordId' , objectName : '$value1'})
    //  wireData({data , error}){
    //     if(data){
    //         console.log('data' , data);
    //         this.columnData = data[0].labels.map(col =>{
    //              return col.Field_Config__r
    //         });
    //         console.log('colData' , JSON.stringify(this.columnData));
    //         this.recordData = data[1].objectData.map(objectValue =>{
    //             let obj = {};
    //             obj.Id = objectValue.Id;
    //             obj.record = this.buildRecord(objectValue);
    //             return obj ;
    //         })
    //         console.log('record' , JSON.stringify(this.recordData));
            
    //     }
    //     else if(error){
    //         console.log('error message' , this.error);
            
    //     }
    // }
    // buildRecord(objectValue){
    //     let record = [];
    //     this.columnData.map(col => {
    //         record.push(objectValue[col.Field_Api_Name__c]);
    //     });
    //     return record;
    // }










//}