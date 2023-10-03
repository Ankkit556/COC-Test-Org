import { LightningElement, wire } from 'lwc';
import  SAMPLEMSG from '@salesforce/messageChannel/SampleMessageChannel__c';
import { MessageContext, subscribe, APPLICATION_SCOPE, unsubscribe } from 'lightning/messageService';

export default class LmsComponentB extends LightningElement {
    recievedMsg
    subscription
    @wire(MessageContext)
    context
    
    connectedCallback(){
        this.subscribeMessage();
        //console.log('recievedMsg:', recievedMsg);
    }
    subscribeMessage(){
        this.subscription = subscribe(this.context, SAMPLEMSG, (message)=>{this.handleMessage(message)}, {scope:APPLICATION_SCOPE})
        //console.log('message:', message);
        }
    handleMessage(message){
   // this.recievedMsg = message.lmsData.value ? message.lmsData.value :'No Message';
    if(message.lmsData.value)
    {
        this.recievedMsg = message.lmsData.value;
    }
    else{
        this.recievedMsg = 'No Mesage to Publish';
    }
    console.log('recievedMsg:', recievedMsg);

}
removeSubscription(){
    unsubscribe(this.subscription);
    this.subscription = null;
}
}