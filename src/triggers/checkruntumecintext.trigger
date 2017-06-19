trigger checkruntumecintext on Account (before insert,before update) {
        
        
        Map<string,A__c> mymap = new Map<string,A__c>();
        for(A__c a:[select id,name,country__c,time_zone__c from A__c where country__c!=null and time_Zone__c !=null]){
            mymap.put(a.country__c+','+a.time_zone__c,a);
        }
        
        for(Account a:trigger.new){
            if(mymap.containskey(a.shippingCountry+','+a.time_zone__c))
            a.description=mymap.get(a.shippingCountry+','+a.time_zone__c).name;
        }
        
}