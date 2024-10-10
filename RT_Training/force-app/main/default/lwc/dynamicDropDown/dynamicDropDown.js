import { LightningElement , api} from 'lwc';

export default class DynamicDropDown extends LightningElement {

 value = ' ';
 @api objectApiName;

    get isDisabled() {
        return this.objectApiName !== 'Account'; // Disable if not 'Account'
    }
 get options(){
    return [
        {label : 'Contact'  , value : 'Contact'},
        {label : 'Case'  ,  value : 'Case'},
        {label : 'Opportunity' , value : 'Opportunity'}
    ];
 }
 handleChange(event){
    this.value = event.detail.value;
   const sendRes  = new CustomEvent("parent" , { detail : this.value });
    this.dispatchEvent(sendRes);
}


// get disable(){
//     return this.objectApiName === 'Account' ? true : true 
    
// }



}