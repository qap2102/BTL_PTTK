
package Controller;

import DAO.DocumentBorrowingDetailDAO4;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.Map;

@WebServlet("/document-borrowings")
public class DocumentBorrowingDetailServlet4
        extends HttpServlet {

    private final DocumentBorrowingDetailDAO4 dao =
            new DocumentBorrowingDetailDAO4();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("currentUser") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login");
            return;
        }

        if (!"MANAGER".equals(
                session.getAttribute("currentRole"))) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Bạn không có quyền truy cập.");
            return;
        }

        String documentCode =
                request.getParameter("documentCode");

        String start = request.getParameter("startDate");
        String end = request.getParameter("endDate");

        if (documentCode == null || documentCode.isBlank()
                || start == null || start.isBlank()
                || end == null || end.isBlank()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Thiếu thông tin đầu sách hoặc khoảng thời gian.");
            return;
        }

        try {

            LocalDate startLocal = LocalDate.parse(start);
            LocalDate endLocal = LocalDate.parse(end);

            if (startLocal.isAfter(endLocal)) {
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Khoảng thời gian không hợp lệ.");
                return;
            }

            List<Map<String, Object>> details =
                    dao.getBorrowingDetails(
                            documentCode,
                            Date.valueOf(startLocal),
                            Date.valueOf(endLocal));

            request.setAttribute("documentCode", documentCode);
            request.setAttribute("startDate", start);
            request.setAttribute("endDate", end);
            request.setAttribute("detailsList", details);

            if (!details.isEmpty()) {
                request.setAttribute(
                        "documentTitle",
                        details.get(0).get("documentTitle"));
            }

            request.getRequestDispatcher(
                    "/BorrowingDetailFrm4.jsp")
                    .forward(request, response);

        } catch (DateTimeParseException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Định dạng ngày không hợp lệ.");

        } catch (SQLException | ClassNotFoundException e) {

            throw new ServletException(
                    "Lỗi truy vấn chi tiết lượt mượn.", e);
        }
    }
}
