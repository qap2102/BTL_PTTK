package DAO;

import Model.Reader4;
import Model.ReaderCategory4;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ReaderDAO4 extends DAO {

    public Reader4 getReader(String readerCode) throws SQLException, ClassNotFoundException {
        String sql = "SELECT m.id, m.userName, m.fullName, m.dateOfBirth,\n" + "       m.email, m.phoneNumber, r.readerCode,\n" + "       c.id AS categoryId, c.readerType,\n" + "       c.maxBorrowQuantity, c.borrowPeriod\n" + "FROM tblReader4 r\n" + "JOIN tblMember4 m ON m.id = r.tblMember4id\n" + "JOIN tblReaderCategory4 c ON c.id = r.tblReaderCategory4id\n" + "WHERE r.readerCode = ?\n";
        try (Connection connection = con();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, readerCode);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                ReaderCategory4 category = new ReaderCategory4();
                category.setId(rs.getInt("categoryId"));
                category.setReaderType(rs.getString("readerType"));
                category.setMaxBorrowQuantity(rs.getInt("maxBorrowQuantity"));
                category.setBorrowPeriod(rs.getInt("borrowPeriod"));

                Reader4 reader = new Reader4();
                reader.setId(rs.getInt("id"));
                reader.setUserName(rs.getString("userName"));
                reader.setFullName(rs.getString("fullName"));
                reader.setDateOfBirth(rs.getDate("dateOfBirth"));
                reader.setEmail(rs.getString("email"));
                reader.setPhoneNumber(rs.getString("phoneNumber"));
                reader.setReaderCode(rs.getString("readerCode"));
                reader.setReaderCategory(category);
                return reader;
            }
        }
    }
}
