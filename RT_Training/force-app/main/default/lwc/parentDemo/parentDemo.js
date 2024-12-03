import { LightningElement } from 'lwc';

export default class ParentDemo extends LightningElement {
    value;
    handleChange(event){
        this.value=event.target.value;
    }
}