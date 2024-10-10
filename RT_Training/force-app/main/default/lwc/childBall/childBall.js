import { LightningElement , api } from 'lwc';

export default class ChildBall extends LightningElement {
    @api parentBall;
    
    sendDataBack(){
    this.dispatchEvent( new CustomEvent("senddataback" , {
        detail : "ball" }));
    }
}