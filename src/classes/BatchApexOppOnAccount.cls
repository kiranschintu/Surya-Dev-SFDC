global class BatchApexOppOnAccount implements Database.Batchable<sobject>{
	
    global Database.QueryLocator start(Database.BatchableContext bc){
    return Database.getQueryLocator([Select id,AccountId,createddate,dhr__Current_Fiscal_Year__c from Opportunity]);
    }
    global void execute(Database.BatchableContext bc,List<Opportunity> op){
        List<Opportunity> opp= new List<Opportunity>();
        List<Account> acc= [Select id from Account];
        List<Account> acc1=new List<Account>();
        for(Account a:acc){
        for(Opportunity o:op){
            
            //if(o.CreatedDate==system.Today()-1){
            o.dhr__Current_Fiscal_Year__c='Other';
            opp.add(o);
                if(a.id==o.AccountId){
                
                Decimal sum=0;
                if(o.amount!=Null)
                    sum+=o.Amount;
                a.OppSumBatch__c=sum;
                    acc1.add(a);
                
                }
            //}
                
            }
        }
        update opp;
        update acc1;
    }
    global void finish(Database.BatchableContext bc){
    	system.debug('Batch Job Executed');
    }
}