
package Controller;

import DAO.DocumentBorrowingStatDAO4;

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

import java.util.List;
import java.util.Map;

@WebServlet("/document-statistics")
public class DocumentBorrowingStatServlet4 extends HttpServlet {

    private final DocumentBorrowingStatDAO4 dao =
            new DocumentBorrowingStatDAO4();

    private boolean checkPermission(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("currentUser") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login");
            return false;
        }

        if (!"MANAGER".equals(
                session.getAttribute("currentRole"))) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Bạn không có quyền xem thống kê.");
            return false;
        }

        return true;
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        if (!checkPermission(request, response)) {
            return;
        }

        request.getRequestDispatcher(
                "/DocumentBorrowingStatFrm4.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        if (!checkPermission(request, response)) {
            return;
        }

        request.setCharacterEncoding("UTF-8");

        String start = request.getParameter("startDate");
        String end = request.getParameter("endDate");

        request.setAttribute("startDate", start);
        request.setAttribute("endDate", end);

        if (start == null || start.isBlank()
                || end == null || end.isBlank()) {

            showError(request, response,
                    "Vui lòng chọn đầy đủ ngày bắt đầu và ngày kết thúc.");
            return;
        }

        try {

            LocalDate startLocal = LocalDate.parse(start);
            LocalDate endLocal = LocalDate.parse(end);

            if (startLocal.isAfter(endLocal)) {
                showError(request, response,
                        "Ngày bắt đầu không được lớn hơn ngày kết thúc.");
                return;
            }

            Date startDate = Date.valueOf(startLocal);
            Date endDate = Date.valueOf(endLocal);

            List<Map<String, Object>> statistics =
                    dao.getDocumentStatistics(startDate, endDate);

            int totalDocuments = statistics.size();
            long totalBorrowCount = 0;

            for (Map<String, Object> item : statistics) {
                totalBorrowCount +=
                        ((Number) item.get("totalBorrowCount"))
                                .longValue();
            }

            request.setAttribute("statisticsList", statistics);
            request.setAttribute("totalDocuments", totalDocuments);
            request.setAttribute("totalBorrowCount", totalBorrowCount);
            request.setAttribute("hasSearched", true);

            request.getRequestDispatcher(
                    "/DocumentBorrowingStatFrm4.jsp")
                    .forward(request, response);

        } catch (java.time.format.DateTimeParseException e) {

            showError(request, response,
                    "Ngày nhập vào không hợp lệ.");

        } catch (SQLException | ClassNotFoundException e) {

            throw new ServletException(
                    "Lỗi khi thống kê tài liệu.", e);
        }
    }

    private void showError(
            HttpServletRequest request,
            HttpServletResponse response,
            String message)
            throws ServletException, IOException {

        request.setAttribute("error", message);

        request.getRequestDispatcher(
                "/DocumentBorrowingStatFrm4.jsp")
                .forward(request, response);
    }
}
