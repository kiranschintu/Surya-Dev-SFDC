public with sharing class AngularJSBtnClick2CTRL {
    @RemoteAction
    public static void doSome(string fileData){
        system.debug('Hello::::'+fileData);
    }
}