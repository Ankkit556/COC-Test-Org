import { LightningElement } from 'lwc';
import USER_IMAGE from '@salesforce/resourceUrl/user_image';
import MOMENT from '@salesforce/resourceUrl/moment';
import {loadScript} from 'lightning/platformResourceLoader';
export default class ResourceComponent extends LightningElement {
    user_image = USER_IMAGE
    currentDate = ''
    currentDate1 = ''
    libLoaded = false
    renderedCallback(){
        if(this.libLoaded){
            return
        }else{
            Promise.all([
                loadScript(this, MOMENT+'/moment/moment.min.js')
            ]).then((result) => {
                this.setDate();
            }).catch((err) => {
                console.log('err:', err);
            });
            this.libLoaded = true;
        }
         
    }
    setDate(){
      this.currentDate =   moment().format('lll');  // Jun 14, 2021 2:58 PM
      this.currentDate1 =  moment().format('LLLL'); // Monday, June 14, 2021 2:58 PM
    }

}