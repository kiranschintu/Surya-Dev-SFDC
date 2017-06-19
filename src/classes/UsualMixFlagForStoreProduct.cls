Public class UsualMixFlagForStoreProduct{
    /*public static void UpdateUsualFlag(List<csfs_store_product__c> storeProducts){
        Set<String> skusSet = new Set<String>();
        Set<String> materialSet = new Set<String>();
        List<csfs_store_product__c> storeProdLstToUpd = new List<csfs_store_product__c>();
        
        for(csfs_store_product__c storeProd:storeProducts){
            skusSet.add(storeProd.SKU__c);
        }
        
        Integer CurrentMnth = system.today().month();
        
        for(Hist_rico_de_Vendas__c hrdeV:[Select id,name,Material__c,Ano_civil_m_s__c from Hist_rico_de_Vendas__c where Material__c IN:skusSet AND Ano_civil_m_s__c!=null]){
            Integer hrdevMnth = hrdeV.Ano_civil_m_s__c.length()==6 ? Integer.valueOf(hrdeV.Ano_civil_m_s__c.subString(4,6)): 0;
            system.debug('HR Dev month inside '+hrdevMnth );
            if(hrdevMnth!=0 && hrdevMnth <= currentMnth && hrdevMnth >= (currentMnth-2)){
                materialSet.add(hrdeV.Material__c);
            }
        }
        
        system.debug(materialSet);
        for(csfs_store_product__c storeProd:storeProducts){
            if(materialSet.contains(storeProd.SKU__c)){
                storeProd.IsUsual__c=true;
                storeProdLstToUpd.add(storeProd);
            }
        }
        
        if(!storeProdLstToUpd.isEmpty()){
            update storeProdLstToUpd;
        }
        
    }*/
}