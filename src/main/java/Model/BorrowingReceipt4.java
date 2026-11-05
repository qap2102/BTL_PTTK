package Model;

import java.sql.Date;

public class BorrowingReceipt4 {

    private int id;
    private Date returnDate;
    private Date borrowDate;
    private String status;
    private Reader4 reader;
    private Librarian4 librarian;
    private BorrowingReceiptDetail4[] borrowingList;

    public BorrowingReceipt4() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }

    public Date getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(Date borrowDate) {
        this.borrowDate = borrowDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Reader4 getReader() {
        return reader;
    }

    public void setReader(Reader4 reader) {
        this.reader = reader;
    }

    public Librarian4 getLibrarian() {
        return librarian;
    }

    public void setLibrarian(Librarian4 librarian) {
        this.librarian = librarian;
    }

    public BorrowingReceiptDetail4[] getBorrowingList() {
        return borrowingList;
    }

    public void setBorrowingList(BorrowingReceiptDetail4[] borrowingList) {
        this.borrowingList = borrowingList;
    }

}
