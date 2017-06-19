public class Ca_Mark_Order_Shipped_Extension 
{
    public ApexPages.StandardSetController setCon{get;set;}
    public integer getMySelectedSize() 
    {
        return setCon.getSelected().size();
    }

    public Ca_Mark_Order_Shipped_Extension(ApexPages.StandardSetController con) 
    {
        this.setCon =  con;
    }
    
    public PageReference markOrdersShipped()
    {
        List<Account> selectedOrders = (List<Account>) setCon.getSelected();

        selectedOrders = [SELECT Id FROM Account WHERE Id IN:selectedOrders];
        for(Account  ord : selectedOrders )
        {
            /*if(ord.Order_Status__c!='Approved')

            {
              
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Sorry!! you can select Orders only with Order Status Approved'));
              return null; 

            }
            else
            {
               ord.Order_Status__c =  'Shipped';
            }
            */
         }
         setCon.setSelected(selectedOrders);
         return setCon.save();

    }


   

}