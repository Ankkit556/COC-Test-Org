import { LightningElement, wire , api} from 'lwc';
import getOpportunities from '@salesforce/apex/OpportunityController.getOpportunities';
import getContacts from '@salesforce/apex/OpportunityController.getContacts';
export default class ChartDemo extends LightningElement {
    /*This LWC is Used on chartDemo Lightning Page  */
    stagenme = [];
    stagenmeCount = [];
    contAccountLabel = [];
    contData = [];
    @wire(getOpportunities)
    opportunityHandler({data, error}){
        if(data){
            console.log('data:', data);
            const result = data.reduce((json, val)=>({...json, [val.StageName]:(json[val.StageName]|0)+1}),{});
            console.log('result:', result);
            if(Object.keys(result).length > 0) {
                this.stagenme = Object.keys(result);
                //console.log('stagenme:', stagenme);
                this.stagenmeCount = Object.values(result);
                //console.log('stagenmeCount:', stagenmeCount);
            }
        }
        if(error){
            console.log('error:', error);
        }
    }
    @wire(getContacts)
    contactHandler({data,error}){
        if(data){
           const result1 = data.reduce((json, val)=>({...json, [val.Account.Name]:(json[val.Account.Name]|0)+1}),{});
           console.log('data:', data);
           console.log('result1:', result1);
           if(Object.keys(result1).length > 0) {
                this.contAccountLabel = Object.keys(result1);
                //console.log('contAccountLabel:', contAccountLabel);
                this.contData = Object.values(result1);
                //console.log('contData:', contData);
        }
        }
        if(error){
            console.log('error:', error);
        }
    }
}