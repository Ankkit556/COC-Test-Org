import { LightningElement } from 'lwc';

export default class ChildComponent extends LightningElement {
    closeModal(){
        const myEvent = new CustomEvent('close',{
            detail:"Modal closed successfully !!!"
        });
        this.dispatchEvent(myEvent);
    }
}