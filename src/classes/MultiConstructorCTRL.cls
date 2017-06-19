public with sharing class MultiConstructorCTRL{
    public MultiConstructorCTRL1 multiFormDt{get;set;}
    public MultiConstructorCTRL(){
        multiFormDt = new MultiConstructorCTRL1();
        multiFormDt.industry= 'IT';
        
        //MultiConstructorCTRL2 multi2 = new MultiConstructorCTRL2('Surya');
        multiFormDt.multyForms = new List<MultiConstructorCTRL2>();
        multiFormDt.multyForms.add(new MultiConstructorCTRL2('Surya'));
        multiFormDt.multyForms.add(new MultiConstructorCTRL2(27,2300000));
    }
}