
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>LibMan - Chi tiết phiếu mượn</title>

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

        h2, h3 {
            color: #173b69;
        }

        .info-grid {
            display: grid;
            grid-template-columns:
                repeat(auto-fit, minmax(260px, 1fr));
            gap: 20px;
            margin: 25px 0;
        }

        .info-box {
            background: #eef5ff;
            border-radius: 10px;
            padding: 20px;
        }

        .info-box h3 {
            margin-top: 0;
        }

        .info-box p {
            margin: 10px 0;
            line-height: 1.5;
        }

        .summary {
            background: #f1f5f9;
            padding: 15px 20px;
            border-radius: 8px;
            margin: 20px 0;
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

        .back-link {
            display: inline-block;
            margin-top: 25px;
            color: #173b69;
            font-weight: bold;
            text-decoration: none;
        }

        .empty {
            padding: 20px;
            background: #f1f5f9;
            border-radius: 8px;
            text-align: center;
        }
    </style>
</head>

<body>

<header>
    <h1>LibMan</h1>
    <p>Thông tin chi tiết phiếu mượn tài liệu</p>
</header>

<main>
    <section class="card">

        <h2>
            Chi tiết phiếu mượn
            #<c:out value="${receipt.receiptId}"/>
        </h2>

        <div class="info-grid">

            <%-- Thông tin phiếu mượn --%>
            <div class="info-box">

                <h3>Thông tin phiếu mượn</h3>

                <p>
                    <strong>Mã phiếu:</strong>
                    #<c:out value="${receipt.receiptId}"/>
                </p>

                <p>
                    <strong>Ngày mượn:</strong>
                    <c:out value="${receipt.borrowDate}"/>
                </p>

                <p>
                    <strong>Ngày trả:</strong>

                    <c:choose>
                        <c:when test="${not empty receipt.returnDate}">
                            <c:out value="${receipt.returnDate}"/>
                        </c:when>

                        <c:otherwise>
                            Chưa trả
                        </c:otherwise>
                    </c:choose>
                </p>

                <p>
                    <strong>Trạng thái:</strong>
                    <c:out value="${receipt.status}"/>
                </p>

            </div>

            <%-- Thông tin bạn đọc --%>
            <div class="info-box">

                <h3>Thông tin bạn đọc</h3>

                <p>
                    <strong>Mã bạn đọc:</strong>
                    <c:out value="${receipt.readerCode}"/>
                </p>

                <p>
                    <strong>Họ tên:</strong>
                    <c:out value="${receipt.readerName}"/>
                </p>

                <p>
                    <strong>Email:</strong>
                    <c:out value="${receipt.readerEmail}"/>
                </p>

                <p>
                    <strong>Số điện thoại:</strong>
                    <c:out value="${receipt.readerPhone}"/>
                </p>

            </div>

            <%-- Thông tin nhân viên --%>
            <div class="info-box">

                <h3>Nhân viên cho mượn</h3>

                <p>
                    <strong>Mã nhân viên:</strong>
                    <c:out value="${receipt.librarianCode}"/>
                </p>

                <p>
                    <strong>Họ tên:</strong>
                    <c:out value="${receipt.librarianName}"/>
                </p>

            </div>

        </div>

        <h3>Danh sách tài liệu trong phiếu</h3>

        <div class="summary">
            Tổng số quyển sách:
            <strong>
                <c:out value="${totalDocuments}"/>
            </strong>
        </div>

        <c:choose>

            <c:when test="${empty documents}">
                <div class="empty">
                    Phiếu mượn chưa có tài liệu.
                </div>
            </c:when>

            <c:otherwise>

                <div class="table-wrap">

                    <table>

                        <thead>
                            <tr>
                                <th>STT</th>
                                <th>Mã đầu sách</th>
                                <th>Mã quyển</th>
                                <th>Tên tài liệu</th>
                                <th>Tác giả</th>
                                <th>Tình trạng lúc mượn</th>
                            </tr>
                        </thead>

                        <tbody>

                            <c:forEach var="item"
                                       items="${documents}"
                                       varStatus="st">

                                <tr>

                                    <td>${st.count}</td>

                                    <td>
                                        <c:out value="${item.documentCode}"/>
                                    </td>

                                    <td>
                                        <c:out value="${item.copyCode}"/>
                                    </td>

                                    <td>
                                        <c:out value="${item.documentTitle}"/>
                                    </td>

                                    <td>
                                        <c:out value="${item.author}"/>
                                    </td>

                                    <td>
                                        <c:out value="${item.borrowingCondition}"/>
                                    </td>

                                </tr>

                            </c:forEach>

                        </tbody>

                    </table>

                </div>

            </c:otherwise>

        </c:choose>

        <%-- Quay lại danh sách lượt mượn --%>
        <c:choose>
            <c:when test="${not empty documentCode
                          and not empty startDate
                          and not empty endDate}">

                <c:url var="backUrl"
                       value="/document-borrowings">

                    <c:param name="documentCode"
                             value="${documentCode}"/>

                    <c:param name="startDate"
                             value="${startDate}"/>

                    <c:param name="endDate"
                             value="${endDate}"/>
                </c:url>

            </c:when>

            <c:otherwise>
                <c:url var="backUrl"
                       value="/document-statistics"/>
            </c:otherwise>
        </c:choose>

        <a class="back-link" href="${backUrl}">
            ← Quay lại
        </a>

    </section>
</main>

</body>
</html>
