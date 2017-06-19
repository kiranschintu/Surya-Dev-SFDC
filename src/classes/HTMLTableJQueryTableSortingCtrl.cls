public class HTMLTableJQueryTableSortingCtrl {
    public List<Contact> lstContact{get;set;}
    
    public HTMLTableJQueryTableSortingCtrl(){
        lstContact = [Select id,FirstName,Lastname,phone,MobilePhone,Email,Description from COntact limit 30];
    }
}