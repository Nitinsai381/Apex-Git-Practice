import { LightningElement } from 'lwc';

export default class ChildCustomEvent extends LightningElement {
    data = "value received from child"
    handleClick(event){
        const sendRes = new CustomEvent("value" , {
            detail : this.data
        })
        this.dispatchEvent(sendRes);
    }
}