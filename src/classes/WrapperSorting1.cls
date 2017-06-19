public class WrapperSorting1 {
    public Map<String,WrapperAccount> wrappers{get;set;}
    public List<WrapperAccount> wrapperAccs{get;set;}
    public WrapperSorting1(){
        wrappers = new Map<String,WrapperAccount>();
        wrapperAccs = new List<WrapperAccount>();
        for(Account acc : [select id,name,Account_Number__c,AnnualRevenue,Rating from Account where Account_Number__c<60 AND Account_Number__c!=null order by Name]){
            Integer isPrimary = acc.Rating=='Hot' ? 1 :0;
            //WrapperAccount wp = new WrapperAccount(acc,isPrimary );
            WrapperAccount wp = new WrapperAccount();//(acc,isPrimary );
            wp.acc = acc;
            wp.isPrimary=isPrimary ;
            //wrappers.put(acc.name,wp);
            
            wrapperAccs.add(wp);
        }
        wrapperAccs.sort();
        //wrappers.values().sort();
    }
    
     public class WrapperAccount implements Comparable{
         public Account acc{get;set;}
         public Integer isPrimary{get;set;}
         /*public WrapperAccount(Account acc,Integer isPrimary){
             this.acc = acc;
             this.isPrimary = isPrimary;
         }*/
         
        //Sorting wrapper list based on csv column number
        public Integer compareTo(Object ObjToCompare) {
                
                WrapperAccount compareToPhone = (WrapperAccount)ObjToCompare;
                // The return value of 0 indicates that both elements are equal. 
                Integer returnValue = 0;
                //Desc
                if (acc.Account_Number__c < compareToPhone.acc.Account_Number__c){
                    // Set return value to a positive value. 
                    returnValue = 1;
                }
                //Asc
                else if (acc.Account_Number__c > compareToPhone.acc.Account_Number__c){
                    // Set return value to a negative value. 
                    returnValue = -1;
                }else{
                    // First value the same, consider second value
                    if (isPrimary < compareToPhone.isPrimary) {
                        return 1;
                    } else if (isPrimary > compareToPhone.isPrimary) {
                        return -1;
                    } else {
                        return 0;
                    }          
                }   
                return returnValue;  
        }
         
     }
}