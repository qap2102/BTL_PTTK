
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - LibMan</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f3f6fb;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }

        .login-box {
            width: 380px;
            max-width: 90%;
            background: white;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 5px 25px #00000015;
        }

        h2 {
            text-align: center;
            color: #173b69;
        }

        label {
            display: block;
            margin: 18px 0 7px;
            font-weight: bold;
        }

        input {
            box-sizing: border-box;
            width: 100%;
            padding: 12px;
            border: 1px solid #ccd5e0;
            border-radius: 6px;
        }

        button {
            width: 100%;
            padding: 12px;
            margin-top: 25px;
            border: none;
            border-radius: 6px;
            background: #2563eb;
            color: white;
            cursor: pointer;
            font-size: 16px;
        }

        .error {
            background: #fee2e2;
            color: #991b1b;
            padding: 12px;
            border-radius: 6px;
        }
    </style>
</head>

<body>
    <div class="login-box">
        <h2>LibMan</h2>
        <p style="text-align:center">
            Đăng nhập hệ thống thư viện
        </p>

        <c:if test="${not empty error}">
            <div class="error">
                <c:out value="${error}" />
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login"
              method="post">

            <label for="username">
                Tên đăng nhập
            </label>

            <input type="text"
                   id="username"
                   name="username"
                   placeholder="VD: B21DCCN001"
                   required>

            <label for="password">Mật khẩu</label>

            <input type="password"
                   id="password"
                   name="password"
                   placeholder="Nhập mật khẩu"
                   required>

            <button type="submit">
                Đăng nhập
            </button>
        </form>
    </div>
</body>
</html>
