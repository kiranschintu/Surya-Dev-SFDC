public class MergeAccounts{
    public static void domerge(){
    	List<Opportunity> acc = [SELECT id,name,closedate from Opportunity order by Name ,closedate asc];
        /*try{
         merge acc acc1;
        }catch(Exception e){
        	system.debug('Exception :'+e);
        }*/
        system.debug('All elements :'+acc);
        Map<String,opportunity> accmap = new Map<String,opportunity>(); 
        for(Opportunity opp:acc){
        accmap.put(opp.name, opp);
        }
        for(Opportunity opp:acc){
            if(accmap.containsKey(opp.name)){
            system.debug('Map Key is :'+opp.Name);
            system.debug('Map value is :'+accmap.get(opp.Name).ID);
            }
        }
        //system.debug('Map First Element :'+accmap.values());
        SYSTEM.debug('Map Elements :'+accmap);
    }
}