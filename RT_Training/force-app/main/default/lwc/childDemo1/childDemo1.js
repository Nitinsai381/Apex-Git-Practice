import { LightningElement } from 'lwc';

export default class ChildDemo1 extends LightningElement {

    count = 0;

    increaseCount() {
        this.dispatchEvent(new CustomEvent('increasecount', {
            detail: {
                message: 'Increased count to ' + (++this.count)
            }
        }));
    }
}