public class HttpCalloutSample {
    // pass in the endpoint to be used using the string url
    @future//(callout=true)
    public static void doCallout(){
        // Instantiate a new http object
        Http h = new Http();
        String url = 'https://google.com';
        // Instantiate a new HTTP request, specify the method (GET) as 
        // well as the endpoint.
        //Create continuation with a timeout
Continuation con = new Continuation(40);

        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
        
        // send the request, and return a reaponse
        HttpResponse res = h.send(req);
        system.debug('Method Called');
    }
}