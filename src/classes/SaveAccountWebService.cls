global class SaveAccountWebService {

    webservice static Account createAccount(String name,String phone,String rating,String website,String description,String web)
    {
        Account c = new Account();
        c.Name = name;
        c.Phone = phone;
        c.Rating = rating;
        c.Website = website;
        c.Description = description;
        c.For_Webserivce__c = web;
        insert c;

        return c;
    }
    webservice static Account dispAccount(String id)
    {
        Account c = new Account();
        c = [select name, phone, rating, website,description,For_Webserivce__c from Account where id =:id];
        return c;
    }
}