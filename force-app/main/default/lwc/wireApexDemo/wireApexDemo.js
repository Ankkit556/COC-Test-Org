import { LightningElement, wire } from 'lwc';
import getAccountList from '@salesforce/apex/AccountController.getAccountList'
export default class WireApexDemo extends LightningElement {
    @wire(getAccountList)
    accounts
}