public class MyCustomController { 

public MyCustomController() {}

@RemoteAction
    public static String createContact(string FirstName, string LastName) {
       Contact c = new Contact(FirstName=FirstName,LastName=LastName);
       insert c;
       return c.Id; 
       
    }

}