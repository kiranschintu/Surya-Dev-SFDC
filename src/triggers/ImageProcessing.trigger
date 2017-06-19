trigger ImageProcessing on Account (After insert,After update) {

 if(Trigger.isInsert){
        new RTAConverter().convertImage(Trigger.new);
    }else{
        List<Account> sendToClass = new List<Account>();
        for(Account c: Trigger.new){
            if(c.dhr__Image__c!=Trigger.oldMap.get(c.Id).dhr__Image__c){
                sendToClass.add(c);
            }
        }
        new RTAConverter().convertImage(sendToClass);
    }

}