import { LightningElement , api } from 'lwc';

export default class LwcComponentAura extends LightningElement {
@api msg
@api title
clickHandler(){
    const MyEvent = new CustomEvent('show',{
        details:{
            "msg":"Hello from Lwc"
        }
    })
    this.dispatchEvent(MyEvent);
}
}