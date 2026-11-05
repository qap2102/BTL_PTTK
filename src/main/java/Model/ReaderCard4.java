package Model;

import java.sql.Date;

public class ReaderCard4 {

    private int id;
    private Date issueDate;
    private Date expiryDate;
    private String status;
    private Reader4 readerInfo;

    public ReaderCard4() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Reader4 getReaderInfo() {
        return readerInfo;
    }

    public void setReaderInfo(Reader4 readerInfo) {
        this.readerInfo = readerInfo;
    }

}
