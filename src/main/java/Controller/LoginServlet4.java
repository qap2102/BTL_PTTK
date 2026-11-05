
package Controller;

import DAO.MemberDAO4;
import Model.Member4;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet4 extends HttpServlet {

    private final MemberDAO4 memberDAO = new MemberDAO4();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Nếu đã đăng nhập thì chuyển đến menu chính
        if (session != null
                && session.getAttribute("currentUser") != null
                && session.getAttribute("currentRole") != null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/MainMenuFrm4.jsp");
            return;
        }

        request.getRequestDispatcher("/LoginFrm4.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 1. Kiểm tra dữ liệu đầu vào
        if (username == null || username.isBlank()
                || password == null || password.isBlank()) {

            request.setAttribute("error",
                    "Vui lòng nhập đầy đủ tài khoản và mật khẩu.");

            request.getRequestDispatcher("/LoginFrm4.jsp")
                   .forward(request, response);
            return;
        }

        try {

            // 2. Kiểm tra tài khoản và mật khẩu
            Member4 member = memberDAO.login(
                    username.trim(), password);

            if (member == null) {

                request.setAttribute("error",
                        "Sai tài khoản hoặc mật khẩu.");

                request.getRequestDispatcher("/LoginFrm4.jsp")
                       .forward(request, response);
                return;
            }

            // 3. Xác định vai trò người đăng nhập
            String role = memberDAO.getUserRole(member.getId());

            // 4. Kiểm tra tài khoản đã được phân quyền chưa
            if (role == null || "UNKNOWN".equals(role)) {

                request.setAttribute("error",
                        "Tài khoản chưa được phân quyền trong hệ thống.");

                request.getRequestDispatcher("/LoginFrm4.jsp")
                       .forward(request, response);
                return;
            }

            // 5. Hủy session cũ nếu tồn tại
            HttpSession oldSession = request.getSession(false);

            if (oldSession != null) {
                oldSession.invalidate();
            }

            // 6. Tạo session mới
            HttpSession session = request.getSession(true);

            // Lưu thông tin người dùng
            session.setAttribute("currentUser", member);

            // Lưu vai trò người dùng
            session.setAttribute("currentRole", role);

            // Thời gian session: 30 phút
            session.setMaxInactiveInterval(30 * 60);

            // 7. Chuyển đến menu chính
            response.sendRedirect(
                    request.getContextPath()
                    + "/MainMenuFrm4.jsp");

        } catch (SQLException | ClassNotFoundException e) {

            throw new ServletException(
                    "Lỗi cơ sở dữ liệu khi đăng nhập.", e);
        }
    }
}
