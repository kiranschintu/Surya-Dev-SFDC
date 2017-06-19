(function(){
        var app = angular.module('myApp', []);
        app.controller('formCtrl', function($scope) {
            
            $scope.message='';
            $scope.messageHeader ='';           
            $scope.secondResponse = '';           
            $scope.attachFiles = [];            
            $scope.showCreateAgreement = true;
            $scope.showViewAgreement = false;
            $scope.isSubmitFlag=false;
            //var sub = $scope.isSubmitFlag;
			$scope.isSigned = false;            
            $scope.showUploadModal = false;
            $scope.isManualSubmit = true;
            
            var intMaxStringSize = 6000000;   
            var intMaxFileSize = 4350000;     
            var intChunkSize = 950000;         
            var intFileSize;
            var intPositionIndex;
            var boolDoneUploading;
            
            /* Method Name: showUploadDocument
            * Author Name: Kranthi Nirmala
            * Description: Show modal for document upload.
            */
            $scope.showUploadDocument = function(strDocName) {
                //var DocUploadURL = '{!$Label.AEXP_PEGA_DocUpload_URL}';
                var DocUploadURL = 'https://docupload.intra-qa.app.aexp.com/intrauploadcenter/SFCorp?CLIENT_ID=CD38EDB85BC1BB4S92BD153FF61D4FAEA';
                var strEnrollmentId = document.getElementById("enrollmentId").placeholder;      
                
                Visualforce.remoting.Manager.invokeAction(
                	'AEXP_DynamicEnrollmentPage_Controller.getDocUploadParameters',
                	strEnrollmentId,
                	function(result, event){
                		if (event.status) {
                			DocUploadURL = DocUploadURL+result;
                			if(strDocName != null){
                				DocUploadURL = DocUploadURL+'&doc_name='+strDocName;
                                alert(DocUploadURL);
                			}
                		}                
                });
                
                $scope.showUploadModal = true;
                $scope.docUploadModalHeader = 'Please Upload the Documents';
                //$scope.docUploadModalHeader = '{!$Label.AEXP_PEGA_UPLOAD_DOCUMENTS}';
                
                var docUploadFrame = document.getElementById('docUploadFrame');
                docUploadFrame.src = DocUploadURL;
                if (!$scope.$$phase) {
                    $scope.$apply();
                }                
            }
            /* Method Name: hideUploadDocument
            * Author Name: Kranthi Nirmala
            * Description: Hide modal for document upload.
            */
            $scope.hideUploadDocument = function() {
            	$scope.showUploadModal = false;
            }
                       
            /* Method Name: UploadDocument
            * Author Name: Nghia Tran
            * Description: Upload document to Opportunity.
            */
            $scope.UploadDocument = function(strId) {
                
                var objDocument = document.getElementById(strId + 'filename');  
                $scope.attachFiles = [];
                
                var objFile = document.getElementById(strId).files[0];
                var strEnrollmentId = document.getElementById("enrollmentId").placeholder;                
                
                  if(objFile != undefined) {
                    if(objFile.size <= intMaxFileSize) {
                        strAttachmentName = objFile.name;
                        var fileReader = new FileReader();
                        fileReader.onloadend = function(e) {
                            objAttachment = window.btoa(this.result);  //Base 64 encode the file before sending it
                            
                            intPositionIndex=0;
                            intFileSize = objAttachment.length;
                            
                            boolDoneUploading = false;
                            if(intFileSize < intMaxStringSize) {
                                
                                
                                if(intFileSize <= intPositionIndex + intChunkSize) {
                                    strAttachmentBody = objAttachment.substring(intPositionIndex);
                                    boolDoneUploading = true;
                                } else {
                                    strAttachmentBody = objAttachment.substring(intPositionIndex, intPositionIndex + intChunkSize);
                                }
                               
                                $scope.DocumentAttache = {
                                    strAttachmentName : objDocument.placeholder,
                                    strAttachmentBody : strAttachmentBody,
                                    strAttachmentId : document.getElementById(strId).id
                                };
                                $scope.attachFiles.push($scope.DocumentAttache);
                                Visualforce.remoting.Manager.invokeAction(
                                    'AEXP_DynamicEnrollmentPage_Controller.uploadAttachments',
                                    strEnrollmentId,
                                    angular.toJson($scope.attachFiles),    
                                    function(result, event){      
                                       // US413579 - Enrollment Form - Popup should be in the same format as save  - Shruti
                                        if (event.status) {                                                                                       
                                            //alert('File Uploaded Successfully');
											$scope.message = 'File Uploaded Successfully';
											$scope.messageHeader = 'Successful';
											showError.style.display = 'block';
											msgHeader.style.backgroundColor = 'green';										
											if (!$scope.$$phase) {
												$scope.$apply();
											}                                                                                        
                                        } else if (event.type === 'exception') {
                                            //alert('exception' + event.where);
											$scope.message = event.where;
											$scope.messageHeader = 'Exception';
											showError.style.display = 'block';
											msgHeader.style.backgroundColor = 'red';      
                                            if (!$scope.$$phase) {
												$scope.$apply();
											}  
                                        } else {
                                            //alert('else' + event.message);
                                            $scope.message = event.message;
											$scope.messageHeader = 'Exception';
											msgHeader.style.backgroundColor = 'red';
											showError.style.display = 'block';
                                            if (!$scope.$$phase) {
												$scope.$apply();
											}  
                                        }             
                                        
                                        
                                    }, 
                                    {escape: false}
                                );
                           } else {
                               // alert("Base 64 Encoded file is too large.  Maximum size is " + maxStringSize + " your file is " + fileSize + ".");
                                $scope.message = "Base 64 Encoded file is too large.";
                               $scope.messageHeader = 'Exception';
                               msgHeader.style.backgroundColor = 'red';
                               showError0.style.display = 'block';
                               if (!$scope.$$phase) {
                                   $scope.$apply();
                               }  
                            }                            
                        }
                        fileReader.onerror = function(e) {
                            //alert("There was an error reading the file.  Please try again.");
                            $scope.message = "There was an error reading the file.  Please try again.";
                            $scope.messageHeader = 'Exception';
                            msgHeader.style.backgroundColor = 'red';
                            showError0.style.display = 'block';
                            if (!$scope.$$phase) {
                                $scope.$apply();
                            }  
                        }
                        fileReader.onabort = function(e) {
                            //alert("There was an error reading the file.  Please try again.");
                            $scope.message = "There was an error reading the file.  Please try again.";
                            $scope.messageHeader = 'Exception';
                            msgHeader.style.backgroundColor = 'red';
                            showError0.style.display = 'block';
                            if (!$scope.$$phase) {
                                $scope.$apply();
                            }  
                        }
                        
                        fileReader.readAsBinaryString(objFile);  //Read the body of the file
                        
                    } else {
                       // alert("File must be under 4.3 MB in size.  Your file is too large.  Please try again.");
                        $scope.message = "File must be under 4.3 MB in size.  Your file is too large.  Please try again.";
                        $scope.messageHeader = 'Exception';
                        msgHeader.style.backgroundColor = 'red';
                        showError0.style.display = 'block';
                        if (!$scope.$$phase) {
                            $scope.$apply();
                        }   
                    }
                } else {
                    //alert("You must choose a file before trying to upload it");
                }                 
            }
            
            $scope.getRemoteResponse = function() { 
                var strEnrollmentId = document.getElementById("enrollmentId").placeholder;      
                
                //alert(strEnrollmentId);
                Visualforce.remoting.Manager.invokeAction(
                    'AEXP_DynamicEnrollmentPage_Controller.getFieldsFromWrapper',
                    strEnrollmentId,
                    function(result, event){
                    	//alert(event.status);
                        if (event.status) {
                          
                            var enrollmentResult = JSON.parse(result);
                            if(enrollmentResult.status_code == '200')
                            	$scope.enrollmentSecs = JSON.parse(result);
                            else
                            {
                                $scope.message = enrollmentResult.StatusMessage;
                                $scope.messageHeader = 'Exception';
                                msgHeader.style.backgroundColor = 'red';
                                showError0.style.display = 'block';
                               
                            }
                            // alert(JSON.parse(result));
                            //$scope.accounts = angular.copy($scope.accts);
                            if (!$scope.$$phase) {
                                $scope.$apply();
                            }
                            
                        } else if (event.type === 'exception') {
                            //alert(event.where);
                             $scope.message = 'Something went wrong. Please try again later.';
                            $scope.messageHeader = 'Exception';
                            msgHeader.style.backgroundColor = 'red';
                            showError0.style.display = 'block';
                            if (!$scope.$$phase) {
                                $scope.$apply();
                            }  
                        } else {
                           // alert(event.message);
                           $scope.message = 'Something went wrong. Please try again later.';
                            $scope.messageHeader = 'Exception';
                            msgHeader.style.backgroundColor = 'red';
                            showError0.style.display = 'block';
                            if (!$scope.$$phase) {
                                $scope.$apply();
                            }
                        }                        
                    }, 
                    {escape: false}
                );                
            } 
            
            $scope.saveDynamicData = function() { 
                var strEnrollmentId = document.getElementById("enrollmentId").placeholder;
                var counterForErrormsg = document.getElementById("countForErrormsg").placeholder;
                
                // $scope.getListAttachments(); 
                // alert(angular.toJson($scope.attachFiles));
                //alert($scope.enrollmentSecs);              
                
                Visualforce.remoting.Manager.invokeAction(
                    'AEXP_DynamicEnrollmentPage_Controller.saveDynamicData',
                    strEnrollmentId,
                    angular.toJson($scope.enrollmentSecs),   
                    // angular.toJson($scope.attachFiles), Nghia Tran remvoe
                    function(result, event){                    
                        if (event.status) {  
                            var saveResult = JSON.parse(result);
                           
                            if(saveResult.status_code == '200'){
                            	$scope.enrollmentSecs= JSON.parse(result);
                                var erroroccur='false';
                                angular.forEach($scope.enrollmentSecs.sections, function(value, key) {
                                    //alert('Value ' + value);
                                    
                                    if(value == '[object Object]'){
                                        
                                        angular.forEach(value, function(value2, key2) {
                                            
                                            if(key2 == 'field_value'){
                                                
                                                angular.forEach(value2, function(value3, key3) {
                                                    
                                                    if(value3 == '[object Object]'){ 
                                                        
                                                        angular.forEach(value3, function(value4, key4) {
                                                            
                                                            if(key4 == 'errorMsg'){
                                                                
                                                                //angular.forEach(value4, function(value5, key5) {                                                                
                                                                // alert('key4 ' + key4);    
                                                                // alert('value4 ' + value4);                                                                
                                                                //});                                                               
                                                                
                                                                if(value4 == 'RequiredErr' || value4 == 'ValidationErr'){
                                                                    erroroccur = 'true';            
                                                                }    
                                                            }                                                           
                                                        }); 
                                                    }                                                     
                                                });                                               
                                            }                                            
                                            
                                        });    
                                        
                                    }
                                    
                                });
                                
                                //alert('Print erroroccur ' + erroroccur);             
                                
                                if(erroroccur == 'true'){
                                    if (!$scope.$$phase) {
                                        $scope.$apply();
                                    }             
                                    
                                }
                                else{
                                    $scope.message = 'Data Saved Successfully';
                                    $scope.messageHeader = 'Successful';
                                    showError.style.display = 'block';
                                    msgHeader.style.backgroundColor = 'green';                              
                                    $scope.enrollmentSecs= JSON.parse(result);                              
                                    //$scope.accounts = angular.copy($scope.accts);
                                    if (!$scope.$$phase) {
                                        $scope.$apply();
                                    }                                
                                }
                            }
                            else
                            {
                                
                                $scope.message = saveResult.StatusMessage;
                                    //'Something went wrong. Please try again later.';
                                $scope.messageHeader = 'Exception';
                                msgHeader.style.backgroundColor = 'red';
                                showError0.style.display = 'block';
                                if (!$scope.$$phase) {
                                    $scope.$apply();
                                }  
                            }
                            
                        } else if (event.type === 'exception') {
                            //alert('exception' + event.where);
                            $scope.message = event.where;
                            $scope.messageHeader = 'Exception';
                            showError.style.display = 'block';
                            msgHeader.style.backgroundColor = 'red';
                            if (!$scope.$$phase) {
                                $scope.$apply();
                            }   
                        } else {
                            //alert('else' + event.message);
                            $scope.message = event.message;
                            $scope.messageHeader = 'Exception';
                            msgHeader.style.backgroundColor = 'red';
                            showError.style.display = 'block';
                            if (!$scope.$$phase) {
                                $scope.$apply();
                            }   
                        }        
                        
                    }, 
                    {escape: false}
                );
                
            }
            
           $scope.confirmDynamicData = function() { 
                var strEnrollmentId = document.getElementById("enrollmentId").placeholder;
                var errormsg = '';  

                //alert('Inside Confirm');
                Visualforce.remoting.Manager.invokeAction(
                 'AEXP_DynamicEnrollmentPage_Controller.confirmDynamicData',                   
                    strEnrollmentId,
                    function(result,event){
                                        
                                        
                          if (event.status) {
                                        
                                 $scope.secondResponse = JSON.parse(result);
                                       
                                           
                                 if($scope.secondResponse.status_message == 'Error'){
                                    //alert($scope.secondResponse.error_messages);             
                                    var count = 1;   
                                    for(var errCount=0;errCount<$scope.secondResponse.error_messages.length;errCount++){        
                                    
                                        if($scope.secondResponse.error_messages[errCount] == '[object Object]'){
                                           
                                          angular.forEach($scope.secondResponse.error_messages[errCount],
                                           function(value, key) {
                                            
                                            if(key == 'ElementLabel'){
                                                
                                               errormsg = errormsg + '(' + count++ + ')' +  value + '\r \n'; 
                                            }
                                            
                                          });
                                        
                                        }
                                    }    
                                    //alert(errormsg);
                                    $scope.message = errormsg;
                                    $scope.messageHeader = 'Validation Errors Under Request Body';
                                    showError4.style.display = 'block';
                                    msgHeader4.style.backgroundColor = 'red';                              
                                    if (!$scope.$$phase) {
                                    $scope.$apply();
                                    } 
                                 } else if($scope.secondResponse.status_message == 'Case created' ){                        
                                       
                                        $scope.message = $scope.secondResponse.icon_case_id;
                                        $scope.messageHeader = $scope.secondResponse.status_message;
                                        showError4.style.display = 'block';
                                        msgHeader4.style.backgroundColor = 'green';                              
                                        if (!$scope.$$phase) {
                                        $scope.$apply();
                                        }  
                                        $scope.isSubmitFlag=true; 
                                   }else{						   
				  
                                        $scope.message = $scope.secondResponse.status_message;
                                        $scope.messageHeader = $scope.secondResponse.status_message;
                                        showError4.style.display = 'block';
                                        msgHeader4.style.backgroundColor = 'red';                              
                                        if (!$scope.$$phase) {
                                        $scope.$apply();
                                        }
                                   
                                   }
                                            
                                  } else if (event.type === 'exception') {
                                            //alert('exception' + event.where);
                                            $scope.message = event.where;
                                            $scope.messageHeader = 'ICON Service is Down';
                                            showError4.style.display = 'block';
                                            msgHeader4.style.backgroundColor = 'red';
                                            if (!$scope.$$phase) {
                                            $scope.$apply();
                                            }
                                            
                                  } else {
                                            //alert('else' + event.message);
                                            $scope.message = event.message;
                                            $scope.messageHeader = 'Exception';
                                            msgHeader4.style.backgroundColor = 'red';
                                            showError4.style.display = 'block';
                                            if (!$scope.$$phase) {
                                            $scope.$apply();
                                            }
                                            
                                        }              
                                        
                                        
                                    }, 
                                    {escape: false}
                                );
                
            }     
            
            
            
            $scope.closeNotification = function() {
                //var showError = document.getElementById("showError");
                showError.style.display = 'none';
                
            }
            $scope.closeNotification2 = function() {
                //var showError = document.getElementById("showError");
                showError2.style.display = 'none';
                
            } 
            $scope.closeNotification3 = function() {
                //var showError = document.getElementById("showError");
                showError3.style.display = 'none';
                
            } 
            
            $scope.closeNotification4 = function() {
                //var showError = document.getElementById("showError");
                showError4.style.display = 'none';
                
            } 
            $scope.completeNotification = function() {
            	//Meghna Gupta US387965
               // var strOpportunityId = document.getElementById("OpportunityId").placeholder;    
               // window.location = '/'+strOpportunityId; 
				window.location = '/' +'apex/AEXP_EnrollmentDashboard';
                
            } 
            
            $scope.cancelDynamicData = function() {
                $scope.message = 'Any information that is changed will not be updated or saved. Are you sure you want to leave the page?';
                $scope.messageHeader = 'Please Confirm';
                showError2.style.display = 'block';
                msgHeader2.style.backgroundColor = 'green'; 
                
                
            }
            
            
            $scope.cancelDynamicDataVerification = function() {
                $scope.message = 'Any information that is changed will not be updated or saved. Are you sure you want to leave the page?';
                $scope.messageHeader = 'Please Confirm';
                showError3.style.display = 'block';                    
                msgHeader3.style.backgroundColor = 'green';                              
                
                
            }
   /* Method Name: ManualSubmit
    * Author Name: Meghna Gupta
    * Description: On checkbox click Manual Application Submitted
    */
           
    $scope.manualSubmit = function(strElementID,strvalue) {
        //alert(strElementID);
       //alert('initial'+strvalue);
        if(strElementID == '200' && strvalue == true) 
		{		
            
            //angular.element(document.getElementById('showManual'))[0].disabled = true;
            $scope.isManualSubmit = true;
            /*(alert('1st'+strvalue);
			$scope.isManualSubmit = true;
			if (!$scope.$$phase) {
                 $scope.$apply();
            }  */
		}
		else
        {
		
		 $scope.isManualSubmit = false;	
           // angular.element(document.getElementById('showManual'))[0].disabled = false;
           // alert('2nd'+strvalue);
            /*
            $scope.isManualSubmit = false;	
            //alert('-->m'+isManualSubmit);
			if (!$scope.$$phase) {
                 $scope.$apply();
            } */ 
        }
	}  
         
		
		 /* Method Name: cancelSetupData
         * Author Name: Meghna Gupta
         * Description: Cancel for Setup page.
         
			$scope.cancelSetupData = function() {
                $scope.message = 'Any information that is changed will not be updated or saved. Are you sure you want to leave the page?';
                $scope.messageHeader = 'Please Confirm';
                showError2.style.display = 'block';
                msgHeader2.style.backgroundColor = 'green';         
                
            }     
            
         */
            /* Method Name: echoSignAgreement
            * Author Name: Nghia Tran
            * Description: Save and open EchoSign page.
            */
            $scope.echoSignAgreement = function() { 
                var strOpportunityId = document.getElementById("OpportunityId").placeholder;   
                var strEnrollmentId = document.getElementById("enrollmentId").placeholder;
                                
                //$scope.getListAttachments(); 
                Visualforce.remoting.Manager.invokeAction(
                    'AEXP_DynamicEnrollmentPage_Controller.continueDynamicData',
                    strEnrollmentId,
                    angular.toJson($scope.enrollmentSecs),   
                    function(result, event){                    
                        if (event.status) {  
                            
                            $scope.enrollmentSecs= JSON.parse(result);
                            var erroroccur='false';
                            angular.forEach($scope.enrollmentSecs.sections, function(value, key) {
                                
                                if(value == '[object Object]'){
                                    
                                    angular.forEach(value, function(value2, key2) {
                                        
                                        if(key2 == 'field_value'){
                                            
                                            angular.forEach(value2, function(value3, key3) {
                                                
                                                if(value3 == '[object Object]'){ 
                                                    
                                                    angular.forEach(value3, function(value4, key4) {
                                                        
                                                        if(key4 == 'errorMsg'){
                                                            
                                                            if(value4 == 'RequiredErr' || value4 == 'ValidationErr'){
                                                                erroroccur = 'true';            
                                                            }    
                                                        }
                                                        
                                                    }); 
                                                } 
                                                
                                            });            
                                            
                                        }                         
                                        
                                        
                                    });    
                                    
                                }
                                
                            });                            
                            
                            if(erroroccur == 'true'){
                                if (!$scope.$$phase) {
                                    $scope.$apply();
                                }                               
                            }
                            else{
                    
                
                         Visualforce.remoting.Manager.invokeAction(
                        'AEXP_DynamicEnrollmentPage_Controller.sendToEchoSign',
                        strOpportunityId,
                        function(result, event){                    
                        if (event.status) { 
                             
                             $scope.message= result;                           
                            
                            // if Save function has error, display error 
                            if(result.match('Save Exception')){
                                // display error message for Save
                                $scope.message = result;
                                $scope.messageHeader = 'Exception';
                                showError4.style.display = 'block';                    
                                msgHeader4.style.backgroundColor = 'red';  
                                if (!$scope.$$phase) {
                                    $scope.$apply();
                                } 
                            }                           
                            
                            else if(result.match('The Authorized Signatory Contact Role')){
                                // display error message for EchoSign
                                
                                $scope.message = 'The Authorized Officer Signatory Role must be assigned before you create an Agreement';
                                $scope.messageHeader = 'Exception';
                                showError4.style.display = 'block';                    
                                msgHeader4.style.backgroundColor = 'red';  
                                if (!$scope.$$phase) {
                                    $scope.$apply();
                                } 
                            }
                            else{
                                // open EchoSign page
                                var strEchoSignResult = result;
                                if(strEchoSignResult.indexOf('Save Agreement is successfull') >= 0){
                                    var lstResults = strEchoSignResult.split(':');
                                    if(lstResults[1] != null)
                                        window.open ('/' + lstResults[1],'_self'); 
                                   
                                }
                                else{
                                    // display error message for EchoSign
                                    $scope.message = result;
                                    $scope.messageHeader = 'Exception';
                                    showError4.style.display = 'block';                    
                                    msgHeader4.style.backgroundColor = 'red';   
                                    if (!$scope.$$phase) {
                                        $scope.$apply();
                                 } 
                                }
                            }
                        }
                            
                        }, 
                        {escape: false}
                        );                               
                        }
                        } else if (event.type === 'exception') {
                            $scope.message = event.where;
                            $scope.messageHeader = 'Exception';
                            showError.style.display = 'block';
                            msgHeader.style.backgroundColor = 'red';
                            if (!$scope.$$phase) {
                                $scope.$apply();
                            } 
                        } else {
                            $scope.message = event.message;
                            $scope.messageHeader = 'Exception';
                            msgHeader.style.backgroundColor = 'red';
                            showError.style.display = 'block';
                            if (!$scope.$$phase) {
                                $scope.$apply();
                            } 
                        }              
                        
                        
                    }, 
                    {escape: false}
                );
                
            }
            
            $scope.continueDynamicData = function() { 
                var strEnrollmentId = document.getElementById("enrollmentId").placeholder;
                //alert(strEnrollmentId);
                Visualforce.remoting.Manager.invokeAction(
                    'AEXP_DynamicEnrollmentPage_Controller.continueDynamicData',
                    strEnrollmentId,
                    angular.toJson($scope.enrollmentSecs),   
                    //angular.toJson($scope.attachFiles),                    
                    function(result, event){   					
                        if (event.status) { 						
							
                            $scope.enrollmentSecs= JSON.parse(result);
                            var erroroccur='false';
                            var errElementID = '';
                            angular.forEach($scope.enrollmentSecs.sections, function(value, key) {                                
                                
                                if(value == '[object Object]'){
                                    
                                    angular.forEach(value, function(value2, key2) {
                                        
                                        if(key2 == 'field_value'){
                                            
                                            angular.forEach(value2, function(value3, key3) {
                                                
                                                if(value3 == '[object Object]'){ 
                                                    
                                                    angular.forEach(value3, function(value4, key4) {
                                                        
                                                        if(key4 == 'errorMsg'){
                                                            
                                                            if(value4 == 'RequiredErr' || value4 == 'ValidationErr'){
                                                                erroroccur = 'true';            
                                                            }    
                                                        }
                                                        if(key4 == 'strFirstErrElementID'){
                                                            
                                                            if(value4 != null && value4 != ''){
                                                                //alert(value4);
                                                                errElementID = value4;            
                                                            }                                                             
                                                        }                                                                                   
                                                    }); 
                                                } 
                                                
                                            });            
                                            
                                        }                         
                                        
                                        
                                    });    
                                    
                                }
                                
                            });
                            
                            
                            if(erroroccur == 'true'){
                                //alert('Inside Error ElementID ' +errElementID );    
                                
                
                                if (!$scope.$$phase) {
                                    $scope.$apply();
                                }
                                if(errElementID != null && errElementID != ''){
                                    var errElementId = document.getElementById(errElementID);
				    				errElementId.style.borderColor = "red";
                                    errElementId.focus();
                                }            
                                
                            }
                            else{                                                        
                                var frmEnrollent = document.getElementById("Enrollment");
                                var frmVerification = document.getElementById("Verification");
                                
                                frmEnrollent.style.display = 'none';  
                                frmVerification.style.display = 'block'; 
                                
                                //$scope.message = 'Data Saved Successfully';
                                //$scope.messageHeader = 'Successful';
                                //showError.style.display = 'block';
                                //msgHeader.style.backgroundColor = 'green';
                                
                                if (!$scope.$$phase) {
                                    $scope.$apply();
                                }                      
                            }
                        } else if (event.type === 'exception') {
                            //alert('exception' + event.where);
                            $scope.message = event.where;
                            $scope.messageHeader = 'Exception';
                            showError.style.display = 'block';
                            msgHeader.style.backgroundColor = 'red';
                            if (!$scope.$$phase) {
                                $scope.$apply();
                            } 
                        } else {
                            //alert('else' + event.message);
                            $scope.message = event.message;
                            $scope.messageHeader = 'Exception';
                            msgHeader.style.backgroundColor = 'red';
                            showError.style.display = 'block';
                            if (!$scope.$$phase) {
                                        $scope.$apply();
                            } 
                        }              
                        
                        
                    }, 
                    {escape: false}
                );
                
                // Nghia Tran - EchoSign
                Visualforce.remoting.Manager.invokeAction(
                    'AEXP_DynamicEnrollmentPage_Controller.getAgreementStatus',
                    strEnrollmentId,
                    function(result, event){                    
                        if (event.status) {  
							
                            var CreateAgreement = document.getElementById("CreateAgreement");
                            var ViewAgreement = document.getElementById("ViewAgreement");
                            if(result == 'Out for Signature' || result == 'Signed' || result == 'Waiting for Counter-Signature')
                            {
                                // show  View Agreement button                              
                                $scope.showCreateAgreement = false;
                                $scope.showViewAgreement = true;	
                                
								/*US451784 Verification Page - Submit button is available after signature is received --- Meghna */
								if(result == 'Signed')
								{
									$scope.isSigned = true;	
								} 
                                if (!$scope.$$phase) {
                                    $scope.$apply();
                                }  
								
                            }
							
                            else
                            {
                                $scope.showCreateAgreement = true;
                                $scope.showViewAgreement = false;
                                if (!$scope.$$phase){
                                    $scope.$apply();
                                }		
									
                            }
                        } else if (event.type === 'exception') {
                            //alert('exception' + event.where);
                            $scope.message = event.where;
                            $scope.messageHeader = 'Exception';
                            showError.style.display = 'block';
                            msgHeader.style.backgroundColor = 'red';
                            if (!$scope.$$phase) {
                                $scope.$apply();
                            } 
                        } else {
                            //alert('else' + event.message);
                            $scope.message = event.message;
                            $scope.messageHeader = 'Exception';
                            msgHeader.style.backgroundColor = 'red';
                            showError.style.display = 'block';
                            if (!$scope.$$phase) {
                                $scope.$apply();
                            } 
                        }              
                        
                        
                    }, 
                    {escape: false}
                );
                
                
                
                // Anshul Jain - Fetching Second Webservice Status
                Visualforce.remoting.Manager.invokeAction(
                    'AEXP_DynamicEnrollmentPage_Controller.getSecondWebServiceStatus',
                    strEnrollmentId,
                    function(result, event){                    
                        if (event.status) {  
                            
                            if(result != '' && result != null)
                            {
                                //Hide Submit button
                                $scope.isSubmitFlag = true;
                                
                                if (!$scope.$$phase) {
                                    $scope.$apply();
                                }  
                            }
                            
                                
                        } else if (event.type === 'exception') {
                            //alert('exception' + event.where);
                            $scope.message = event.where;
                            $scope.messageHeader = 'Exception';
                            showError.style.display = 'block';
                            msgHeader.style.backgroundColor = 'red';
                            if (!$scope.$$phase) {
                                $scope.$apply();
                            } 
                        } else {
                            //alert('else' + event.message);
                            $scope.message = event.message;
                            $scope.messageHeader = 'Exception';
                            msgHeader.style.backgroundColor = 'red';
                            showError.style.display = 'block';
                            if (!$scope.$$phase) {
                                $scope.$apply();
                            } 

                        }              
                        
                        
                    }, 
                    {escape: false}
                );
                
                
                
            }
			
			/* Enrollment Dashboard start */
            
			$scope.showOpportunityDown = false;
			$scope.showOpportunityUp = true;
			$scope.showTypeDown = false;
			$scope.showTypeUp = true;
			$scope.showTierDown = false;
			$scope.showTierUp = true;
			$scope.showProductDown = false;
			$scope.showProductUp = true;
			$scope.showPreCheckDown = false;
			$scope.showPreCheckUp = true;
			$scope.showAmountSpendDown = false;
			$scope.showAmountSpendUp = true;
			$scope.showIndustryDown = false;
			$scope.showIndustryUp = true;
			$scope.showContactDown = false;
			$scope.showContactUp = true;
			$scope.showStatusDown = false;
			$scope.showStatusUp = true;


			
			/* Method Name: getEnrollmentList
			* Author Name: Nghia Tran
			* Description: get enrollment and fill to dashboard
			*/
			var opId="{!strOpportunityId}";
			console.log('OPID>>'+opId);
			$scope.getEnrollmentList = function() { 
				
				Visualforce.remoting.Manager.invokeAction(
					'dhr.AEXP_EnrollmentDocuments_TestCTRL.getEnrollmentList',
					opId,
					function(result, event){
						if (event.status) {
							
							$scope.lstEnrollments = JSON.parse(result);
							
							if (!$scope.$$phase) {
								$scope.$apply();
							}
							
						} else if (event.type === 'exception') {
							$scope.message = event.message;
							$scope.messageHeader = 'Exception';
							showError.style.display = 'block';                    
							msgHeader.style.backgroundColor = 'red';  
							if (!$scope.$$phase) {
								$scope.$apply();
							} 
						   
							
						} else {
							$scope.message = event.message;
							$scope.messageHeader = 'Exception';
							showError.style.display = 'block';                    
							msgHeader.style.backgroundColor = 'red';  
							if (!$scope.$$phase) {
								$scope.$apply();
							} 
							
						}              
						
						
					}, 
					{escape: false}
				);
			}
								
			/* Method Name: sortEnrollmentList
			* Author Name: Nghia Tran
			* Paramter: Column name, sort type
			* Description: the function sort enrollment list
			*/
			$scope.sortEnrollmentList = function(strColummnName, strSortType) {
				
				Visualforce.remoting.Manager.invokeAction(
					'AEXP_EnrollmentDashboard_Controller.sortEnrollmentList',
					angular.toJson($scope.lstEnrollments), 
					strColummnName,
					strSortType,
					function(result, event){
						if (event.status) {
							if(strColummnName == 'stropportunityName')
							{
								if(strSortType == 'ASC')
								{
									$scope.showOpportunityUp = true;
									$scope.showOpportunityDown = false;
								}
								else
								{
									 $scope.showOpportunityDown = true;
									 $scope.showOpportunityUp = false;
								}
							}
							else if(strColummnName == 'strType')
							{
								if(strSortType == 'ASC')
								{
									$scope.showTypeUp = true;
									$scope.showTypeDown = false;
								}
								else
								{
									 $scope.showTypeDown = true;
									 $scope.showTypeUp = false;
								}
							}
							else if(strColummnName == 'strProduct')
							{
								if(strSortType == 'ASC')
								{
									$scope.showProductUp = true;
									$scope.showProductDown = false;
								}
								else
								{
									 $scope.showProductDown = true;
									 $scope.showProductUp = false;
								}
							}
							else if(strColummnName == 'strAnnualSpend')
							{
								if(strSortType == 'ASC')
								{
									$scope.showAmountSpendUp = true;
									$scope.showAmountSpendDown = false;
								}
								else
								{
									 $scope.showAmountSpendDown = true;
									 $scope.showAmountSpendUp = false;
								}
							}
							else if(strColummnName == 'strIndustry')
							{
								if(strSortType == 'ASC')
								{
									$scope.showIndustryUp = true;
									$scope.showIndustryDown = false;
								}
								else
								{
									 $scope.showIndustryDown = true;
									 $scope.showIndustryUp = false;
								}
							}
							else if(strColummnName == 'strContact')
							{
								if(strSortType == 'ASC')
								{
									$scope.showContactUp = true;
									$scope.showContactDown = false;
								}
								else
								{
									 $scope.showContactDown = true;
									 $scope.showContactUp = false;
								}
							}
							else if(strColummnName == 'strStatus')
							{
								if(strSortType == 'ASC')
								{
									$scope.showStatusUp = true;
									$scope.showStatusDown = false;
								}
								else
								{
									 $scope.showStatusUp = false;
									 $scope.showStatusDown = true;
								}
							}
							$scope.lstEnrollments = JSON.parse(result);
							if (!$scope.$$phase) {
								$scope.$apply();
							} 
						} else if (event.type === 'exception') {
							$scope.message = event.message;
							$scope.messageHeader = 'Exception';
							showError.style.display = 'block';                    
							msgHeader.style.backgroundColor = 'red';  
							if (!$scope.$$phase) {
								$scope.$apply();
							} 
						} else {
							$scope.message = event.message;
							$scope.messageHeader = 'Exception';
							showError.style.display = 'block';                    
							msgHeader.style.backgroundColor = 'red';  
							if (!$scope.$$phase) {
								$scope.$apply();
							} 
						}              
						
						
					}, 
					{escape: false}
				);
				
			}
			
			/* Method Name: editFunction
			* Author Name: Nghia Tran
			* Paramter: Opportunity Id
			* Description: the function control when we click Edit button
			*/
			$scope.editFunction = function(strOppId) {
				Visualforce.remoting.Manager.invokeAction(
					'AEXP_EnrollmentDashboard_Controller.isEligible',
					strOppId,
					function(result, event){
						if (event.status) {
							if(result == 'Success'){
								window.open ('/apex/AEXP_DynamicEnrollmentPage?oppId=' + strOppId,'_self');
							}
							else
							{
                                $scope.message = result;
								$scope.messageHeader = 'Exception';
								showError.style.display = 'block';                    
								msgHeader.style.backgroundColor = 'red';  
								if (!$scope.$$phase) {
									$scope.$apply();
								} 
							}
						} else if (event.type === 'exception') {
							$scope.message = event.where;
							$scope.messageHeader = 'Exception';
							showError.style.display = 'block';                    
							msgHeader.style.backgroundColor = 'red';  
							if (!$scope.$$phase) {
								$scope.$apply();
							} 
						} else {
							$scope.message = event.message;
							$scope.messageHeader = 'Exception';
							showError.style.display = 'block';                    
							msgHeader.style.backgroundColor = 'red';  
							if (!$scope.$$phase) {
								$scope.$apply();
							} 
						}              
						
						
					}, 
					{escape: false}
				);
			   
			}


/* Method Name: setupFunction
			* Author Name: Shraddha Vidhate
			* Paramter: Opportunity Id
			* Description: the function control when we click Setup button
			*/
			$scope.setupFunction = function(strOppId) {
				Visualforce.remoting.Manager.invokeAction(
					'AEXP_EnrollmentDashboard_Controller.isEligible',
					strOppId,
					function(result, event){
						if (event.status) {
							if(result == 'Success'){
								window.open ('/apex/AEXP_SetUpPage?oppId=' + strOppId,'_self');
							}
							else
							{
								$scope.message = result;
								$scope.messageHeader = 'Exception';
								showError.style.display = 'block';                    
								msgHeader.style.backgroundColor = 'red';  
								if (!$scope.$$phase) {
									$scope.$apply();
								} 
							}
						} else if (event.type === 'exception') {
							$scope.message = event.where;
							$scope.messageHeader = 'Exception';
							showError.style.display = 'block';                    
							msgHeader.style.backgroundColor = 'red';  
							if (!$scope.$$phase) {
								$scope.$apply();
							} 
						} else {
							$scope.message = event.message;
							$scope.messageHeader = 'Exception';
							showError.style.display = 'block';                    
							msgHeader.style.backgroundColor = 'red';  
							if (!$scope.$$phase) {
								$scope.$apply();
							} 
						}              
						
						
					}, 
					{escape: false}
				);
			   
			}

           
           $scope.disabled = function() {
              if($scope.addInviteesDisabled) { return false;}
            }
            
            /* Enrollment Dashboard end */        
                
         
            /* Method Name: dependentField
			* Author Name: Nghia Tran
			* Paramter: Element Id
			* Description: the function control when we click Dependent drop down
			*/
            $scope.dependentField = function(strElementId) { 
                if(strElementId == 'BCA1143'){
                    $scope.LiabilityRequestedBCA1 = '';
                    $scope.BillingOptionBCA1 = [];
                    $scope.objData = {};
                    angular.forEach($scope.setUpSecs.sections, function(value, key) {
                                
                        if(value == '[object Object]'){
                            
                            angular.forEach(value, function(value2, key2) {
                                
                                if(key2 == 'field_value'){
                                    
                                    angular.forEach(value2, function(value3, key3) {
                                        
                                        if(value3 == '[object Object]'){ 
                                            if(value3.element_id == 'BCA1143'){
                                                $scope.LiabilityRequestedBCA1 = value3.value;
                                                
                                            }
                                            if(value3.element_id == 'BCA1195'){
                                                if($scope.LiabilityRequestedBCA1 == 'Combined'){ // move Combined custom setting
                                                    $scope.BillingOptionBCA1.push({'Label':'CBCP'});
                                                    value3.e_num = $scope.BillingOptionBCA1;
                                                }
                                                else if($scope.LiabilityRequestedBCA1 == 'Full Corporate'){
                                                    $scope.BillingOptionBCA1.push({"Label": "IBIP"},{"Label": "IBCP-Billed Balance"},{"Label": "IBCP-Approved Expense"});
                                                    
                                                    value3.e_num = $scope.BillingOptionBCA1;
                                                    value3.value = 'IBCP-Billed Balance';
                                                }
                                            }
                                        } 
                                        
                                    });            
                                    
                                }                         
                                
                                
                            });    
                            
                        }
                        
                    });
                    
                }
                
            }
            
            /* Method Name: toggleSelection
			* Author Name: Nghia Tran
			* Paramter: Element Id
			* Description: the function control when we click Checkbox
			*/
            $scope.toggleSelection = function(strElementId) {
                if(strElementId == 'Cardmember'){
                   // alert($scope.Cardmember);
                    
                    var objCardmember = angular.element(document.getElementById('Cardmember'));
                    if(objCardmember != null && objCardmember[0].value == 'true'){
                      //  angular.element(document.getElementById('Central - Renew Only'))[0].value = 'true';
                    }
                }
            }
            
            /* SetUp page end */             
            
            
        });
        
        
        /* Method Name: orderObjectBy
        * Author Name: Nghia Tran
        * Description: create a custom filter to sort element base on sort_order
        */
        app.filter('orderObjectBy', function() {
            return function(items, field, reverse) {
                var filtered = [];
                angular.forEach(items, function(item) {
                    filtered.push(item);
                });
                filtered.sort(function (a, b) {
                  //  return (parseInt(a[field],10) < parseInt(b[field],10) ? 1 : -1);
                    return (parseFloat(a[field],10) < parseFloat(b[field],10) ? 1 : -1);
                });
                if(reverse) filtered.reverse();
                return filtered;
            };
        });
        
        
    })();
    
    /* Method Name: documentChange
    * Author Name: Nghia Tran
    * Description: Assign value for Upload control.

    */

    function documentChange(){
        // Company Type: public 

        if(document.getElementById("108") != null)
	{
//	   document.getElementById("108filename").value = document.getElementById("108").value;	
	   getUploadFileName("108");

	}

        if(document.getElementById("109") != null)
	{ 
	
        //    document.getElementById("109filename").value = document.getElementById("109").value;
	      getUploadFileName("109");
	}
        
        // Company Type: Private 
        if(document.getElementById("97") != null)
            document.getElementById("97filename").value = document.getElementById("97").value;
        if(document.getElementById("98") != null)
            document.getElementById("98filename").value = document.getElementById("98").value;
        if(document.getElementById("100") != null)
            document.getElementById("100filename").value = document.getElementById("100").value;
        
        // Company Type: Non-Profit 
        if(document.getElementById("8") != null)
            document.getElementById("8filename").value = document.getElementById("8").value;
        
        // Company Type: Political
        if(document.getElementById("106") != null)
            document.getElementById("106filename").value = document.getElementById("106").value;
        if(document.getElementById("107") != null)
            document.getElementById("107filename").value = document.getElementById("107").value;
        
        // Company Type: Start Up
        if(document.getElementById("118") != null)
            document.getElementById("118filename").value = document.getElementById("118").value;
        if(document.getElementById("9") != null)
            document.getElementById("9filename").value = document.getElementById("9").value;
         if(document.getElementById("10") != null)
            document.getElementById("10filename").value = document.getElementById("10").value;
        if(document.getElementById("93") != null)
            document.getElementById("93filename").value = document.getElementById("93").value;
        if(document.getElementById("101") != null)
            document.getElementById("101filename").value = document.getElementById("101").value;
        
        // Company Type: Subsidiary
        if(document.getElementById("120") != null)
            document.getElementById("120filename").value = document.getElementById("120").value;
        if(document.getElementById("95") != null)
            document.getElementById("95filename").value = document.getElementById("95").value;
        if(document.getElementById("96") != null)
            document.getElementById("96filename").value = document.getElementById("96").value;
        if(document.getElementById("21") != null)
            document.getElementById("21filename").value = document.getElementById("21").value;
        
        // Company Type: Standard
        if(document.getElementById("94") != null)
            document.getElementById("94filename").value = document.getElementById("94").value;
        if(document.getElementById("119") != null) 
            document.getElementById("119filename").value = document.getElementById("119").value;
        
        
    }
	
	
	
   /* function documentChange(){
        // Company Type: public 
        if(document.getElementById("108") != null)
        {
	   //document.getElementById("108filename").value = document.getElementById("108").value;	
	   getUploadFileName("108");
	}

        if(document.getElementById("109") != null) 
        {
          document.getElementById("109filename").value = document.getElementById("109").value;
          getUploadFileName("109");
        }
        
        // Company Type: Private 
        if(document.getElementById("97") != null)
 	{
           // document.getElementById("97filename").value = document.getElementById("97").value;
	   getUploadFileName("97");
	}

        if(document.getElementById("98") != null)
        {
           //     document.getElementById("98filename").value = document.getElementById("98").value;
	   getUploadFileName("98");
	}
        if(document.getElementById("100") != null)
        {
           //     document.getElementById("100filename").value = document.getElementById("100").value;
	   getUploadFileName("100");
	}
        
        // Company Type: Non-Profit 
        if(document.getElementById("8") != null)
        {
           //     document.getElementById("8filename").value = document.getElementById("8").value;
	   getUploadFileName("8");
	}
        
        // Company Type: Political
        if(document.getElementById("106") != null)
        {
           //     document.getElementById("106filename").value = document.getElementById("106").value;
	   getUploadFileName("106");
	}
        if(document.getElementById("107") != null)
        {
           //     document.getElementById("107filename").value = document.getElementById("107").value;
	   getUploadFileName("107");
	}
        
        // Company Type: Start Up
        if(document.getElementById("118") != null)
        {
           //     document.getElementById("118filename").value = document.getElementById("118").value;
	   getUploadFileName("118");
	}
        if(document.getElementById("9") != null)
         {
           //    document.getElementById("9filename").value = document.getElementById("9").value;
	   getUploadFileName("9");
	}
         if(document.getElementById("10") != null)
         {
           //    document.getElementById("10filename").value = document.getElementById("10").value;
	   getUploadFileName("10");
	}
        if(document.getElementById("93") != null)
        {
           //     document.getElementById("93filename").value = document.getElementById("93").value;
	   getUploadFileName("93");
	}
        if(document.getElementById("101") != null)
        {
           //     document.getElementById("101filename").value = document.getElementById("101").value;
	   getUploadFileName("101");
	}
        
        // Company Type: Subsidiary
        if(document.getElementById("120") != null)
        {
           //     document.getElementById("120filename").value = document.getElementById("120").value;
	   getUploadFileName("120");
	}
        if(document.getElementById("95") != null)
        {
           //     document.getElementById("95filename").value = document.getElementById("95").value;
	   getUploadFileName("95");
	}
        if(document.getElementById("96") != null)
        {
           //     document.getElementById("96filename").value = document.getElementById("96").value;
	   getUploadFileName("96");
	}
        if(document.getElementById("21") != null)
        {
           //     document.getElementById("21filename").value = document.getElementById("21").value;
	   getUploadFileName("21");
	}
        
        // Company Type: Standard
        if(document.getElementById("94") != null)
        {
           //     document.getElementById("94filename").value = document.getElementById("94").value;
	   getUploadFileName("94");
	}
        if(document.getElementById("119") != null) 
        {
           //     document.getElementById("119filename").value = document.getElementById("119").value;
	   getUploadFileName("119");
	}
        
        
    }*/
    


 /* Method Name: getUploadFileName
    * Author Name: Praveen Srivastava
    * Description: Assign value for Upload control-To Resolve Fake path Defect.
    * Like Mozilla now its showing only file name in IE and Chrome browser	
    */
    
/*function getUploadFileName(id)
{
 
  var ctrlId=id+"filename";

  var val = navigator.userAgent.toLowerCase();

  if(val.indexOf("firefox") > -1)
  {

   	document.getElementById(ctrlId).value = document.getElementById(id).value;

  }

  else
  {

	document.getElementById(ctrlId).value = document.getElementById(id).files[0].name;
  }

}
*/
