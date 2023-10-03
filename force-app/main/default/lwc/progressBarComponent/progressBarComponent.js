import { LightningElement ,api} from 'lwc';

export default class ProgressBarComponent extends LightningElement {
    
    @api percentage = 10;
    @api Resetbar(){
        this.percentage = 50;
    }
}