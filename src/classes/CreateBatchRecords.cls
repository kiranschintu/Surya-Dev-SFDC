public class CreateBatchRecords{
    public static void doinsert(){
    	
        /*List<Batch1__c> batt = new List<Batch1__c>();
        for(Integer i=1;i<=100;i++){
        Batch1__c bat = new Batch1__c();
            bat.name='Hello1';
            batt.add(bat);
        }
        insert batt;
        List<Batch2__c> batt =[select id from Batch2__c];
        delete batt;*/
        /*Set<String> uniset = new Set<String>();
        List<Batch1__c> batt= [select id,name from Batch1__c];
        for(Batch1__c b:batt){
        uniset.add(b.name);
        }
        system.debug('Set Elements : '+uniset);*/
        Map<String,String> mymap = new Map<String,String>();
        mymap.put('One', 'One');
        mymap.put('One', 'Two');
        mymap.put('Two', 'Three');
        mymap.put('Two', 'Four');
        mymap.put('Three', 'Five');
        mymap.put('Three', 'Six');
        system.debug('Map Elements : '+mymap);
        
    }
}