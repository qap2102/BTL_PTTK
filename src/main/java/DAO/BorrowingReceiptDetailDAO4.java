
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BorrowingReceiptDetailDAO4 extends DAO {

    // Lấy thông tin phiếu mượn, bạn đọc và thủ thư
    public Map<String, Object> getReceiptById(int receiptId)
            throws SQLException, ClassNotFoundException {

        String sql =
            "SELECT " +
            "br.id AS receiptId, " +
            "br.borrowDate, " +
            "br.returnDate, " +
            "br.status, " +
            "r.readerCode, " +
            "reader.fullName AS readerName, " +
            "reader.email AS readerEmail, " +
            "reader.phoneNumber AS readerPhone, " +
            "staff.userName AS librarianCode, " +
            "staff.fullName AS librarianName " +
            "FROM tblBorrowingReceipt4 br " +
            "JOIN tblReader4 r " +
            "ON r.tblMember4id = br.tblReader4id " +
            "JOIN tblMember4 reader " +
            "ON reader.id = r.tblMember4id " +
            "JOIN tblLibrarian4 l " +
            "ON l.tblMember4id = br.tblLibrarian4 " +
            "JOIN tblMember4 staff " +
            "ON staff.id = l.tblMember4id " +
            "WHERE br.id = ?";

        try (Connection conn = con();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, receiptId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    Map<String, Object> receipt = new HashMap<>();

                    receipt.put("receiptId",
                            rs.getInt("receiptId"));

                    receipt.put("borrowDate",
                            rs.getDate("borrowDate"));

                    receipt.put("returnDate",
                            rs.getDate("returnDate"));

                    receipt.put("status",
                            rs.getString("status"));

                    receipt.put("readerCode",
                            rs.getString("readerCode"));

                    receipt.put("readerName",
                            rs.getString("readerName"));

                    receipt.put("readerEmail",
                            rs.getString("readerEmail"));

                    receipt.put("readerPhone",
                            rs.getString("readerPhone"));

                    receipt.put("librarianCode",
                            rs.getString("librarianCode"));

                    receipt.put("librarianName",
                            rs.getString("librarianName"));

                    return receipt;
                }
            }
        }

        return null;
    }

    // Lấy tất cả quyển sách thuộc phiếu mượn
    public List<Map<String, Object>> getReceiptDocuments(
            int receiptId)
            throws SQLException, ClassNotFoundException {

        List<Map<String, Object>> documents = new ArrayList<>();

        String sql =
            "SELECT " +
            "brd.id AS detailId, " +
            "d.documentCode, " +
            "d.documentTitle, " +
            "d.author, " +
            "dc.copyCode, " +
            "brd.borrowingCondition " +
            "FROM tblBorrowingReceiptDetail4 brd " +
            "JOIN tblDocumentCopy4 dc " +
            "ON dc.id = brd.tblDocumentCopy4id " +
            "JOIN tblDocument4 d " +
            "ON d.id = dc.tblDocument4id " +
            "WHERE brd.tblBorrowingReceipt4id = ? " +
            "ORDER BY brd.id ASC";

        try (Connection conn = con();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, receiptId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Map<String, Object> document = new HashMap<>();

                    document.put("detailId",
                            rs.getInt("detailId"));

                    document.put("documentCode",
                            rs.getString("documentCode"));

                    document.put("documentTitle",
                            rs.getString("documentTitle"));

                    document.put("author",
                            rs.getString("author"));

                    document.put("copyCode",
                            rs.getString("copyCode"));

                    document.put("borrowingCondition",
                            rs.getString("borrowingCondition"));

                    documents.add(document);
                }
            }
        }

        return documents;
    }
}
