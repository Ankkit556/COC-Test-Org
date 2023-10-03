import { LightningElement, wire } from 'lwc';
import getContacts from '@salesforce/apex/MapControllerLwc.getContacts';
const columns = [
    { label: 'Id', fieldName:'Id'},
    { label:'Title',fieldName:'title'},
    { label: 'Name', fieldName:'Name'},
    { label: 'Email', fieldName:'Email'},
];
export default class LwcFilteringAndSorting extends LightningElement {
    headings = ["Id","Name","Title","Email"];
    fullTableData = [];
    filteredData = [];
    columns = columns;
    delayTimer
    filterBy = "Name";
    sortBy = "Name";
    sortDirection = 'asc';
    async connectedCallback(){
        
    }
    @wire(getContacts)
    contactHandler({data, error}){
            if(data){
                console.log('data:', data);
                this.fullTableData = data;
                this.filteredData = data;
                this.filteredData = [...this.sortedBy(data)];
            }if(error){
                console.log('error:', error);
            }
        }
        get FilterByOption(){
            return [
                {label:"All", value:"All"},
                {label:"Id", value:"Id"},
                {label:"Name", value:"Name"},
                {label:"Title", value:"Title"},
                {label:"Email", value:"Email"}
            ]
        }
        get SortByOption(){
            return [
                {label:"Email", value:"Email"},
                {label:"Id", value:"Id"},
                {label:"Name", value:"Name"},
                {label:"Title", value:"Title"}
            ]
        }
        FilterByHandler(event){
            this.filterBy = event.target.value ;
        }
        SortByHandler(event){
            this.sortBy = event.target.value;
            this.filteredData = [...this.sortedBy(this.filteredData)];
        }
        sortedBy(data){
            const clonedData = [...data];
            clonedData.sort((a,b)=>{
                if(a[this.sortBy]===b[this.sortBy]){
                    return 0;
                }
                return this.sortDirection ==='desc' ?
                a[this.sortBy] > b[this.sortBy] ? -1:1 :
                a[this.sortBy] < b[this.sortBy] ? -1:1
                })
                return clonedData;
            }
        
        filterHandler(event){
            const {value} = event.target;
            window.clearTimeout(this.delayTimer);
            if(value){
                this.delayTimer = window.setTimeout(()=>{
                    console.log('value:', value);
                    this.filteredData = this.fullTableData.filter(eachObj=>{
                        if(this.filterBy === 'All'){
                            return Object.keys(eachObj).some(key=>{
                                return eachObj[key].toLowerCase().includes(value)
                            })
                        }else{
                            const val = eachObj[this.filterBy] ? eachObj[this.filterBy]:'';
                        return val.toLowerCase().includes(value);
                        }
                        
                        //Object.keys(eachObj) = ["Id", "Name","Title","Email"];
                        
                        
                    })
                }, 500)               ;
            }else{
                this.filteredData = [...this.fullTableData];
            }
            
        }
}