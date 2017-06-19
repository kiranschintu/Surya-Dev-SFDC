public class Integration {
    public class IntegrationException extends Exception {
    }
    
    public class ExternalOrder {
        public String id {get; set;}
        public String order_number {get; set;}
    }
    
    // Post an array of invoices to the fulfillment service
    // This method is designed such that there are only two
    // queries regardless of the number of invoice IDs passed
    @future (callout=true)
    public static void postOrder(List<Id> invoiceIds) {
        // Get all the line items we'll need
        List<Line_Item__c> lineItems = [SELECT Name, Merchandise__c,
            Invoice_Statement__c, Units_Sold__c
            FROM Line_Item__c
            WHERE Invoice_Statement__c IN :invoiceIds];

        // Now group the line items by invoice
        Map<Id, Map<String, Line_Item__c>> lineItemsByInvoice = 
            new Map<Id, Map<String, Line_Item__c>>();
            
        for ( Line_Item__c lineItem : lineItems ) {
            Map<String, Line_Item__c> lineItemMap = 
                lineItemsByInvoice.get(lineItem.Invoice_Statement__c);
            if ( lineItemMap == null ) {
                lineItemMap = new Map<String, Line_Item__c>();
                lineItemsByInvoice.put(lineItem.Invoice_Statement__c, 
                    lineItemMap);
            }
            lineItemMap.put(lineItem.Name, lineItem);
        }
                
        // Create the JSON string
        JSONGenerator gen = JSON.createGenerator(true);
        
        gen.writeStartArray();
        
        for (Id invoiceId : invoiceIds) {
            // Get the invoice name. We'll also need the invoice record
            // later to set the order ID and update it
            gen.writeStartObject();
            gen.writeStringField('id', invoiceId);

            // Make a list of the line item names and sort it
            Map<String, Line_Item__c> lineItemMap = 
                lineItemsByInvoice.get(invoiceId);
            List<String> lineItemNames = 
                new List<String>(lineItemMap.keySet());
            lineItemNames.sort();

            // Now we can write the line items    
            gen.writeFieldName('line_items');
            
            gen.writeStartArray();
            
            for ( String name : lineItemNames ) {
               gen.writeObject(lineItemMap.get(name)); 
            }
            
            gen.writeEndArray();
            
            gen.writeEndObject();            
        }
        
        gen.writeEndArray();
        
        String jsonOrders = gen.getAsString();
        
        System.debug('jsonOrders: ' + jsonOrders);
        
        // Send the JSON data to the web service    
        HttpRequest req = new HttpRequest(); 

        req.setMethod('POST');
        req.setEndpoint('https://fulfillment.herokuapp.com/order');
        req.setHeader('Content-Type', 'application/json');
        req.setBody(jsonOrders);    

        Http http = new Http();

        HTTPResponse res = http.send(req);

        // Get all the invoices - we'll need to update them        
        List<Invoice_Statement__c> invoices = [SELECT Id
            FROM Invoice_Statement__c
            WHERE Id IN :invoiceIds];

        // Did it work?
        if (res.getStatusCode() != 200) {
            System.debug('Error from ' + req.getEndpoint() + ' : ' + 
                res.getStatusCode() + ' ' + res.getStatus());

            // Set all the invoice order IDs to '000000'
            for ( Invoice_Statement__c invoice : invoices ) {
                invoice.OrderId__c = '000000';
            }
        } else {
            // Parse out the external order numbers
            System.debug('Fulfillment service returned '+res.getBody());

            List<ExternalOrder> orders = 
                (List<ExternalOrder>)JSON.deserialize(res.getBody(), 
                List<ExternalOrder>.class);

            Map<Id, Invoice_Statement__c> invoiceMap = 
                 new Map<Id, Invoice_Statement__c>(invoices);
                 
            // Set the order numbers in the invoices
            for ( ExternalOrder order : orders ) {
                Invoice_Statement__c invoice = invoiceMap.get(order.id);

                invoice.OrderId__c = order.order_number;
            }
        }
        
        update invoices;
    }
}