package Model;

public class DocumentCopy4 {

    private int id;
    private String physicalCondition;
    private String storageLocation;
    private String copyCode;
    private Document4 document;

    public DocumentCopy4() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPhysicalCondition() {
        return physicalCondition;
    }

    public void setPhysicalCondition(String physicalCondition) {
        this.physicalCondition = physicalCondition;
    }

    public String getStorageLocation() {
        return storageLocation;
    }

    public void setStorageLocation(String storageLocation) {
        this.storageLocation = storageLocation;
    }

    public String getCopyCode() {
        return copyCode;
    }

    public void setCopyCode(String copyCode) {
        this.copyCode = copyCode;
    }

    public Document4 getDocument() {
        return document;
    }

    public void setDocument(Document4 document) {
        this.document = document;
    }

}
