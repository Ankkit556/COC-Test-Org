import { LightningElement } from 'lwc';

export default class ModalReusable extends LightningElement {
    ModalHandler(){
        const customEvent = new CustomEvent('close');
        this.dispatchEvent(customEvent);
    }
    handleSoltFooterChange(){
        const foooterElemet = this.template.querySelector('.slds-modal__footer');
        if(footerElement){
            footerElement.classList.remove('slds-hide');
        }
    }
}