
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

public class DocumentBorrowingStatDAO4 extends DAO {

    public List<Map<String, Object>> getDocumentStatistics(
            Date startDate, Date endDate)
            throws SQLException, ClassNotFoundException {

        List<Map<String, Object>> results = new ArrayList<>();

        String sql =
            "SELECT " +
            "d.id AS documentId, " +
            "d.documentCode, " +
            "d.documentTitle, " +
            "d.author, " +
            "COUNT(brd.id) AS totalBorrowCount " +
            "FROM tblDocument4 d " +
            "JOIN tblDocumentCopy4 dc " +
            "ON dc.tblDocument4id = d.id " +
            "JOIN tblBorrowingReceiptDetail4 brd " +
            "ON brd.tblDocumentCopy4id = dc.id " +
            "JOIN tblBorrowingReceipt4 br " +
            "ON br.id = brd.tblBorrowingReceipt4id " +
            "WHERE br.borrowDate BETWEEN ? AND ? " +
            "GROUP BY d.id, d.documentCode, " +
            "d.documentTitle, d.author " +
            "ORDER BY totalBorrowCount DESC, " +
            "d.documentCode ASC";

        try (Connection conn = con();
             PreparedStatement ps =
                     conn.prepareStatement(sql)) {

            ps.setDate(1, startDate);
            ps.setDate(2, endDate);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Map<String, Object> item = new HashMap<>();

                    item.put("documentId",
                            rs.getInt("documentId"));

                    item.put("documentCode",
                            rs.getString("documentCode"));

                    item.put("documentTitle",
                            rs.getString("documentTitle"));

                    item.put("author",
                            rs.getString("author"));

                    item.put("totalBorrowCount",
                            rs.getInt("totalBorrowCount"));

                    results.add(item);
                }
            }
        }

        return results;
    }
}
