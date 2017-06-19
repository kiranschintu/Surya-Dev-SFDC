public class ReaderFromCalloutSample {

  public String getAndParse() {

    // Get the XML document from the external server 
    
    Http http = new Http();
    HttpRequest req = new HttpRequest();
    req.setEndpoint('http://www.cheenath.com/tutorial/sample1/build.xml');
    req.setMethod('GET');
    HttpResponse res = http.send(req);

    // Log the XML content 
    
    System.debug(res.getBody());

    // Generate the HTTP response as an XML stream 
    
    String ac;
    XmlStreamReader reader = res.getXmlStreamReader();

    // Read through the XML 
    
    while(reader.hasNext()) {
      System.debug('Event Type:' + reader.getEventType());
      if (reader.getEventType() == XmlTag.END_ELEMENT) {
        System.debug(reader.getLocalName());
        ac=reader.getLocalName();
      }
      reader.next();
    }
    return ac;
 
  }
}