import { LightningElement } from 'lwc';

export default class ParentBall extends LightningElement {
    item = "ball";
    data;
    handleChildData(event){
        this.data = event.detail
    }
}
