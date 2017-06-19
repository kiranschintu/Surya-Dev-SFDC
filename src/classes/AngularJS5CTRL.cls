global class AngularJS5CTRL {
    static List<Contact> Contacts;
    @RemoteAction
    global static List<Contact> myContacts(){
        return [select id, name, email from Contact Order By LastModifiedDate DESC LIMIT 1];
    }
    
    @RemoteAction
    global static void mydata(string data){
        system.debug('Data Came'+data);
        Contacts = new List<Contact>();
        contacts = (List<Contact>)JSON.deserialize(data,List<Contact>.class);
        system.debug('Final Contacts'+contacts);
    }
}