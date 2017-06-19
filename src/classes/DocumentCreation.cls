public class DocumentCreation{
    public static void createdoc(){
        Document doc = new Document();
        	doc.Name = 'My Apex Document';
        	doc.FolderId = '00l90000001ZUiJ';
        	doc.ContentType = 'application/pdf';
        	String pdf = ''+'<HTML><Body>'+'<h1>'+'Hello'+'</h1><br/>'+'Welcome to Document Section';
            doc.Body = Blob.toPDF(pdf);
            doc.Type = 'pdf';
        	insert doc;
    }
}