import { LightningElement } from 'lwc';

export default class DropDownForForms extends LightningElement {
    get options() {
        return [
            { label: 'Account', value: 'Account' },
            { label: ' Contact', value: 'Contact' },
            { label: 'Opportunity', value: 'Opportunity' },
        ];
    }
    handleChange(event){
    const value = event.detail.value ;
    this.dispatchEvent(new CustomEvent("optionselect" , { detail :value }));
    }
}