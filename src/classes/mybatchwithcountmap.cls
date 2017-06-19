global with sharing class mybatchwithcountmap implements Database.Batchable<sobject>{
    global Database.querylocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([select id ,Contacts_with_lead_Word_of_mouth__c,name,(select id,AccountId,leadsource from Contacts) from Account]);
    }
    
    global void execute(Database.BatchableContext bc,List<Account> scope){
        List<Contact> cons= new List<Contact>();
        for(Account acc :scope){
            cons.addAll(acc.contacts);
        }
        List<Account> updatedacc = new List<Account>();
        //store the recordsbased on picklist values
        Map<id,list<Contact>> mymappic1= new Map<id,list<Contact>>();
        Map<id,list<Contact>> mymappic2= new Map<id,list<Contact>>();
        list<Contact> conts=new list<Contact>();
        for(Contact c:cons){
            
            //for 1st picklsit value
            if(c.leadsource=='Word of mouth'){
                 if(mymappic1.containsKey(c.AccountId)){
                     //conts = mymappic1.get(c.AccountId);
                     conts.add(c);
                     mymappic1.put(c.AccountId,conts);
                 }else{
                     conts.add(c);
                     mymappic1.put(c.AccountId,conts);
                }
            }
            }
            //for second picklist value
             /*if(v.status=='Pending'){
                 if(myvehmappend.get(v.account__c)!=null){
              list<Vehical__c> aa = myvehmappend.get(v.account__c);
               myvehmappend.put(v.account__c,aa.add(v));
               }else{
                     list<Vehical__c> aa=new list<Vehical__c>();
               myvehmappend.put(v.account__c,aa.add(v));
            }
        }*/
   /*     
        for(Account a:mylist){ 
    List<Account> induslist = new List<Account>();
    if(a.Industry=='Energy'){
        if(mymap.containsKey(a.Industry))
        Induslist = mymap.get(a.Industry);
        Induslist.add(a);
        mymap.put(a.Industry,induslist);
    }
    else if(a.Industry=='Agriculture'){
        if(mymap1.get(a.Industry)!=null)
        Induslist = mymap1.get(a.Industry);
        induslist.add(a);
        mymap1.put(a.Industry,induslist);
    }
}*/
        
        for(Account acc:scope){
            if(mymappic1.containskey(acc.id)){
                acc.dhr__Contacts_with_lead_Word_of_mouth__c= mymappic1.get(acc.id).size();//assign first picklist value
            //if(myvehmappend.containskey(acc.id))
            //acc.accountcounttwovalue = myvehmappend.get(acc.id).size();//assign second picklist value
            updatedacc.add(acc);}
        }
        update updatedacc;

    }
    global void finish(Database.BatchableContext bc){
    }
}