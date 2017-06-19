global with sharing class viewCon {

    public viewCon() {

    }

    
    Id recordId = ApexPages.currentPage().getParameters().get('id');
    public static String responsegeo{get;set;}
    String furl=null;
    list<string> finaladdr=new list<string>();
    list<string> lstaddr= new list<string>();
    List<Contact> obj= new List<Contact>();
    
    public viewCon(ApexPages.StandardController controller) {
        doCallout();
    }
    
    public List<Contact> getrecords(){
        obj=[Select id, name, description, latitude__C,dhr__Custom_Address__c ,longitude__C,MailingAddress,MailingCity from Contact where id IN ('0039000001kqQKg','0039000000z1Cye')];
        return obj;
    
    }
    
    /*public string getgmap(){
        Contact obj=[Select id, name, description, latitude__C,dhr__Custom_Address__c,longitude__C,MailingAddress from Contact where id=:recordId];
        furl='http://maps.google.com/maps/api/staticmap?center='+obj.dhr__Custom_Address__c+'&size=600x300&sensor=true';
        return furl;
    
    }*/
    
    //@RemoteAction
    public static string doCallout(){
        Http htp = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://api.geonames.org/earthquakesJSON?north=44.1&south=-9.9&east=-22.4&west=55.2&username=tiagopaisbluewolf');
        req.setMethod('GET');
        
        HttpResponse res = htp.send(req);
        responsegeo = res.getBody();
        return res.getBody();
        
    }
    
    @RemoteAction
    public static string doCallout1(Double north,Double south,Double east,Double west){
        System.debug('North::'+north+'south::'+south+'east::'+east+'west::'+west);
        Http htp = new Http();
        HttpRequest req = new HttpRequest();
        String endPoint = 'http://api.geonames.org/earthquakesJSON?north='+north+'&south='+south+'&east='+east+'&west='+west+'&username=tiagopaisbluewolf';
        //http://api.geonames.org/earthquakesJSON?north=44.1&south=-9.9&east=-22.4&west=55.2&username=tiagopaisbluewolf
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        
        HttpResponse res = htp.send(req);
        responsegeo = res.getBody();
        return res.getBody();
        
    }
    
}