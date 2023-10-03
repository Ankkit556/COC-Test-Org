import { LightningElement } from 'lwc';

export default class ModalWrapper extends LightningElement {
  isOpen = false;
    showModalhandler(){
        console.log('method called');
        this.isOpen = true;
      }

      cancelModalHandler(){
        this.isOpen = false;
      }
}