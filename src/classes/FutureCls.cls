public class FutureCls{
    @future//(limits='2xSOQL')
    public static void docall(){
        /*for(Integer i=0;i<300;i++){
            Account a = [select id,name from Account LIMIT 1];
        }*/
    }
    
}