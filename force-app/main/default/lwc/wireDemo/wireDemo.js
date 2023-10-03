import { LightningElement, wire} from 'lwc';
import { getRecord } from 'lightning/uiRecordApi'
import {getObjectInfo, getObjectInfos} from 'lightning/uiObjectInfoApi'
import Id from '@salesforce/user/Id'
import NAME_FIELD from '@salesforce/schema/User.Name';
import ACCOUNT_OBJECT from '@salesforce/schema/Account'
import CONTACT_OBJECT from '@salesforce/schema/Contact'
import EMAIL_FIELD from '@salesforce/schema/User.Email'
const fields = [NAME_FIELD, EMAIL_FIELD]
export default class WireDemo extends LightningElement {
     //console.log('userId:', userId);
    userDetail
    accountId
    Account
    objectInfo
    objects=[CONTACT_OBJECT, ACCOUNT_OBJECT]
    @wire(getRecord, {recordId:Id ,fields:fields})
    userDetailHandler(response){
        let data = response.data
        let error = response.error
        if(data){
            this.userDetail = data.fields
        }else{
            console.log(error)
        }
    }
    @wire(getObjectInfo,{objectApiName:ACCOUNT_OBJECT})
    accountDetail(response){
        let data = response.data
        let error  = response.error
        if(data){
            console.log('data:', data);
            this.accountId = data.defaultRecordTypeId
            this.Account = data.apiName
        }else{
            console.log('error:', error);
        }
    }
    @wire(getObjectInfos , {objectApiNames:'$objects'})
    objectDetails(response){
        let data = response.data
        let error = response.error
        if(data){
            console.log('data:', data);
            this.objectInfo = data
        }else{
            console.log('error:',error)
        }
    }
}