import { LightningElement , api } from 'lwc';

export default class P2cParentComponent extends LightningElement {
CorosalData =[
    {
                        src : "https://www.lightningdesignsystem.com/assets/images/carousel/carousel-01.jpg",
                        header : "First Card",
                        description : "First card description."
    },
    {
                        src : "https://www.lightningdesignsystem.com/assets/images/carousel/carousel-02.jpg",
                        header : "Second Card",
                        description : "Second card description."
    },
    {
                        src : "https://www.lightningdesignsystem.com/assets/images/carousel/carousel-03.jpg",
                        header : "Third Card",
                        description : "Third card description."
    }
]

@api value = 10
 showModal = false;
 msg
ChangeHandler(event){
    this.value = event.target.value;

}
handleClick(){
    this.template.querySelector('c-progress-bar-component').Resetbar();
}
ShowModals(){
    this.showModal = true   
}
closeHandler(event){
    this.msg = event.detail;
    this.showModal = false
}
}