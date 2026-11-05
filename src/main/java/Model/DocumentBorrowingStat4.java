package Model;

public class DocumentBorrowingStat4 extends Document4 {

    private int totalDocuments;
    private int totalBorrowCount;

    public DocumentBorrowingStat4() {
    }

    public int getTotalDocuments() {
        return totalDocuments;
    }

    public void setTotalDocuments(int totalDocuments) {
        this.totalDocuments = totalDocuments;
    }

    public int getTotalBorrowCount() {
        return totalBorrowCount;
    }

    public void setTotalBorrowCount(int totalBorrowCount) {
        this.totalBorrowCount = totalBorrowCount;
    }

}
