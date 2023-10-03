import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/MapControllerLwc.getAccounts';
export default class MapsLwc extends LightningElement {
    mapMarkers =[];
    markersTitle = 'Account Marker';
    selectedMarker
    @wire(getAccounts)
    wireHandler({data,error}){
        if(data){
            console.log('data:', data);
            this.formatResponse(data);
        }if(error){
            console.log('error:', error);
        }
    }
    formatResponse(data){
        this.mapMarkers = data.map(item=>{
            return{
                location:{
                    Street:item.BillingCity || '',
                    City:item.BillingCity || '',
                    PostalCode:item.BillingPostalCode || '',
                    State: item.BillingState || '',
                    Country:item.BillingCountry || ''
                },
                icon:'utility:salesforce1',
                title:item.Name,
                value:item.Name,
                description:item.description
            }
        })
        this.selectedMarker  = this.mapMarkers.length && this.mapMarkers[0].value;
    }

    callMarkerHandler(event){
        this.selectedMarker = event.detail.selectedMarkerValue;
    }
}