import { LightningElement , api } from 'lwc';

export default class DynamicPagination extends LightningElement {
    @api displayrecords ;
    recordsOnPage ;
    start = 0;
    perpage = 5;
    displayContacts(){
        this.recordsOnPage = this.displayrecords.slice(this.start , this.start+this.perpage)
        console.log("records on page -->",JSON.stringify(this.recordsOnPage));

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