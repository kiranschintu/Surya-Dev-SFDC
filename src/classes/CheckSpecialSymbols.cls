public class CheckSpecialSymbols{
    public static void check(){
    String Name = 'Hello,Surya;Kiran,Hello1;Hello2';
        
        List<String> OrgNames = New List<String>();
        
        if(Name.contains(',') || Name.contains(';')){
           List<String> NewName = Name.split(',');
            for(String s:NewName){
                If(s.contains(';')){
            		List<String> NewName1 = s.split(';');
                    for(String ss:NewName1){
                    Orgnames.add(ss);
                    }
                }else
                    OrgNames.add(s);
            }
            system.debug('Original Names are :'+OrgNames);
            system.debug('Original Names Size :'+Orgnames.size());
        }else
        System.debug('Name Does not contains any Special Symbols:');
    }
}