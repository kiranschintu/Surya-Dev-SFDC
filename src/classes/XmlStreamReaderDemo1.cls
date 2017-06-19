public class XmlStreamReaderDemo1 {

    // Create a class Book for processing
    public class Address{
        String AddressType;
        String Street;
        String City;
        Boolean isNotValid;
    }

    public Address[] parseBooks(XmlStreamReader reader) {
        Address[] books = new Address[0];
        while(reader.hasNext()) {
            // Start at the beginning of the book and make sure that it is a book
            if (reader.getEventType() == XmlTag.START_ELEMENT) {
                if ('Address' == reader.getLocalName()) {
                    Address book = parseBook(reader);
                    books.add(book);
                    system.debug('Hello Book');
                    
                }
            }
            // Always use hasNext() before calling next() to confirm 
            // that we have not reached the end of the stream
        reader.next();
        }
        
        return books;
    }

    // Parse through the XML, determine the author and the characters
    Address parseBook(XmlStreamReader reader) {
        Address book = new Address();
        book.AddressType = reader.getAttributeValue(null, 'ID');
        while(reader.hasNext()) {
               if('Address2'==reader.getLocalName()){
                    
                    book.Street = tagValue(reader);
                }
                else if('City'==reader.getLocalName()){
                    book.City= tagValue(reader);   
                }else if('Error'==reader.getLocalName()){
                    book.isNotValid=true;
                }else if (reader.getEventType() == XmlTag.END_ELEMENT) {
                    break;
            }
            reader.next();
        }
        return book;
    }
    
    public String tagValue(XmlStreamReader reader){
        String returnvalue = '';
        while(reader.hasNext()) 
        {
            if (reader.getEventType() == XmlTag.END_ELEMENT) 
            {
                break;
            } else if (reader.getEventType() == XmlTag.CHARACTERS) 
            {
                returnvalue=reader.getText();
            }
        reader.next();
        }
        return returnvalue;
    }
}