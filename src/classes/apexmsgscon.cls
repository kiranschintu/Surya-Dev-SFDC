public class apexmsgscon {
public list<contact> con;
public list<dhr__Sample__c> jun;
public list<account> acc;
   
   public apexmsgscon(ApexPages.StandardController controller) {
    //con=[select id,name from contact where id in (select id from dhr__Sample__c)];//dhr__NowConactJunction__cdhr__now__c]
    con = [select Contact.Account.Name,contact.account.type from contact];
    acc=[SELECT Name,(SELECT FirstName, LastName FROM Contacts ORDER BY LastName LIMIT 10)FROM Account];
    con=[select id,name from contact];
    
    }
    public list<contact> getrecords(){
    con=[select id,lastname from contact where id in (select dhr__Contact__c from dhr__Sample__c)];
    return con;
    }

    public string fn{get;set;}
    public string ln{get;set;}
    public string c{get;set;}
    public PageReference submit() {
        if(fn==''){
            ApexPages.message msg = new ApexPages.message(ApexPages.severity.INFO,'FName cannot be blank');
            ApexPages.addMessage(msg);
         }
         else if(ln==''){
            ApexPages.message msg = new ApexPages.message(ApexPages.severity.INFO,'LName cannot be blank');
            ApexPages.addMessage(msg);
         }
        else if(c==''){
            ApexPages.message msg = new ApexPages.message(ApexPages.severity.INFO,'City cannot be blank');
            ApexPages.addMessage(msg);
         }
         return null;
    }

}