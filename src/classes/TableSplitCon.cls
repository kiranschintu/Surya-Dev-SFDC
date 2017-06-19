public with sharing class TableSplitCon {
    public List<Account> acc{get;set;}
    public Map<Integer,List<Account>> mainacc{get;set;}
    
    public TableSplitCon(){
        acc = [select id,name from Account limit 7];
        mainacc = new Map<Integer,List<Account>>();
        integer i=0;
        List<Account> accMod = new List<Account>();
        for(Account a:acc){
            accMod.add(a);
            Decimal size = acc.size();
            Decimal calSize = size/2;
            Decimal calSizeNew  = calSize.round(System.RoundingMode.CEILING);
            Decimal calSizeNew1  = calSize.round(System.RoundingMode.DOWN);
            system.debug('calSize %%%'+calSizeNew  +'Size&&& '+calSize );
            if((calSizeNew  ==accMod.size() && calSize!=acc.size()/2) || (calSize == acc.size()/2 && acc.size()/2==accMod.size())){
                mainacc.put(i,accMod);
                accMod = new List<Account>();
            }else if((calSizeNew1  ==accMod.size() && calSize!=acc.size()/2 && accMod .isEmpty())){
                mainacc.put(i,accMod);
                //accMod = new List<Account>();
            }
            
            i++;
        }
    }
}