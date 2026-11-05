
package Controller;

import DAO.BorrowingReceiptDetailDAO4;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@WebServlet("/borrowing-receipt-detail")
public class BorrowingReceiptDetailServlet4
        extends HttpServlet {

    private final BorrowingReceiptDetailDAO4 dao =
            new BorrowingReceiptDetailDAO4();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Kiểm tra đăng nhập
        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("currentUser") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login");
            return;
        }

        // Chỉ nhân viên quản lý được xem
        if (!"MANAGER".equals(
                session.getAttribute("currentRole"))) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Bạn không có quyền xem phiếu mượn.");
            return;
        }

        String receiptIdParam =
                request.getParameter("receiptId");

        if (receiptIdParam == null ||
                receiptIdParam.isBlank()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Thiếu mã phiếu mượn.");
            return;
        }

        try {

            int receiptId = Integer.parseInt(receiptIdParam);

            if (receiptId <= 0) {
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Mã phiếu mượn không hợp lệ.");
                return;
            }

            Map<String, Object> receipt =
                    dao.getReceiptById(receiptId);

            if (receipt == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Không tìm thấy phiếu mượn.");
                return;
            }

            List<Map<String, Object>> documents =
                    dao.getReceiptDocuments(receiptId);

            request.setAttribute("receipt", receipt);
            request.setAttribute("documents", documents);
            request.setAttribute("totalDocuments", documents.size());

            // Giữ tham số để quay lại màn hình trước
            request.setAttribute("documentCode",
                    request.getParameter("documentCode"));

            request.setAttribute("startDate",
                    request.getParameter("startDate"));

            request.setAttribute("endDate",
                    request.getParameter("endDate"));

            request.getRequestDispatcher(
                    "/BorrowingReceiptDetailFrm4.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Mã phiếu mượn phải là số nguyên.");

        } catch (SQLException | ClassNotFoundException e) {

            throw new ServletException(
                    "Lỗi truy vấn chi tiết phiếu mượn.", e);
        }
    }
}
