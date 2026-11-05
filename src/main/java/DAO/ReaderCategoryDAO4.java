package DAO;

import Model.ReaderCategory4;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReaderCategoryDAO4 extends DAO {

    public ReaderCategory4[] getAllReaderCategory() throws SQLException, ClassNotFoundException {
        String sql = "SELECT id, readerType, maxBorrowQuantity, borrowPeriod FROM tblReaderCategory4 ORDER BY id";
        List<ReaderCategory4> categories = new ArrayList<>();
        try (Connection connection = con();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                categories.add(mapCategory(rs));
            }
        }
        return categories.toArray(new ReaderCategory4[0]);
    }

    public ReaderCategory4 getReaderCategory(int id) throws SQLException, ClassNotFoundException {
        String sql = "SELECT id, readerType, maxBorrowQuantity, borrowPeriod FROM tblReaderCategory4 WHERE id = ?";
        try (Connection connection = con();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? mapCategory(rs) : null;
            }
        }
    }

    private ReaderCategory4 mapCategory(ResultSet rs) throws SQLException {
        ReaderCategory4 category = new ReaderCategory4();
        category.setId(rs.getInt("id"));
        category.setReaderType(rs.getString("readerType"));
        category.setMaxBorrowQuantity(rs.getInt("maxBorrowQuantity"));
        category.setBorrowPeriod(rs.getInt("borrowPeriod"));
        return category;
    }
}
