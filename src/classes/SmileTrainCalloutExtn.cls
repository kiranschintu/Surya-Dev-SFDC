public class SmileTrainCalloutExtn{

    Opportunity opp;
    public SmileTrainCalloutExtn(ApexPages.StandardController controller) {
        opp = (Opportunity)controller.getRecord();
    }
    
    public void doCallout(){
        //Creating instance to Http
        Http http = new Http();
        
        //Creating instance to HttpRequest and preparing request 
        HttpRequest req = new HttpRequest();

        req.setEndpoint('http://smiletrain.icreondemoserver.com/salesforceservices/st_services/6shj77/5');
        req.setMethod('GET');

        HTTPResponse res = http.send(req);

        RefundResult r = (RefundResult)JSON.deserializeStrict(res.getBody(), RefundResult.class);

        System.debug(res.getBody());

        System.debug('transaction_id -  ' + r.transaction_id);
        System.debug('currencyIsoCode -  ' + r.currencyIsoCode);
        System.debug('amount -  ' + r.amount);
        System.debug('merchantAccountId -  ' + r.merchantAccountId);
        System.debug('refundedTransactionId -  ' + r.refundedTransactionId);
        System.debug('processorResponseCode -  ' + r.processorResponseCode);
    }

}