import { LightningElement } from 'lwc';

export default class ParentCustomEvent extends LightningElement {
    message ;
    handleParent(event){
        this.message = event.detail
    }
}