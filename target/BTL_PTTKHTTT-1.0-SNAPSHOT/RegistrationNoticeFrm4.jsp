
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>Kết quả đăng ký - LibMan</title>

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
            padding: 20px 8%;
        }

        header h1 {
            margin: 0;
        }

        .container {
            max-width: 620px;
            margin: 65px auto;
            padding: 0 16px;
        }

        .card {
            background: white;
            border-radius: 12px;
            padding: 35px;
            box-shadow: 0 5px 22px #00000012;
            text-align: center;
        }

        .success-icon {
            width: 70px;
            height: 70px;
            margin: 0 auto 20px;
            border-radius: 50%;
            background: #dcfce7;
            color: #15803d;
            font-size: 42px;
            line-height: 70px;
        }

        h2 {
            color: #15803d;
        }

        .details {
            margin-top: 25px;
            text-align: left;
            background: #f8fafc;
            border-radius: 8px;
            padding: 20px;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            gap: 15px;
            padding: 11px 0;
            border-bottom: 1px solid #e5e7eb;
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .detail-row span:last-child {
            font-weight: bold;
            text-align: right;
        }

        .btn {
            display: inline-block;
            background: #2563eb;
            color: white;
            padding: 12px 25px;
            border-radius: 6px;
            text-decoration: none;
            margin-top: 25px;
        }

        @media (max-width: 480px) {
            .detail-row {
                flex-direction: column;
                gap: 5px;
            }

            .detail-row span:last-child {
                text-align: left;
            }
        }
    </style>
</head>

<body>
<header>
    <h1>LibMan</h1>
    <p>Hệ thống quản lý thư viện</p>
</header>

<div class="container">
    <div class="card">

        <c:choose>
            <c:when test="${not empty readerCard
                           and not empty reader}">

                <div class="success-icon">✓</div>

                <h2>Đăng ký thẻ thành công!</h2>

                <p>
                    Hệ thống đã ghi nhận và cấp
                    thẻ bạn đọc thành công.
                </p>

                <div class="details">

                    <div class="detail-row">
                        <span>Mã thẻ:</span>
                        <span>
                            <c:out value="${readerCard.id}" />
                        </span>
                    </div>

                    <div class="detail-row">
                        <span>Họ và tên:</span>
                        <span>
                            <c:out value="${reader.fullName}" />
                        </span>
                    </div>

                    <div class="detail-row">
                        <span>Mã bạn đọc:</span>
                        <span>
                            <c:out value="${reader.readerCode}" />
                        </span>
                    </div>

                    <div class="detail-row">
                        <span>Loại bạn đọc:</span>
                        <span>
                            <c:out
                                value="${reader.readerCategory.readerType}" />
                        </span>
                    </div>

                    <div class="detail-row">
                        <span>Ngày cấp:</span>
                        <span>
                            <c:out value="${readerCard.issueDate}" />
                        </span>
                    </div>

                    <div class="detail-row">
                        <span>Ngày hết hạn:</span>
                        <span>
                            <c:out value="${readerCard.expiryDate}" />
                        </span>
                    </div>

                </div>
            </c:when>

            <c:otherwise>
                <h2>Chưa có kết quả đăng ký</h2>
                <p>
                    Vui lòng thực hiện đăng ký thẻ
                    từ trang chính.
                </p>
            </c:otherwise>
        </c:choose>

        <a
            class="btn"
            href="${pageContext.request.contextPath}/MainMenuFrm4.jsp">
            OK - Về trang chủ
        </a>

    </div>
</div>

</body>
</html>
