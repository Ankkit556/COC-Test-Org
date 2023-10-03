import { LightningElement } from 'lwc';

export default class SlotChildComponent extends LightningElement {
    changeFooter(){
        const footerEle = this.template.queryselector('.slds-card_footer')
        if(footerEle){
            footerEle.classList.remove('slds-hide')
        }
    }
}