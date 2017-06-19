public class StoreProductStockUpdate{
    /*public static void updateSPStock(String distChannel,List<csfs_Store_Product__c> storeProducts){
        Set<String> skuSet = new Set<String>();
        Map<String,List<SAP_Stock__c>> spaStockMap = new Map<String,List<SAP_Stock__c>>();
        List<csfs_Store_Product__c> storProdsToUpd = new List<csfs_Store_Product__c>();
        for(csfs_Store_Product__c strProdct:storeProducts){
            if(strProdct.SKU__c!=null){
                skuSet.add(strProdct.SKU__c);
            }
        }
        for(SAP_Stock__c sapStock:[Select id,name,N_mero_do_Material__c,Faixa_de_Vida_til__c,Estoque_avaliado_de_utiliza_o_livre__c from SAP_Stock__c where N_mero_do_Material__c IN:skuSet AND Centro__c=:distChannel]){
            String mapSapStckKey = distChannel +'~'+ sapStock.N_mero_do_Material__c;
            List<SAP_Stock__c> sapStockRecs = spaStockMap.get(mapSapStckKey);
            if(sapStockRecs==null){
                sapStockRecs = new List<SAP_Stock__c>();
            }
            sapStockRecs.add(sapStock);
            
            spaStockMap.put(mapSapStckKey,sapStockRecs);
        }
        
        for(csfs_Store_Product__c strProdct:storeProducts){
            if(strProdct.SKU__c!=null){
                String sapStprKey = distChannel +'~'+ strProdct.SKU__c;
                if(spaStockMap.containsKey(sapStprKey) && spaStockMap.get(sapStprKey)!=null){
                    strProdct.Quantity_G__c = 0;
                    strProdct.Quantity_O__c = 0;
                    strProdct.Quantity_R__c = 0;
                    strProdct.Quantity_Y__c = 0;
                    for(SAP_Stock__c sapStock:spaStockMap.get(sapStprKey)){
                        strProdct.Quantity_G__c = sapStock.Faixa_de_Vida_til__c=='0' ? sapStock.Estoque_avaliado_de_utiliza_o_livre__c : strProdct.Quantity_G__c; 
                        strProdct.Quantity_O__c = sapStock.Faixa_de_Vida_til__c=='01' ? sapStock.Estoque_avaliado_de_utiliza_o_livre__c : strProdct.Quantity_O__c;
                        strProdct.Quantity_R__c = sapStock.Faixa_de_Vida_til__c=='02' ? sapStock.Estoque_avaliado_de_utiliza_o_livre__c : strProdct.Quantity_R__c;
                        strProdct.Quantity_Y__c = sapStock.Faixa_de_Vida_til__c=='00' ? sapStock.Estoque_avaliado_de_utiliza_o_livre__c : strProdct.Quantity_Y__c;
                    }
                    
                    storProdsToUpd.add(strProdct);
                }
            }
        }
        
        if(!storProdsToUpd.isEmpty()){
            update storProdsToUpd;
        }
    }*/
}