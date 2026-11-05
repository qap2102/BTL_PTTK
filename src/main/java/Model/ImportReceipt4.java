package Model;

import java.sql.Date;

public class ImportReceipt4 {

    private int id;
    private Date importDate;
    private Librarian4 librarian;
    private Supplier4 supplier;
    private ImportReceiptDetail4[] importList;

    public ImportReceipt4() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getImportDate() {
        return importDate;
    }

    public void setImportDate(Date importDate) {
        this.importDate = importDate;
    }

    public Librarian4 getLibrarian() {
        return librarian;
    }

    public void setLibrarian(Librarian4 librarian) {
        this.librarian = librarian;
    }

    public Supplier4 getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier4 supplier) {
        this.supplier = supplier;
    }

    public ImportReceiptDetail4[] getImportList() {
        return importList;
    }

    public void setImportList(ImportReceiptDetail4[] importList) {
        this.importList = importList;
    }

}
