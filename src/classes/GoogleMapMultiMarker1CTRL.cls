global class GoogleMapMultiMarker1CTRL{
    
    public static String responsegeo{get;set;}
    
    public GoogleMapMultiMarker1CTRL() {
        //doCallout();
    }
    
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
    public static List<ReponseWrapper> doCallout1(Double north,Double south,Double east,Double west,String dateFilter){
    //public static string doCallout1(Double north){
        System.debug('North::'+north+'south::'+south+'east::'+east+'west::'+west);
        List<ReponseWrapper> responseData = new List<ReponseWrapper>();
        Http htp = new Http();
        HttpRequest req = new HttpRequest();
        String endPoint = 'http://api.geonames.org/earthquakesJSON?north='+north+'&south='+south+'&east='+east+'&west='+west+'&maxRows=500&username=tiagopaisbluewolf';
        system.debug('EndPoint>>>'+endPoint);
        //http://api.geonames.org/earthquakesJSON?north=44.1&south=-9.9&east=-22.4&west=55.2&username=tiagopaisbluewolf
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        
        HttpResponse res = new HttpResponse();
        res = htp.send(req);
        responsegeo = res.getBody();
        
        responsegeo = responsegeo.replaceAll('datetime','rdatetime');//datetime is reserved keyword in salesforce while deserializing 
        JSONParser parser = JSON.createParser(responsegeo);
        while(parser.nextToken() != null){
            if ((parser.getCurrentToken() == JSONToken.START_ARRAY)){
                system.debug('Parser:::'+parser);
                responseData = (List<ReponseWrapper>)parser.readValueAs(List<ReponseWrapper>.class);
                system.debug('Found:::'+responseData);
            }
        }
        system.debug('responseData Length::'+responseData.size());
        Date curntDate = system.Today().addYears(-1);
        List<ReponseWrapper> responseFinal = new List<ReponseWrapper>();
        if(dateFilter=='yes'){
            for(ReponseWrapper rwrap :responseData){
                String todate = rwrap.rdatetime;
                Date dt = Date.valueOf(todate);
                if(dt>curntDate){
                    responseFinal.add(rwrap);
                }
            }
        }else{
            responseFinal.addAll(responseData);
        }
        responseData.clear();
        return responseFinal;
    }
    
    public class ReponseWrapper{
        public String rdateTime;
        public Double depth;
        public Double lng;
        public String src;
        public String eqid;
        public Double magnitude;
        public Double lat;
    }
    
}