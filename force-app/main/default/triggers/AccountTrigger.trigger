trigger AccountTrigger on Account (after insert) {
        if(trigger.isAfter){
            AccountTriggerHandler.AccountInsert(Trigger.new);
        }

}