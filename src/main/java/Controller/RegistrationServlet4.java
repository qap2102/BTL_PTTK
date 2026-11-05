
package Controller;

import DAO.ReaderDAO4;
import DAO.ReaderCardDAO4;
import DAO.ReaderCategoryDAO4;

import Model.Reader4;
import Model.ReaderCard4;
import Model.ReaderCategory4;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "RegistrationServlet4", urlPatterns = {"/register"})
public class RegistrationServlet4 extends HttpServlet {

    private final ReaderDAO4 readerDAO = new ReaderDAO4();
    private final ReaderCardDAO4 cardDAO = new ReaderCardDAO4();
    private final ReaderCategoryDAO4 categoryDAO =
            new ReaderCategoryDAO4();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        try {
            ReaderCategory4[] categories =
                    categoryDAO.getAllReaderCategory();

            request.setAttribute(
                    "readerCategories", categories);

            request.getRequestDispatcher(
                    "/RegistrationFrm4.jsp"
            ).forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                    "Khong the tai danh sach loai ban doc", e);
        } catch (ClassNotFoundException ex) {
            System.getLogger(RegistrationServlet4.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String readerCode =
                request.getParameter("readerCode");

        String categoryIdStr =
                request.getParameter("readerCategoryId");

        String fullName =
                request.getParameter("fullName");

        String email =
                request.getParameter("email");

        String phoneNumber =
                request.getParameter("phoneNumber");

        if (readerCode == null
                || readerCode.isBlank()
                || categoryIdStr == null
                || categoryIdStr.isBlank()
                || fullName == null
                || fullName.isBlank()) {

            try {
                showError(request, response,
                        "Vui long nhap day du thong tin bat buoc");
            } catch (ClassNotFoundException ex) {
                System.getLogger(RegistrationServlet4.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
            }
            return;
        }

        try {
            int categoryId =
                    Integer.parseInt(categoryIdStr);

            ReaderCategory4 category =
                    categoryDAO.getReaderCategory(categoryId);

            if (category == null) {
                showError(request, response,
                        "Loai ban doc khong hop le");
                return;
            }

            Reader4 reader =
                    readerDAO.getReader(readerCode.trim());

            if (reader == null) {
                showError(request, response,
                        "Khong tim thay ban doc trong he thong");
                return;
            }

            if (reader.getReaderCategory() == null
                    || reader.getReaderCategory().getId()
                    != categoryId) {

                showError(request, response,
                        "Loai ban doc khong khop voi ho so");
                return;
            }

            if (!fullName.trim().equalsIgnoreCase(
                    reader.getFullName().trim())) {

                showError(request, response,
                        "Ho ten khong khop voi ho so ban doc");
                return;
            }

            if (cardDAO.hasReaderCard(reader.getId())) {
                showError(request, response,
                        "Ban doc da duoc cap the");
                return;
            }

            ReaderCard4 card =
                    cardDAO.createReaderCard(reader);

            if (card == null) {
                showError(request, response,
                        "Khong the tao the ban doc");
                return;
            }

            request.setAttribute("reader", reader);
            request.setAttribute("readerCard", card);
            request.setAttribute("fullName",
                    reader.getFullName());

            request.getRequestDispatcher(
                    "/RegistrationNoticeFrm4.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {
            try {
                showError(request, response,
                        "Ma loai ban doc khong hop le");
            } catch (ClassNotFoundException ex) {
                System.getLogger(RegistrationServlet4.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
            }

        } catch (SQLException e) {
            throw new ServletException(
                    "Loi co so du lieu khi dang ky the", e);
        } catch (ClassNotFoundException ex) {
            System.getLogger(RegistrationServlet4.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
    }

    private void showError(HttpServletRequest request,
                           HttpServletResponse response,
                           String message)
            throws ServletException, IOException, ClassNotFoundException {

        request.setAttribute("error", message);

        try {
            request.setAttribute(
                    "readerCategories",
                    categoryDAO.getAllReaderCategory()
            );
        } catch (SQLException e) {
            throw new ServletException(
                    "Khong the tai lai danh sach loai ban doc", e);
        }

        request.getRequestDispatcher(
                "/RegistrationFrm4.jsp"
        ).forward(request, response);
    }
}
