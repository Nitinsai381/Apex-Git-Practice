import { LightningElement , api} from 'lwc';

export default class DynamicSearch extends LightningElement {
   @api searchdata  = [];
    searchTerm ;
    processedData = [];
    isSearch = false ;
    handleEvent(event){
        this.searchTerm = event.target.value;
        this.isSearch = true ;
        console.log('seacrh term', this.searchTerm);
        const send = new CustomEvent('search' , {
            detail : {'value' : this.sendData , 'checksearch' : true }
        });
        this.dispatchEvent(send);
       // console.log('seacrhdata' ,JSON.stringify(this.searchdata) );

        // this.processedData = this.searchdata.filter(record =>{
        //     if(record.Name.toLowerCase().startsWith(this.searchTerm.toLowerCase()))
        //         return record.Name.toLowerCase().startsWith(this.searchTerm.toLowerCase()) ;
        // } );
        // this.searchdata.filter(record => {
        //     if(!record.Name.toLowerCase().startsWith(this.searchTerm.toLowerCase()) && record.Name.toLowerCase().includes(this.searchTerm.toLowerCase())){
        //         this.processedData.push(record);
        //     }
        // });
        // console.log('processeddata' , JSON.stringify(this.processedData));
        // const send = new CustomEvent('search' , {
        //     detail : {'value' : this.processedData , 'issearch' : true }
        // });
        // this.dispatchEvent(send);
        
        
    }
    get sendData() {
        this.processedData = [];
       // console.log('seacrhdata' ,JSON.stringify(this.searchdata) );
            this.searchdata.filter(record =>{
            if(record.Name.toLowerCase().startsWith(this.searchTerm.toLowerCase())){
                this.processedData.push(record);
            }
               // return record.Name.toLowerCase().startsWith(this.searchTerm.toLowerCase()) ;
        } );
        this.searchdata.filter(record => {
            if(!record.Name.toLowerCase().startsWith(this.searchTerm.toLowerCase()) && record.Name.toLowerCase().includes(this.searchTerm.toLowerCase())){
                this.processedData.push(record);
            }
        });
        console.log('processeddata' , JSON.stringify(this.processedData));
        return this.processedData ;
       
    }
    // handleEvent(event){
    //     this.searchvalue = event.target.value ;
    //     const send = new CustomEvent('search' , {
    //         detail : this.searchvalue
    //     });
    //     this.dispatchEvent(send);
    //     console.log('sear' , this.searchvalue);
        
    // }
    }