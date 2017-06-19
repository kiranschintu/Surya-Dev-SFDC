global class AccountWebService{
    
    global class Contactinfo{
        Webservice String Name;
        Webservice String Phone;
        Webservice String Website;
            
    }
    webservice static Contactinfo contactinformation(Contactinfo cinf){
        
        Account acc = [SELECT id,Name,Phone,website from Account where id ='0019000000SoXZz'];
        cinf.Name=acc.name;
        cinf.phone=acc.phone;
        cinf.website=acc.website;
        
        return cinf;
    }
    webservice static String displayAccount(){
        Account acc = [SELECT id,Name,Phone,website from Account where id ='0019000000SoXZz'];
        return 'Details :'+acc.Id+' : '+acc.Name+' : '+acc.Phone+' : '+acc.website;
    }
    
    
}