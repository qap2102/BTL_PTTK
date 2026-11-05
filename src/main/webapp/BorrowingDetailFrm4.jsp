
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- Kiểm tra đăng nhập và phân quyền --%>
<%
    jakarta.servlet.http.HttpSession userSession =
            request.getSession(false);

    if (userSession == null ||
            userSession.getAttribute("currentUser") == null) {

        response.sendRedirect(
                request.getContextPath() + "/login");
        return;
    }

    if (!"MANAGER".equals(
            userSession.getAttribute("currentRole"))) {

        response.sendError(
                403,
                "Bạn không có quyền xem chi tiết lượt mượn.");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>LibMan - Chi tiết lượt mượn</title>

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

        header p {
            margin-bottom: 0;
        }

        main {
            max-width: 1150px;
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
            margin-top: 0;
        }

        .info {
            padding: 20px;
            background: #eef5ff;
            border-radius: 10px;
            margin: 20px 0;
        }

        .info p {
            margin: 8px 0;
        }

        .summary {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            margin: 20px 0;
        }

        .summary-item {
            flex: 1;
            min-width: 200px;
            background: #eaf2ff;
            border-radius: 10px;
            padding: 20px;
        }

        .summary-item strong {
            display: block;
            margin-top: 10px;
            font-size: 26px;
            color: #173b69;
        }

        .table-wrap {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
        }

        th, td {
            padding: 13px;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
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
            padding: 0;
            border: none;
            background: transparent;
            color: #173b69;
            font-family: Arial, sans-serif;
            font-size: 16px;
            font-weight: bold;
            text-decoration: none;
            cursor: pointer;
        }

        .back-link:hover {
            color: #2563eb;
        }

        .empty {
            padding: 20px;
            background: #f1f5f9;
            border-radius: 8px;
            margin-top: 20px;
            text-align: center;
        }

        .status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: bold;
        }

        .status-returned {
            background: #dcfce7;
            color: #166534;
        }

        .status-borrowing {
            background: #fef3c7;
            color: #92400e;
        }

        .actions {
            margin-top: 10px;
        }
    </style>
</head>

<body>

<header>
    <h1>LibMan</h1>
    <p>Chi tiết lượt mượn tài liệu</p>
</header>

<main>
    <section class="card">

        <h2>Danh sách chi tiết lượt mượn</h2>

        <%-- Thông tin đầu sách --%>
        <div class="info">

            <p>
                <strong>Mã đầu sách:</strong>
                <c:out value="${documentCode}"/>
            </p>

            <p>
                <strong>Tên tài liệu:</strong>
                <c:out value="${documentTitle}"/>
            </p>

            <p>
                <strong>Từ ngày:</strong>
                <c:out value="${startDate}"/>
            </p>

            <p>
                <strong>Đến ngày:</strong>
                <c:out value="${endDate}"/>
            </p>

        </div>

        <%-- Thống kê nhanh --%>
        <div class="summary">

            <div class="summary-item">
                Tổng lượt mượn

                <strong>
                    <c:out value="${detailsList.size()}"/>
                </strong>
            </div>

        </div>

        <h3>Danh sách các lượt mượn</h3>

        <c:choose>

            <%-- Không có dữ liệu --%>
            <c:when test="${empty detailsList}">

                <div class="empty">
                    Không có lượt mượn nào
                    trong khoảng thời gian đã chọn.
                </div>

            </c:when>

            <%-- Có dữ liệu --%>
            <c:otherwise>

                <div class="table-wrap">

                    <table>

                        <thead>
                            <tr>
                                <th>STT</th>
                                <th>Mã quyển</th>
                                <th>Ngày mượn</th>
                                <th>Ngày trả</th>
                                <th>Mã bạn đọc</th>
                                <th>Mã phiếu mượn</th>
                                <th>Trạng thái</th>
                                <th>Chi tiết</th>
                            </tr>
                        </thead>

                        <tbody>

                            <c:forEach
                                var="item"
                                items="${detailsList}"
                                varStatus="st">

                                <tr>

                                    <td>
                                        ${st.count}
                                    </td>

                                    <td>
                                        <c:out value="${item.copyCode}"/>
                                    </td>

                                    <td>
                                        <c:out value="${item.borrowDate}"/>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty item.returnDate}">
                                                <c:out value="${item.returnDate}"/>
                                            </c:when>

                                            <c:otherwise>
                                                Chưa trả
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <c:out value="${item.readerCode}"/>
                                    </td>

                                    <td>
                                        #<c:out value="${item.borrowingReceiptId}"/>
                                    </td>

                                    <td>
                                        <c:choose>

                                            <c:when test="${item.status eq 'RETURNED'}">
                                                <span class="status status-returned">
                                                    Đã trả
                                                </span>
                                            </c:when>

                                            <c:when test="${item.status eq 'BORROWING'}">
                                                <span class="status status-borrowing">
                                                    Đang mượn
                                                </span>
                                            </c:when>

                                            <c:otherwise>
                                                <c:out value="${item.status}"/>
                                            </c:otherwise>

                                        </c:choose>
                                    </td>

                                    <td>

                                        <%-- Tạo đường dẫn xem phiếu --%>
                                        <c:url
                                            var="receiptUrl"
                                            value="/borrowing-receipt-detail">

                                            <c:param
                                                name="receiptId"
                                                value="${item.borrowingReceiptId}"/>

                                            <c:param
                                                name="documentCode"
                                                value="${documentCode}"/>

                                            <c:param
                                                name="startDate"
                                                value="${startDate}"/>

                                            <c:param
                                                name="endDate"
                                                value="${endDate}"/>

                                        </c:url>

                                        <a class="detail-link"
                                           href="${receiptUrl}">
                                            Xem phiếu
                                        </a>

                                    </td>

                                </tr>

                            </c:forEach>

                        </tbody>

                    </table>

                </div>

            </c:otherwise>

        </c:choose>

        <%-- Quay lại thống kê, giữ khoảng thời gian --%>
        <div class="actions">

            <form
                action="${pageContext.request.contextPath}/document-statistics"
                method="post">

                <input
                    type="hidden"
                    name="startDate"
                    value="<c:out value='${startDate}'/>">

                <input
                    type="hidden"
                    name="endDate"
                    value="<c:out value='${endDate}'/>">

                <button
                    type="submit"
                    class="back-link">
                    ← Quay lại thống kê
                </button>

            </form>

        </div>

    </section>
</main>

</body>
</html>
