import { LightningElement, wire } from 'lwc';
import  SAMPLEMSG from '@salesforce/messageChannel/SampleMessageChannel__c';
import { MessageContext , publish, unsubscribe} from 'lightning/messageService';

export default class LmsComponentA extends LightningElement {
    msg
    @wire(MessageContext)
    context
    

    inputHandler(event){
        this.msg =  event.target.value 
        console.log(this.msg)
    }

    clickHandler(){
        const message={
            lmsData:{
                value:this.msg
            }
        }
        console.log('message:', message);
        publish(this.context, SAMPLEMSG, message)
    }
    
    
}