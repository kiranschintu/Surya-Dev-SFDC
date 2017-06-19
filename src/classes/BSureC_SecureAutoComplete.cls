global with sharing class BSureC_SecureAutoComplete {
    @RemoteAction 
    global static SObject[] findSObjects(string obj, string qry, string addFields, string adnlQuery) 
    {
        /* More than one field can be passed in the addFields parameter
           Split it into an array for later use */
        List<String> fieldList=new List<String>(); 
        if (addFields != '')  
        fieldList = addFields.split(',');
        
        /* Check whether the object passed is valid */
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        Schema.SObjectType sot = gd.get(obj.toLowerCase());
        if (sot == null) 
        {
            return null;
        }
        //system.debug('qry---'+qry+'--addFields='+addFields);
        /* Creating the filter text */
        String filter = ' like \'' + String.escapeSingleQuotes(qry) + '%\'';
        
        /* Begin building the dynamic soql query */
        String soql = 'SELECT Id';
        
        /* If any additional field was passed, adding it to the soql */
        if (fieldList.size()>0) 
        {
            for (String s : fieldList) 
            {
                soql += ', ' + s;
            }
        }
        soql += ' from ' + obj + ' where '+ addFields + filter;
        //system.debug('adnlQuery+++++++++++' + adnlQuery);
        if(adnlQuery != null && adnlQuery != '')
        {
            list<string> lstQueryParam = adnlQuery.split('##');
            soql += ' AND ' + lstQueryParam[0] + ' = \'' + lstQueryParam[1] + '\'';
        }
        soql += ' order by '+addFields +' limit 20';
        
        //system.debug('Qry: '+soql);
        
        List<sObject> L = new List<sObject>();
        try 
        {
            L = Database.query(soql);
        }
        catch (QueryException e) 
        {
            //system.debug('Query Exception:'+e.getMessage());
            return null;
        }
        return L;
   }
}