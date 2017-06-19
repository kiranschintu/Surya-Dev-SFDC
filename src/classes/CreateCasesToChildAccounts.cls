public class CreateCasesToChildAccounts{
    public static void createAccounts(List<Case> newCases){
        Set<Id> parentAccIds = new Set<Id>();
        Map<Id,Set<Id>> childAccMap = new Map<Id,Set<Id>>();
        for(Case cas: newCases){
            if(cas.AccountId!=null){
                parentAccIds.add(cas.AccountId);
            }
        }
        
        for(Account acc:[select id,ParentId  from Account where ParentID IN:parentAccIds AND ParentId!=null]){
            system.debug('accParentId>>>'+acc.ParentId);
            if(childAccMap.containsKey(acc.ParentId)){
                system.debug('accParentId>>>'+acc.ParentId);
                Set<id> childAIds = new Set<id>();
                childAIds = childAccMap.get(acc.ParentId) ;
                childAIds.add(acc.id);
                childAccMap.put(acc.ParentId,childAIds);
            }else{
                system.debug('accParentId>>>'+acc.ParentId);
                Set<id> childAIds = new Set<id>();
                childAIds.add(acc.id);
                childAccMap.put(acc.ParentId,childAIds);
            }
        }
        system.debug('childRecords>>>'+childAccMap);
        List<Case> newCasesCreate = new List<Case>();
        for(Case cas:newCases){
            if(childAccMap.containsKey(cas.AccountId)){
                for(Id accId:childAccMap.get(cas.AccountId)){
                    Case ca = cas.clone(false,true);
                    ca.AccountId = accid;
                    newCasesCreate.add(ca);
                }
            }
        }
        
        insert newCasesCreate;
    }
}