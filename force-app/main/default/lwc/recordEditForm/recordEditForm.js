import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import CONTACT_OBJECT from '@salesforce/schema/Contact'
import NAME_FIELD from '@salesforce/schema/Contact.Name'
import TITLE_FIELD from '@salesforce/schema/Contact.Title'
import PHONE_FIELD from '@salesforce/schema/Contact.Phone'
import EMAIL_FIELD from '@salesforce/schema/Contact.Email'
import ACCOUNT_FIELD from '@salesforce/schema/Contact.AccountId'
export default class RecordEditForm extends LightningElement {
    objectName=CONTACT_OBJECT
    fields={
        accountid:ACCOUNT_FIELD,
        contactName:NAME_FIELD,
        title:TITLE_FIELD,
        phone:PHONE_FIELD,
        email:EMAIL_FIELD
    }
    toastMessage(event){
        const toast = new ShowToastEvent({
            variant:"success",
            title:"Contact Created!!",
            message:"Contact Id"+ event.detail.Id
        })
        this.dispatchEvent(toast)
    }
    resetHandler(){
        const inputFields= this.template.querySelectorAll('lightning-input-field')
        if(inputFields){
            Array.from(inputFields).forEach(field => {
                field.reset()
            });
        }
    }
}