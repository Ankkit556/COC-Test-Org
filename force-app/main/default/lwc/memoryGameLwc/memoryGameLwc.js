import { LightningElement } from 'lwc';
import {loadStyle} from 'lightning/platformResourceLoader';
import fontawesome from '@salesforce/resourceUrl/font_awesome';
export default class MemoryGameLwc extends LightningElement {
    len =0
    libLoaded = false
    openCards=[];
    moves = 0;
    matchedCards=[];
    time = 0;
    count = 0;
    totalTime;
    timerRef;
    score=0;
    stars=[];
    congratulationModal = false
    cards=[ {id:1, listClass:"card", type:"angellist", icon:"fa fa-angellist"},
            {id:2, listClass:"card", type:"angellist", icon:"fa fa-angellist"},
            {id:3, listClass:"card", type:"android", icon:"fa fa-android"},
            {id:4, listClass:"card", type:"android", icon:"fa fa-android"},
            {id:5, listClass:"card", type:"anchor", icon:"fa fa-anchor"},
            {id:6, listClass:"card", type:"anchor", icon:"fa fa-anchor"},
            {id:7, listClass:"card", type:"bolt", icon:"fa fa-bolt"},
            {id:8, listClass:"card", type:"bolt", icon:"fa fa-bolt"},
            {id:9, listClass:"card", type:"apple", icon:"fa fa-apple"},
            {id:10, listClass:"card", type:"apple", icon:"fa fa-apple"},
            {id:11, listClass:"card", type:"cube", icon:"fa fa-cube"},
            {id:12, listClass:"card", type:"cube", icon:"fa fa-cube"},
            {id:13, listClass:"card", type:"leaf", icon:"fa fa-leaf"},
            {id:14, listClass:"card", type:"leaf", icon:"fa fa-leaf"},
            {id:15, listClass:"card", type:"bomb", icon:"fa fa-bomb"},
            {id:16, listClass:"card", type:"bomb", icon:"fa fa-bomb"}
    ]

    renderedCallback(){
        if(this.libLoaded){
            return
        }else{
            loadStyle(this, fontawesome+'/fontawesome/css/font-awesome.min.css').then((result) => {
                console.log('fontAwesome css Loaded succesfully')
            }).catch((err) => {
                console.log('err:', err);
            });
            this.libLoaded = true;
        }
        
    }
    displayCard(event){
        let currCard = event.target
        currCard.type= event.target.type
        console.log('currentCard',currCard.type)

        currCard.classList.add("show","open","disabled", "unclicked")
        this.openCards = this.openCards.concat(event.target)
        this.len = this.openCards.length
        console.log('len:', this.len)
        console.log('openCard', this.openCards)
        if(this.len===2){
            if(this.moves ===1){
                this.timer();
            }
            this.moves = this.moves + 1;
            console.log('moves:', this.moves);
            if(this.openCards[0].type === this.openCards[1].type){
                
                this.matchedCards = this.matchedCards.concat(this.openCards[0], this.openCards[1]);
                
                setTimeout(()=>{
                    this.matched();

                },700)
                this.len = 0;
            }else{
                this.unmatched();
                this.len = 0;
            }
        }
        console.log('if condition not working:');
    }
    matched(){
        this.score++;
        this.openCards[0].classList.add("match");
        this.openCards[1].classList.add("match");   
        this.openCards[0].classList.remove("show","unclicked");
        this.openCards[1].classList.remove("show","unclicked");
        this.openCards = [];
        if(this.matchedCards.length === 16){
            window.clearInterval(this.timerRef);
            
            this.congratulationModal = true
            this.rating();
        }
    }

    unmatched(){
        this.action('disable');
        this.openCards[0].classList.add("unmatched");
        this.openCards[1].classList.add("unmatched");   
          
        setTimeout(()=>{
            this.openCards[0].classList.remove("show" , "disabled","unmatched");
            this.openCards[1].classList.remove("show" , "disabled","unmatched");
            
            this.openCards = [];
        },1100)
        this.action('enable');  
        
        
    }
    action(action){
        let cardList = this.template.querySelectorAll(".card");
        Array.from(cardList).forEach(item=>{
            if(action === 'enable'){
                let isMatch = item.classList.contains('match');
                if(!isMatch){
                    item.classList.remove('disabledd')
                }
            }
            if(action ==='disable'){
                item.classList.add('disabledd')
            }
        });
 
    }
    // function for timer
    timer(){
        let startTime = new Date();
        this.timerRef =  setInterval(() => {
            
            this.count++;
            if(this.count>59){
                this.time = this.time + 1; 
                this.count = 0;
            }
            this.totalTime = this.time+":"+this.count;
        }, 1000);
        //this.totalTime = this.time+":"+this.count;
    }

    shuffle(){
        this.openCards=[]
        this.matchedCards=[]
        this.score=0
        this.totalTime="00:00"
        this.moves= 0
        this.congratulationModal = false
        window.clearInterval(this.timerRef)
        let ele = this.template.querySelectorAll('.card')
        Array.from(ele).forEach(item=>{
            item.classList.remove("show", "disabled","disabledd","match")
        })
        let array=[...this.cards]
        let counter = array.length;
        while(counter>0){
            let index = Math.floor(Math.random()*counter)
            counter--
            let temp = array[counter]
            array[counter]=array[index]
            array[index]=temp
        }
        this.cards = [...array]
    }

    get ratings(){
        if(this.moves<=12){
            this.stars=['* * *']
        }else if(this.moves<=18 && this.moves>12){
            this.stars=['* *']
        }else if(this.moves>18){
            this.stars=['*']
        }
        return this.stars
    }
}