Public with sharing Class ParseUSPSAddressResponse{
    public static List<USPSAddressResponse> parseAddressResonse(XmlStreamReader reader) {
        List<USPSAddressResponse> addressResponses = new List<USPSAddressResponse>();
        while(reader.hasNext()) {
            // Start at the beginning of the Address and make sure that it is a Address
            if (reader.getEventType() == XmlTag.START_ELEMENT) {
                if ('Address' == reader.getLocalName()) {
                    USPSAddressResponse addResponse = parseAddress(reader);
                    addressResponses.add(addResponse);
                }
            }
            reader.next();
        }
        return addressResponses;
    }

    // Parse through the XML, determine the author and the characters
    public static USPSAddressResponse parseAddress(XmlStreamReader reader) {
        USPSAddressResponse singleAddressWitRes = new USPSAddressResponse();
        USPSAddressResponse.AccountAddress singleAddr = new USPSAddressResponse.AccountAddress();
        if(reader.getAttributeValue(null, 'ID')!=null && reader.getAttributeValue(null, 'ID')!=''){
            String type = reader.getAttributeValue(null, 'ID');
            singleAddressWitRes.AddressType = type=='0' ? 'Service' : type=='1' ? 'Billing' : null;
        }
        while(reader.hasNext()) {
               if('Address2'==reader.getLocalName()){
                    singleAddr.Street = tagValue(reader);
                }else if('City'==reader.getLocalName()){
                    singleAddr.City= tagValue(reader);   
                }else if('State'==reader.getLocalName()){
                    singleAddr.State = tagValue(reader);
                }else if('Zip5'==reader.getLocalName()){
                    singleAddr.Zip5 = tagValue(reader);
                }else if('Zip4'==reader.getLocalName()){
                    singleAddr.Zip4 = tagValue(reader);
                }else if('Error'==reader.getLocalName()){
                    singleAddressWitRes.isNotValid = true;
                }else if (reader.getEventType() == XmlTag.END_ELEMENT) {
                    break;
                }
            reader.next();
        }
        singleAddressWitRes.USPSAddress = singleAddr;
        return singleAddressWitRes;
    }
    
    public static String tagValue(XmlStreamReader reader){
        String returnvalue = '';
        while(reader.hasNext()) 
        {
            if (reader.getEventType() == XmlTag.END_ELEMENT) 
            {
                break;
            } else if (reader.getEventType() == XmlTag.CHARACTERS) 
            {
                returnvalue=reader.getText();
            }
        reader.next();
        }
        return returnvalue;
    }
}