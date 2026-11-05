
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DocumentBorrowingDetailDAO4 extends DAO {

    public List<Map<String, Object>> getBorrowingDetails(
            String documentCode,
            Date startDate,
            Date endDate)
            throws SQLException, ClassNotFoundException {

        List<Map<String, Object>> results = new ArrayList<>();

        String sql =
            "SELECT " +
            "br.id AS borrowingReceiptId, " +
            "d.documentCode, " +
            "d.documentTitle, " +
            "dc.copyCode, " +
            "br.borrowDate, " +
            "br.returnDate, " +
            "br.status, " +
            "r.readerCode, " +
            "m.fullName AS readerName " +
            "FROM tblDocument4 d " +
            "JOIN tblDocumentCopy4 dc " +
            "ON dc.tblDocument4id = d.id " +
            "JOIN tblBorrowingReceiptDetail4 brd " +
            "ON brd.tblDocumentCopy4id = dc.id " +
            "JOIN tblBorrowingReceipt4 br " +
            "ON br.id = brd.tblBorrowingReceipt4id " +
            "JOIN tblReader4 r " +
            "ON r.tblMember4id = br.tblReader4id " +
            "JOIN tblMember4 m " +
            "ON m.id = r.tblMember4id " +
            "WHERE d.documentCode = ? " +
            "AND br.borrowDate BETWEEN ? AND ? " +
            "ORDER BY br.borrowDate DESC, br.id DESC";

        try (Connection conn = con();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, documentCode);
            ps.setDate(2, startDate);
            ps.setDate(3, endDate);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Map<String, Object> item = new HashMap<>();

                    item.put("borrowingReceiptId",
                            rs.getInt("borrowingReceiptId"));

                    item.put("documentCode",
                            rs.getString("documentCode"));

                    item.put("documentTitle",
                            rs.getString("documentTitle"));

                    item.put("copyCode",
                            rs.getString("copyCode"));

                    item.put("borrowDate",
                            rs.getDate("borrowDate"));

                    item.put("returnDate",
                            rs.getDate("returnDate"));

                    item.put("status",
                            rs.getString("status"));

                    item.put("readerCode",
                            rs.getString("readerCode"));

                    item.put("readerName",
                            rs.getString("readerName"));

                    results.add(item);
                }
            }
        }

        return results;
    }
}
