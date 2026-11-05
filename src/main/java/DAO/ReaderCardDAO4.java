package DAO;

import Model.Reader4;
import Model.ReaderCard4;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;

public class ReaderCardDAO4 extends DAO {

    public boolean hasReaderCard(int readerId) throws SQLException, ClassNotFoundException {
        String sql = "SELECT 1 FROM tblReaderCard4 WHERE tblReader4id = ?";
        try (Connection connection = con();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, readerId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public ReaderCard4 createReaderCard(Reader4 reader) throws SQLException, ClassNotFoundException {
        if (reader == null || reader.getId() <= 0 || reader.getReaderCategory() == null) {
            throw new IllegalArgumentException("Thong tin ban doc khong hop le");
        }
        int borrowPeriod = reader.getReaderCategory().getBorrowPeriod();
        if (borrowPeriod <= 0) {
            throw new IllegalArgumentException("Thoi han muon khong hop le");
        }

        // Vi du quy uoc: the co hieu luc 1 nam. Co the thay bang chinh sach cua thu vien.
        LocalDate today = LocalDate.now();
        Date issueDate = Date.valueOf(today);
        Date expiryDate = Date.valueOf(today.plusYears(1));
        String sql = "INSERT INTO tblReaderCard4 (issueDate, expiryDate, status, tblReader4id) VALUES (?, ?, ?, ?)";

        try (Connection connection = con();
             PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setDate(1, issueDate);
            ps.setDate(2, expiryDate);
            ps.setString(3, "ACTIVE");
            ps.setInt(4, reader.getId());
            ps.executeUpdate();

            ReaderCard4 card = new ReaderCard4();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) card.setId(keys.getInt(1));
            }
            card.setIssueDate(issueDate);
            card.setExpiryDate(expiryDate);
            card.setStatus("ACTIVE");
            card.setReaderInfo(reader);
            return card;
        }
        // UNIQUE(tblReader4id) tren MySQL ngan tao the trung ke ca khi co 2 request dong thoi.
    }
}
