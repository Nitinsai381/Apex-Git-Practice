import { LightningElement, wire , api} from 'lwc';
import contactsWithAccounts from '@salesforce/apex/ContactsRelatedToAccount.getColumnData'
export default class ContactsRelatedToAccounts extends LightningElement {
  @api recordId;
  contacts;
  contactValues;
  contactsData = [];
  columnData;
  structureData =[];
  isNoContacts=false;
  start = 0;
  perpage = 5;
  recordsOnPage = [];
  totalpages;
  currentpage;
  @wire (contactsWithAccounts , {accId : '$recordId'}) wireData({data , error}){
    if(data){
        console.log('coming inside');
        console.log('data' ,data);
        this.columnData=data[0].columns;
        console.log('columnData' , JSON.stringify(this.columnData));
       // this.contactsData = data[1].contacts;
       // console.log('contactsData' , JSON.stringify(this.contactsData));
       this.isNoContacts = this.contactsData.length === 0 ;
       console.log('nocontacts' , this.isNoContacts);
       //this.columnData = this.contacts.slice(0,this.contacts.length-1)
        //const columnNames = this.contacts.filter(item => item.columnNames).map(item => item.columnNames);
       // this.contactsData = this.contacts.filter(item => item.contacts).map(item => item.contacts)[0]; 
              // const contacts = data.find(item => item.contacts).contacts;
       // console.log('Column Names:', JSON.stringify(this.columnData));
       // console.log('ContactsData:', JSON.stringify(this.contactsData)); 
        this.structureData = data[1].contacts.map(contact =>{
          let obj = {};
          obj.Id = contact.Id;
          obj.record = this.buildRecord(contact);
          return obj;
        }) ;
   
        console.log('structredata' , JSON.stringify(this.structureData));
        this.totalpages = Math.ceil(this.structureData.length/this.perpage);
        console.log("total pages" +this.totalpages);
        this.displayContacts();
        
      } 
      else if(error){
        console.log('Data is not availiable');
      }
      
    }
    buildRecord(contact) {
      let record = [];
      this.columnData.map(col => {
        record.push(contact[col.Column_Api_Name__c]); 
      });
      return record;
    }

    // pagination

    displayContacts(){
              console.log("inside display");
              console.log("contacts length" +this.contacts);
              this.recordsOnPage = this.structureData.slice(this.start , this.start+this.perpage)
              console.log("records on page -->",JSON.stringify(this.recordsOnPage));
              this.currentpage = Math.floor(this.start / this.perpage) + 1;
      
          }
          onNext(){
              console.log("inside next");
              if(this.start+this.perpage < this.structureData.length){
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