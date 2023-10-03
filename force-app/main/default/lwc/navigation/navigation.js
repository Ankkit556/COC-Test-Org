import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation'
export default class Navigation extends NavigationMixin(LightningElement) {

    navigateToLwc(){
        var defination={
            componentDef:'c:testComponent',
            attributes:{
                recordId:'65765654FG'
            }
        }
        this[NavigationMixin.Navigate]({
            type:'standard__webPage',
            attributes:{
                url:'/one/one.app#'+btoa(JSON.stringify(defination))
            }
            

        })
    }
    navigateToAura(){
        this[NavigationMixin.Navigate]({
            type:"standard__component",
            attributes:{
                componentName:"c__testAuraComponent"
            }
        })
    }
    navigateToVFPage(){
        this[NavigationMixin.Navigate]({
            type:'standard__webPage',
            attributes:{
                url:'/apex/testVF'
            }
        }).then(generatedUrl=>{
            console.log('generatedUrl:', generatedUrl);
            window.open(generatedUrl,"_blank")
        })
    }
}