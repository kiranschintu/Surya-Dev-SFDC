public with sharing class MultiConstructorCTRL2{
    public String name{get;set;}
    public Integer age{get;set;}
    public Integer salary{get;set;}
    public MultiConstructorCTRL2(string name){
        this.name = name;
    }
    
    public MultiConstructorCTRL2(integer age,integer salary){
        this.age = age;
        this.salary = salary;
    }
}