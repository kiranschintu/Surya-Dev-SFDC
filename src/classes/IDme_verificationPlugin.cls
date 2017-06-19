global class IDme_verificationPlugin implements Process.Plugin {
    global static Process.PluginResult invoke(Process.PluginRequest request) { 
        String fName = (String) request.inputParameters.get('First Name');
        String lname = (String) request.inputParameters.get('Last Name');
        String ssn = (String) request.inputParameters.get('SSN');
        String bDate = (String) request.inputParameters.get('Birth Date');
        String sDate = (String) request.inputParameters.get('Service Date');
        String authProviderName = (String) request.inputParameters.get('Auth Provider Name');
        
        IDme_verification verification = new IDme_verification();
        IDme_verification.verificationRequest vReq = new IDme_verification.verificationRequest(fname, lname, ssn, bDate, sDate);
        
        String verifyResult;
        verifyResult = verification.verify(vReq, authProviderName);
        system.debug('message back from verify: '+verifyResult);
        Map<String,Object> result = new Map<String,Object>();
        result.put('Verified',verifyResult);
        return new Process.PluginResult(result); 
    } 

    global Process.PluginDescribeResult describe() { 
        Process.PluginDescribeResult result = new Process.PluginDescribeResult(); 
        result.Tag = 'Identity';
        result.Name = 'Verify with ID.me';
        result.inputParameters = new List<Process.PluginDescribeResult.InputParameter>{};
        result.inputParameters.add(new Process.PluginDescribeResult.InputParameter('First Name', Process.PluginDescribeResult.ParameterType.String, true) );
        result.inputParameters.add(new Process.PluginDescribeResult.InputParameter('Last Name', Process.PluginDescribeResult.ParameterType.String, true) );
        result.inputParameters.add(new Process.PluginDescribeResult.InputParameter('SSN', Process.PluginDescribeResult.ParameterType.String, true) );
        result.inputParameters.add(new Process.PluginDescribeResult.InputParameter('Birth Date', Process.PluginDescribeResult.ParameterType.String, true) );
        result.inputParameters.add(new Process.PluginDescribeResult.InputParameter('Service Date', Process.PluginDescribeResult.ParameterType.String, true) );
        result.inputParameters.add(new Process.PluginDescribeResult.InputParameter('Auth Provider Name', Process.PluginDescribeResult.ParameterType.String, true) );

        result.outputParameters = new List<Process.PluginDescribeResult.OutputParameter>{}; 
        result.outputParameters.add(new Process.PluginDescribeResult.OutputParameter('Verified',Process.PluginDescribeResult.ParameterType.String));
        return result; 
    }    
    
}