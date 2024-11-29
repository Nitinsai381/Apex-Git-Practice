import { LightningElement , api} from 'lwc';

export default class DynamicDropDown extends LightningElement {
    @api disabled = false;
@api recordId ;
 get options(){
    return [
        {label : 'Contact'  , value : 'Contact'},
        {label : 'Case'  ,  value : 'Case'},
        {label : 'Opportunity' , value : 'Opportunity'}
    ];
 }
 handleChange(event){
    const value = event.detail.value ;
    this.dispatchEvent(new CustomEvent("optionselect" , { detail :value }));
}

}


