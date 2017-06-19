public with sharing class ConstructorActionCls {
    public String result{get;set;}
    public ConstructorActionCls(){
        result = 'Constructor';
    }
    public void doAction(){
        result = 'This is Action method';
    }
}