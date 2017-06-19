public with sharing class VFPage2Cls {
    public List<Case> cases{get;set;}
    public Case cas{get;set;}
    public VFPage2Cls(){
        cas = new Case();
    }
    public void doSearch(){
        cases = [select id,CaseNumber from case];
    }
}