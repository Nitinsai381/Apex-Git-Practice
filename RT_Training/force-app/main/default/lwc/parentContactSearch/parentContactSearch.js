import { LightningElement , wire} from 'lwc';
import contactsTOSearch from '@salesforce/apex/ContactsDisplay.fetchContacts'

export default class ParentContactSearch extends LightningElement {
    contacts ;
    contactNames = [];
    searchData;
    display = false;
    send;
   @wire (contactsTOSearch) wireData({data , error}){
    if(data){

        this.contacts = data;
    }else if(error){
        console.log('contacts are not avilable');
        
    }
   }
   handleClick(){
    this.searchData = this.template.querySelector("input").value;
    console.log('searchData' , this.searchData);
    this.display=true;
   

    //  this.contactNames = this.contacts.filter(con => {
    //    return con.Name.toLowerCase().startsWith(this.searchData.toLowerCase());
        
        
    // });
      this.contactNames = this.contacts.filter(con => {
        if(con.Name.toLowerCase().startsWith(this.searchData.toLowerCase()) ){
           // this.contactNames.push(con);
            return  con.Name.toLowerCase().startsWith(this.searchData.toLowerCase()) ;
        }
    });
      this.contacts.filter(con => {
        if(!con.Name.toLowerCase().startsWith(this.searchData.toLowerCase()) && con.Name.toLowerCase().includes(this.searchData.toLowerCase())){
            this.contactNames.push(con);
           // return this.contactNames ;// !con.Name.toLowerCase().startsWith(this.searchData.toLowerCase()) && con.Name.toLowerCase().includes(this.searchData.toLowerCase())
        }
    }); 

    // this.contacts.filter(con => {
    //     if(con.Name.toLowerCase().startsWith(this.searchData.toLowerCase()) ){
    //          this.contactNames.push(con);
    //        // return con.Name.toLowerCase().startsWith(this.searchData.toLowerCase()) ;
    //     }
    // });
    //   this.contactNames =this.contacts.filter(con => {
    //     if(  (con.Name.toLowerCase().startsWith(this.searchData.toLowerCase()) )||(!con.Name.toLowerCase().startsWith(this.searchData.toLowerCase()) && con.Name.toLowerCase().includes(this.searchData.toLowerCase()))){
    //       this.contactNames.push(con);
    //       return this.contactNames;
    //        // return !con.Name.toLowerCase().startsWith(this.searchData.toLowerCase()) && con.Name.toLowerCase().includes(this.searchData.toLowerCase())
    //     }
    // });
    console.log('contacts' ,JSON.stringify(this.contactNames));
    //this.send = this.contactNames[0].Name;
    //this.send = this.contactNames.map(con => con.Name)
    //console.log('send' , JSON.stringify(this.send));
    
   
   
   }
   
    
   



    }
