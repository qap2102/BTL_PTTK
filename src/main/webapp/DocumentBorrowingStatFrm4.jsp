<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%
    // Lấy session hiện tại
    jakarta.servlet.http.HttpSession userSession =
            request.getSession(false);

    // Kiểm tra đăng nhập
    if (userSession == null
            || userSession.getAttribute("currentUser") == null) {

        response.sendRedirect(
                request.getContextPath() + "/login"
        );
        return;
    }

    // Kiểm tra vai trò
    String role = (String)
            userSession.getAttribute("currentRole");

    if (!"MANAGER".equals(role)) {

        response.sendError(
                403,
                "Bạn không có quyền xem thống kê."
        );
        return;
    }
%>


<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>LibMan - Thống kê tài liệu</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f3f6fb;
            color: #263449;
        }

        header {
            background: #173b69;
            color: white;
            padding: 24px 8%;
        }

        header h1 {
            margin: 0 0 8px;
        }

        main {
            max-width: 1100px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .card {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 5px 22px #00000012;
        }

        h2 {
            color: #173b69;
        }

        .form-row {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            align-items: end;
            margin: 25px 0;
        }

        .form-group {
            flex: 1;
            min-width: 200px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 12px;
            border: 1px solid #cbd5e1;
            border-radius: 7px;
            font-size: 15px;
        }

        button {
            padding: 13px 22px;
            border: none;
            border-radius: 7px;
            background: #2563eb;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background: #1d4ed8;
        }

        .error {
            padding: 14px;
            border-radius: 7px;
            background: #fee2e2;
            color: #b91c1c;
            margin-bottom: 20px;
        }

        .summary {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            margin: 25px 0;
        }

        .summary-item {
            flex: 1;
            min-width: 200px;
            background: #eef5ff;
            border-radius: 10px;
            padding: 20px;
        }

        .summary-item strong {
            display: block;
            font-size: 28px;
            margin-top: 10px;
            color: #173b69;
        }

        .table-wrap {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 14px;
            border-bottom: 1px solid #e2e8f0;
            text-align: left;
        }

        th {
            background: #173b69;
            color: white;
        }

        tr:hover td {
            background: #f8fafc;
        }

        .detail-link {
            display: inline-block;
            padding: 8px 12px;
            background: #eaf2ff;
            border-radius: 6px;
            color: #2563eb;
            font-weight: bold;
            text-decoration: none;
            white-space: nowrap;
        }

        .detail-link:hover {
            background: #d7e8ff;
        }

        .back-link {
            display: inline-block;
            margin-top: 25px;
            color: #173b69;
            text-decoration: none;
            font-weight: bold;
        }

        .empty {
            padding: 20px;
            background: #f1f5f9;
            border-radius: 8px;
            margin-top: 20px;
            text-align: center;
        }

        .result-info {
            margin-top: 20px;
            color: #64748b;
            font-size: 14px;
        }
    </style>
</head>

<body>

<header>
    <h1>LibMan</h1>
    <p>Thống kê tài liệu theo lượt mượn</p>
</header>

<main>
    <section class="card">

        <h2>Thống kê tài liệu theo lượt mượn</h2>

        <p>
            Chọn khoảng thời gian để xem danh sách
            các đầu sách được mượn nhiều nhất.
        </p>

        <%-- Thông báo lỗi --%>
        <c:if test="${not empty error}">
            <div class="error">
                <c:out value="${error}"/>
            </div>
        </c:if>

        <%-- FORM THỐNG KÊ --%>
        <form
            action="${pageContext.request.contextPath}/document-statistics"
            method="post">

            <div class="form-row">

                <div class="form-group">
                    <label for="startDate">
                        Ngày bắt đầu
                    </label>

                    <input
                        type="date"
                        id="startDate"
                        lang="vi-VN"
                        name="startDate"
                        value="<c:out value='${startDate}'/>"
                        required>
                </div>

                <div class="form-group">
                    <label for="endDate">
                        Ngày kết thúc
                    </label>

                    <input
                        type="date"
                        id="endDate"
                        lang="vi-VN"
                        name="endDate"
                        value="<c:out value='${endDate}'/>"
                        required>
                </div>

                <button type="submit">
                    Xem thống kê
                </button>

            </div>
        </form>

        <%-- HIỂN THỊ KẾT QUẢ --%>
        <c:if test="${hasSearched}">

            <%-- Tổng quan --%>
            <div class="summary">

                <div class="summary-item">
                    Số đầu sách được mượn

                    <strong>
                        <c:out value="${totalDocuments}"/>
                    </strong>
                </div>

                <div class="summary-item">
                    Tổng lượt mượn

                    <strong>
                        <c:out value="${totalBorrowCount}"/>
                    </strong>
                </div>

            </div>

            <h3>Kết quả thống kê</h3>

            <fmt:parseDate value="${startDate}"
               pattern="yyyy-MM-dd"
               var="formattedStartDate"/>

            <fmt:parseDate value="${endDate}"
                           pattern="yyyy-MM-dd"
                           var="formattedEndDate"/>

            <p class="result-info">
                Khoảng thời gian:

                <strong>
                    <fmt:formatDate value="${formattedStartDate}"
                                    pattern="dd/MM/yyyy"/>
                </strong>

                đến

                <strong>
                    <fmt:formatDate value="${formattedEndDate}"
                                    pattern="dd/MM/yyyy"/>
                </strong>
            </p>

            <c:choose>

                <%-- Không có dữ liệu --%>
                <c:when test="${empty statisticsList}">

                    <div class="empty">
                        Không có tài liệu nào được mượn
                        trong khoảng thời gian đã chọn.
                    </div>

                </c:when>

                <%-- Có dữ liệu thống kê --%>
                <c:otherwise>

                    <div class="table-wrap">
                        <table>

                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Mã đầu sách</th>
                                    <th>Tên tài liệu</th>
                                    <th>Tác giả</th>
                                    <th>Số lượt mượn</th>
                                    <th>Chi tiết</th>
                                </tr>
                            </thead>

                            <tbody>

                                <c:forEach
                                    var="item"
                                    items="${statisticsList}"
                                    varStatus="st">

                                    <tr>

                                        <td>
                                            ${st.count}
                                        </td>

                                        <td>
                                            <c:out value="${item.documentCode}"/>
                                        </td>

                                        <td>
                                            <c:out value="${item.documentTitle}"/>
                                        </td>

                                        <td>
                                            <c:out value="${item.author}"/>
                                        </td>

                                        <td>
                                            <strong>
                                                <c:out value="${item.totalBorrowCount}"/>
                                            </strong>
                                        </td>

                                        <td>

                                            <%-- Tạo URL chi tiết lượt mượn --%>
                                            <c:url
                                                var="detailUrl"
                                                value="/document-borrowings">

                                                <c:param
                                                    name="documentCode"
                                                    value="${item.documentCode}"/>

                                                <c:param
                                                    name="startDate"
                                                    value="${startDate}"/>

                                                <c:param
                                                    name="endDate"
                                                    value="${endDate}"/>

                                            </c:url>

                                            <a
                                                class="detail-link"
                                                href="${detailUrl}">
                                                Xem chi tiết
                                            </a>

                                        </td>

                                    </tr>

                                </c:forEach>

                            </tbody>

                        </table>
                    </div>

                </c:otherwise>

            </c:choose>

        </c:if>

        <%-- Quay về menu chính --%>
        <a
            class="back-link"
            href="${pageContext.request.contextPath}/MainMenuFrm4.jsp">

            ← Quay lại menu chính

        </a>

    </section>
</main>

</body>
</html>
