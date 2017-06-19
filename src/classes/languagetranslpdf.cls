public with sharing class languagetranslpdf {
    public String lang{get;set;}
    public String languageParam{ get { return LANGUAGE_PARAM; } }
    public final static String LANGUAGE_PARAM = 'l';

    public languagetranslpdf(ApexPages.StandardController controller) {
    lang=ApexPages.CurrentPage().getParameters().get('l');
    //LANGUAGE_PARAM ='zh_CN';
    }

}