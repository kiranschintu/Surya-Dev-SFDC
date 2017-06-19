public class XMLDomReader{
    public String parse(String toParse) {
       DOM.Document doc = new DOM.Document();     
       try {
         doc.load(toParse);   
         DOM.XMLNode root = doc.getRootElement();
         String result = walkThrough(root);
         System.debug('Result>>>'+result);
         return result;
          
       } catch (System.XMLException e) {  // invalid XML
         return e.getMessage();
       }
     }
     
     public String walkThrough(DOM.XMLNode node) {
       String result='';
       if (node.getNodeType() == DOM.XMLNodeType.COMMENT) {
         return 'Comment (' +  node.getText() + ')';
       }
       if (node.getNodeType() == DOM.XMLNodeType.TEXT) {
         return 'Text (' + node.getText() + ')';
       }
       if (node.getNodeType() == DOM.XMLNodeType.ELEMENT) {
         system.debug('Node>>>'+node.getName());
         result += 'Element: ' + node.getName();
         if (node.getText().trim() != '') {
           result += ', text=' + node.getText().trim();
         }
         if (node.getAttributeCount() > 0) {
           for (Integer i = 0; i< node.getAttributeCount(); i++ ) {
             result += ', attribute #' + i + ':' + node.getAttributeKeyAt(i) + '=' + node.getAttributeValue(node.getAttributeKeyAt(i), node.getAttributeKeyNsAt(i));
           } 
         }
         for (Dom.XMLNode child: node.getChildElements()) {
           System.debug('Result###'+result);
           result += walkThrough(child);
         }
         return result;
       }
       return '';  //should never reach here
     } 
}