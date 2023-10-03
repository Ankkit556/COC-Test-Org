import { LightningElement, wire } from 'lwc';
import {getPicklistValuesByRecordType, getObjectInfo} from 'lightning/uiObjectInfoApi'
import ACCOUNT_OBJECT from '@salesforce/schema/Account'
export default class GetPicklist extends LightningElement {
    ratingOptions
    industryOptions
    selectedRating
    selectedIndustry
    @wire(getObjectInfo, {objectApiName:ACCOUNT_OBJECT})
    objectInfo;

    @wire(getPicklistValuesByRecordType,{objectApiName:ACCOUNT_OBJECT, recordTypeId:'$objectInfo.data.defaultRecordTypeId'})
    picklistHandler(response){
        let data = response.data;
        let error = response.error;
        console.log("data:",data);

        if(data){
            console.log("data:",data);
            this.ratingOptions = this.picklistGenerator(data.picklistFieldValues.Rating)
            this.industryOptions = this.picklistGenerator(data.picklistFieldValues.Industry)
        }
        if(error){
            console.log(error)
        }
    }

    picklistGenerator(data){
        return data.values.map(item=>({"label":item.label,"value":item.value}))
    }
    changeHandler(event){
        console.log(event.target.name+"==>>"+event.target.value)
        if(event.target.name ==="industry"){
            this.selectedIndustry = event.target.value
        }
        if(event.target.name === "rating"){
            this.selectedRating = event.target.value
        }
    }
}