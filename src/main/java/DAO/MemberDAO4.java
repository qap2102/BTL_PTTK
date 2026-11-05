
package DAO;

import Model.Member4;
import java.sql.*;

public class MemberDAO4 extends DAO {

    public Member4 login(String username, String password) throws SQLException, ClassNotFoundException {

        String sql = "SELECT id, userName, fullName\n" + "FROM tblMember4\n" + "WHERE userName = ? AND password = ?\n";

        try (Connection connection = con();
             PreparedStatement ps =
                     connection.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Member4 member = new Member4();

                    member.setId(rs.getInt("id"));
                    member.setUserName(
                            rs.getString("userName"));
                    member.setFullName(
                            rs.getString("fullName"));

                    return member;
                }
            }
        }

        return null;
    }
    
    public String getUserRole(int memberId) throws SQLException, ClassNotFoundException {

        String sql =
            "SELECT " +
            "CASE " +
            " WHEN EXISTS (" +
            "   SELECT 1 FROM tblManager4 " +
            "   WHERE tblMember4id = ?" +
            " ) THEN 'MANAGER' " +
            " WHEN EXISTS (" +
            "   SELECT 1 FROM tblLibrarian4 " +
            "   WHERE tblMember4id = ?" +
            " ) THEN 'LIBRARIAN' " +
            " WHEN EXISTS (" +
            "   SELECT 1 FROM tblReader4 " +
            "   WHERE tblMember4id = ?" +
            " ) THEN 'READER' " +
            " ELSE 'UNKNOWN' " +
            "END AS userRole";

        try (Connection conn = con();
             PreparedStatement ps =
                     conn.prepareStatement(sql)) {

            ps.setInt(1, memberId);
            ps.setInt(2, memberId);
            ps.setInt(3, memberId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("userRole");
                }
            }
        }

        return "UNKNOWN";
    }

}
