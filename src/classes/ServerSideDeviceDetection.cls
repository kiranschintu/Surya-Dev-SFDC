public with sharing class ServerSideDeviceDetection{
public boolean isIPhone{get;set;}
public boolean isAndroid{get;set;}
public boolean isDesktop{get;set;}
public ServerSideDeviceDetection(){
String userAgent = System.currentPageReference().getHeaders().get('User-Agent');
isIPhone = userAgent.contains('iPhone');
isAndroid = userAgent.contains('Android');
isDesktop = userAgent.contains('Desktop');
}
public PageReference detectDevice(){
if(isIPhone)
return Page.PhoneVersion.setRedirect(true);
else if(isAndroid)
return Page.PhoneVersion.setRedirect(true);
else if(isDesktop)
return Page.DesktopVersion.setRedirect(true);
else
return null;
}
}