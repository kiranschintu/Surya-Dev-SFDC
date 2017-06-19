public with sharing Class USPSAddressCallout{
    
    public static List<USPSAddressResponse> MakeCallout(Account account){
         List<USPSAddressResponse> uspsResponse = new List<USPSAddressResponse>();
         Boolean Status = false;
         if(account.id!=null){
            account = [select id,shippingstreet,shippingcity,shippingstate,shippingpostalcode,BillingStreet,BillingCity,BillingState,BillingPostalCode,USPS_Shipping_Address_Validated__c from Account where id=:account.id];
            Status = true;
         }else if((account.shippingstreet!=null && account.shippingstreet!='') || (account.shippingcity!=null && account.shippingcity!='') || (account.shippingstate!=null && account.shippingstate!='') || (account.shippingpostalcode!=null && account.shippingpostalcode!='')){
            Status = true; 
         }
         
         if(Status==true){   
            String endURL = 'http://production.shippingapis.com/ShippingAPITest.dll?API=Verify&XML=';
            //String xmlReq = '<AddressValidateRequest USERID="934COMPA2722"><Address><Address1></Address1><Address2>6406 IVY LN</Address2><City>GREENBELT</City><State>MD</State><Zip5>20770</Zip5><Zip4></Zip4></Address></AddressValidateRequest>';
            
            String xmlReq = '<AddressValidateRequest USERID="934COMPA2722">';
            if((account.shippingstreet!=null && account.shippingstreet!='') || (account.shippingcity!=null && account.shippingcity!='') || (account.shippingstate!=null && account.shippingstate!='') || (account.shippingpostalcode!=null && account.shippingpostalcode!='')){
                xmlReq += '<Address ID="0">';
                xmlReq += '<Address1></Address1>';
                xmlReq += '<Address2>'+account.shippingstreet+'</Address2>';
                xmlReq += '<City>'+account.shippingcity+'</City>';
                xmlReq += '<State>'+account.shippingstate+'</State>';
                xmlReq += '<Zip5>'+account.shippingpostalcode+'</Zip5>';
                xmlReq += '<Zip4></Zip4>';
                xmlReq += '</Address>'; 
            }
            if((account.BillingStreet!=null && account.BillingStreet!='') || (account.BillingCity!=null && account.BillingCity!='') || (account.BillingState!=null && account.BillingState!='') || (account.BillingPostalCode!=null && account.BillingPostalCode!='')){
                xmlReq += '<Address ID="1">';
                xmlReq += '<Address1></Address1>';
                xmlReq += '<Address2>'+account.BillingStreet+'</Address2>';
                xmlReq += '<City>'+account.BillingCity+'</City>';
                xmlReq += '<State>'+account.BillingState+'</State>';
                xmlReq += '<Zip5>'+account.BillingPostalCode+'</Zip5>';
                xmlReq += '<Zip4></Zip4>';
                xmlReq += '</Address>';
            }      
                    
            xmlReq += '</AddressValidateRequest>';
            
            String encodedURL = EncodingUtil.urlEncode(xmlReq, 'UTF-8');
            String finalURL = endURL+encodedURL;
            Http htp = new Http();
            
            HttpRequest req = new HttpRequest();
            req.setMethod('GET');
            req.setEndpoint(finalURL);
            
            HttpResponse res;
            if(!Test.isRunningTest()){
                res = htp.send(req);
            }else{
                res = new HttpResponse();
                String resp = '';
                resp += '<AddressValidateResponse>';
                resp += '<Address ID="0">';
                resp += '<Address2>2153 E GORDON DR</Address2>';
                resp += '<City>KINGMAN</City>';
                resp += '<State>AZ</State>';
                resp += '<Zip5>86409</Zip5>';
                resp += '<Zip4>2561</Zip4>';
                resp += '<ReturnText>Default address: The address you entered was found but more information is needed (such as an apartment, suite, or box number) to match to a specific address.</ReturnText>';
                resp += '</Address>';
                resp += '<Address ID="1">';
                resp += '<Address2>2153 E GORDON DR</Address2>';
                resp += '<City>KINGMAN</City>';
                resp += '<State>AZ</State>';
                resp += '<Zip5>86409</Zip5>';
                resp += '<Zip4>2561</Zip4>';
                resp += '<ReturnText>Default address: The address you entered was found but more information is needed (such as an apartment, suite, or box number) to match to a specific address.</ReturnText>';
                resp += '</Address>';
                resp += '</AddressValidateResponse>';
                
                res.setBody(resp);
            }
            String Response = res.getbody();
            system.debug('Response>>>'+Response);
            XmlStreamReader reader = new XmlStreamReader(Response);
            uspsResponse = ParseUSPSAddressResponse.parseAddressResonse(reader);
            
            system.debug('responseBody>>>'+uspsResponse+'Account@@@'+account);
        }
        return uspsResponse;
    }
}