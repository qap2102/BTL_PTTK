package Model;

public class ImportReceiptDetail4 {

    private int id;
    private int quantity;
    private ImportReceipt4 importReceipt;
    private Document4 document;

    public ImportReceiptDetail4() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public ImportReceipt4 getImportReceipt() {
        return importReceipt;
    }

    public void setImportReceipt(ImportReceipt4 importReceipt) {
        this.importReceipt = importReceipt;
    }

    public Document4 getDocument() {
        return document;
    }

    public void setDocument(Document4 document) {
        this.document = document;
    }

}
