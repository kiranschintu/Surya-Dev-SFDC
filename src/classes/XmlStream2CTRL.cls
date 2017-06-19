public class XmlStream2CTRL{

    public List<Book> books{get;set;}
    public String xmlData{get;set;}
    public XmlStream2CTRL(){
        books = new List<Book>();
        //xmlData='<books><book>My Book</book><book>Your Book</book></books>';
        xmlData='<books><book><Name>My Book</Name><Version>1.0</Version></book><book><Name>Your Book</Name><Version>2.0</Version></book></books>';
        parseData(xmlData);
        system.debug('Books Info:::'+books);
    }
    
    public List<Book> parseData(String xmlData){
        XMLStreamReader reader = new XMLStreamReader(xmlData);
        while(reader.hasNext()){
            if(reader.getEventType() == xmlTag.START_ELEMENT){
                if(reader.getLocalName() == 'Book'){
                    system.debug('Book Found');
                    //read data
                    Book book = parseBook(reader);
                    system.debug('Book is:'+book);
                    books.add(book);
                }
            }
            reader.next();
        }
        
        return books;
    }
    
    public Book parseBook(xmlStreamReader reader){
        Book book = new Book();
        while(reader.hasNext()){
            if(reader.getEventType() == xmlTag.END_ELEMENT){
                break;
            }else{
                if(reader.getLocalName() == 'Name'){
                    book.Name = parseString(reader);
                }else if(reader.getLocalName() == 'Version'){
                    book.Version = parseString(reader);
                }
                system.debug('Book Name found:'+reader.getLocalName());
            }
            reader.next();
        }
        return book;
    }
    
    public String parseString(xmlStreamReader reader){
        String text='';
        while(reader.hasNext()){
            if(reader.getEventType() == xmlTag.END_ELEMENT){
                break;
            }else if(reader.getEventType() == xmlTag.CHARACTERS){
                text = reader.getText();
            }
            reader.next();
        }
        return text;
    }
    
    
    public class Book{
        public String Name{get;set;}
        public String Version{get;set;}
        public String Author{get;set;}
    }
}