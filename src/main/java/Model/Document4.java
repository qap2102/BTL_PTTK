package Model;

public class Document4 {

    private int id;
    private String documentCode;
    private DocumentType4 documentType;
    private String documentTitle;
    private String author;
    private String publisher;
    private String publicationYear;
    private DocumentCategory4 documentCategory;

    public Document4() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDocumentCode() {
        return documentCode;
    }

    public void setDocumentCode(String documentCode) {
        this.documentCode = documentCode;
    }

    public DocumentType4 getDocumentType() {
        return documentType;
    }

    public void setDocumentType(DocumentType4 documentType) {
        this.documentType = documentType;
    }

    public String getDocumentTitle() {
        return documentTitle;
    }

    public void setDocumentTitle(String documentTitle) {
        this.documentTitle = documentTitle;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getPublicationYear() {
        return publicationYear;
    }

    public void setPublicationYear(String publicationYear) {
        this.publicationYear = publicationYear;
    }

    public DocumentCategory4 getDocumentCategory() {
        return documentCategory;
    }

    public void setDocumentCategory(DocumentCategory4 documentCategory) {
        this.documentCategory = documentCategory;
    }

}
