public class quickEmailController{

private List<Contact> acc;
public String Combination='';
public String Combination1;

public quickEmailController(ApexPages.StandardsetController controller)
{
if(!Test.isRunningTest()){
acc = (List<contact>)controller.getSelected();
}else
{
     acc = [Select mobilephone From Contact Limit 1];
}
for (contact ac:acc){
            if(ac.mobilephone != null){
            //Combination = ac.MobilePhone;
                Combination += ','+ac.MobilePhone;
                Combination1 = Combination.substring(1,Combination.length());
                }else{
                Combination = null;
               break;   
           }
           }
}
 Public PageReference dosomething(){
    
            if (Combination != null) {
            
                if(acc.size() <150){
                    //do something
            }
            
   }
   ApexPages.Message noMobileMsg = new ApexPages.Message(ApexPages.severity.Info, 'for checking:-'+Combination+' '+combination.length()+' '+Combination1);
             ApexPages.addMessage(noMobileMsg);
   return null;

}
}