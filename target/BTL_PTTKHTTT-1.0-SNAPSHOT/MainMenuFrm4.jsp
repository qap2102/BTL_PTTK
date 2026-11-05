
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- Kiểm tra đăng nhập và vai trò --%>
<c:if test="${empty sessionScope.currentUser
              or empty sessionScope.currentRole}">
    <c:redirect url="/login"/>
</c:if>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>LibMan - Trang chủ</title>

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
            padding: 22px 8%;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        header h1 {
            margin: 0;
            font-size: 32px;
        }

        header p {
            margin-bottom: 0;
        }

        .user-info {
            background: rgba(255,255,255,0.12);
            padding: 14px 20px;
            border-radius: 10px;
            min-width: 260px;
        }

        .user-info p {
            margin: 5px 0;
            font-size: 14px;
        }

        .user-info strong {
            color: #ffffff;
        }

        .logout-form {
            margin-top: 12px;
        }

        .logout-btn {
            padding: 9px 16px;
            border: 1px solid rgba(255,255,255,0.5);
            border-radius: 6px;
            background: rgba(255,255,255,0.15);
            color: white;
            font-weight: bold;
            cursor: pointer;
        }

        .logout-btn:hover {
            background: rgba(255,255,255,0.25);
        }

        main {
            max-width: 950px;
            margin: 55px auto;
            padding: 0 20px;
        }

        .card {
            background: white;
            border-radius: 12px;
            padding: 32px;
            box-shadow: 0 5px 22px #00000012;
        }

        .welcome {
            margin-bottom: 25px;
            padding: 20px;
            background: #eef5ff;
            border-radius: 10px;
            border-left: 4px solid #2563eb;
        }

        .welcome h3 {
            margin: 0 0 10px;
            color: #173b69;
        }

        .welcome p {
            margin: 5px 0;
        }

        .menu {
            display: grid;
            grid-template-columns:
                repeat(auto-fit, minmax(220px, 1fr));
            gap: 18px;
            margin-top: 25px;
        }

        .menu-item {
            display: block;
            padding: 24px;
            background: #eaf2ff;
            border: 1px solid #c9daf4;
            border-radius: 10px;
            text-decoration: none;
            color: #173b69;
            font-weight: bold;
            transition: background 0.2s;
        }

        a.menu-item:hover {
            background: #d7e8ff;
        }

        .menu-item.disabled {
            background: #f1f5f9;
            border-color: #e2e8f0;
            color: #64748b;
            cursor: default;
        }

        .menu-item small {
            display: block;
            margin-top: 8px;
            font-weight: normal;
            font-size: 12px;
        }

        @media (max-width: 600px) {
            header {
                padding: 20px;
            }

            main {
                margin: 25px auto;
            }

            .card {
                padding: 20px;
            }

            .user-info {
                width: 100%;
            }
        }
    </style>
</head>

<body>

    <header>
        <div class="header-content">

            <div>
                <h1>LibMan</h1>
                <p>Hệ thống quản lý thư viện</p>
            </div>

            <%-- Thông tin người đăng nhập --%>
            <div class="user-info">

                <p>
                    <strong>Họ tên:</strong>
                    <c:out value="${sessionScope.currentUser.fullName}"/>
                </p>

                <p>
                    <strong>Mã tài khoản:</strong>
                    <c:out value="${sessionScope.currentUser.userName}"/>
                </p>

                <p>
                    <strong>Vai trò:</strong>

                    <c:choose>
                        <c:when test="${sessionScope.currentRole eq 'READER'}">
                            Bạn đọc
                        </c:when>

                        <c:when test="${sessionScope.currentRole eq 'LIBRARIAN'}">
                            Nhân viên thư viện
                        </c:when>

                        <c:when test="${sessionScope.currentRole eq 'MANAGER'}">
                            Nhân viên quản lý
                        </c:when>

                        <c:otherwise>
                            Chưa xác định
                        </c:otherwise>
                    </c:choose>
                </p>

                <form class="logout-form"
                      action="${pageContext.request.contextPath}/logout"
                      method="post">

                    <button class="logout-btn" type="submit">
                        Đăng xuất
                    </button>

                </form>

            </div>

        </div>
    </header>

    <main>
        <section class="card">

            <div class="welcome">

                <h3>
                    Xin chào,
                    <c:out value="${sessionScope.currentUser.fullName}"/>!
                </h3>

                <p>
                    Mã tài khoản:
                    <strong>
                        <c:out value="${sessionScope.currentUser.userName}"/>
                    </strong>
                </p>

            </div>

            <c:choose>

                <%-- MENU BẠN ĐỌC --%>
                <c:when test="${sessionScope.currentRole eq 'READER'}">

                    <h2>Menu bạn đọc</h2>
                    <p>Chọn chức năng bạn muốn sử dụng.</p>

                    <div class="menu">

                        <a class="menu-item"
                           href="${pageContext.request.contextPath}/register">
                            Đăng ký làm thẻ bạn đọc
                        </a>

                    </div>

                </c:when>

                <%-- MENU NHÂN VIÊN THƯ VIỆN --%>
                <c:when test="${sessionScope.currentRole eq 'LIBRARIAN'}">

                    <h2>Menu nhân viên thư viện</h2>
                    <p>Các chức năng dành cho nhân viên thư viện.</p>

                    <div class="menu">

                        <div class="menu-item disabled">
                            Quản lý tài liệu
                            <small>Chưa triển khai</small>
                        </div>

                        <div class="menu-item disabled">
                            Quản lý bạn đọc
                            <small>Chưa triển khai</small>
                        </div>

                        <div class="menu-item disabled">
                            Cho mượn tài liệu
                            <small>Chưa triển khai</small>
                        </div>

                        <div class="menu-item disabled">
                            Nhận trả tài liệu
                            <small>Chưa triển khai</small>
                        </div>

                        <div class="menu-item disabled">
                            Nhập tài liệu
                            <small>Chưa triển khai</small>
                        </div>

                    </div>

                </c:when>

                <%-- MENU NHÂN VIÊN QUẢN LÝ --%>
                <c:when test="${sessionScope.currentRole eq 'MANAGER'}">

                    <h2>Menu nhân viên quản lý</h2>
                    <p>Các chức năng thống kê và báo cáo.</p>

                    <div class="menu">

                        <a class="menu-item"
                           href="${pageContext.request.contextPath}/document-statistics">
                            Thống kê tài liệu theo lượt mượn
                        </a>

                        <div class="menu-item disabled">
                            Thống kê bạn đọc theo lượt mượn
                            <small>Chưa triển khai</small>
                        </div>

                        <div class="menu-item disabled">
                            Thống kê nhà cung cấp theo số lượng nhập
                            <small>Chưa triển khai</small>
                        </div>

                    </div>

                </c:when>

                <%-- TÀI KHOẢN KHÔNG CÓ VAI TRÒ HỢP LỆ --%>
                <c:otherwise>

                    <h2>Không có quyền truy cập</h2>

                    <p>
                        Tài khoản của bạn chưa được phân quyền
                        trong hệ thống.
                    </p>

                </c:otherwise>

            </c:choose>

        </section>
    </main>

</body>
</html>
