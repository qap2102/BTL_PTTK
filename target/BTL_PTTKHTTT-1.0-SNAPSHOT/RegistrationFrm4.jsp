
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1">
    <title>Đăng ký thẻ bạn đọc - LibMan</title>

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
            max-width: 650px;
            margin: 35px auto;
            padding: 0 16px;
        }

        .card {
            background: white;
            padding: 32px;
            border-radius: 12px;
            box-shadow: 0 5px 22px #00000012;
        }

        h2 {
            text-align: center;
            color: #173b69;
        }

        .subtitle {
            text-align: center;
            color: #667085;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 7px;
        }

        input, select {
            width: 100%;
            padding: 11px;
            border: 1px solid #ccd5e0;
            border-radius: 6px;
            font-size: 15px;
        }

        input:focus, select:focus {
            outline: none;
            border-color: #2563eb;
        }

        .required {
            color: #dc2626;
        }

        .error {
            background: #fee2e2;
            color: #991b1b;
            padding: 13px;
            border-radius: 6px;
            margin-bottom: 20px;
        }

        .actions {
            display: flex;
            gap: 12px;
            margin-top: 25px;
        }

        .btn {
            padding: 12px 20px;
            border-radius: 6px;
            text-align: center;
            text-decoration: none;
            font-size: 15px;
            cursor: pointer;
            flex: 1;
        }

        .btn-primary {
            background: #2563eb;
            color: white;
            border: none;
        }

        .btn-secondary {
            background: #e5e7eb;
            color: #263449;
            border: none;
        }

        .note {
            color: #667085;
            font-size: 13px;
        }

        @media (max-width: 480px) {
            .actions {
                flex-direction: column;
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

        <h2>Đăng ký làm thẻ bạn đọc</h2>

        <p class="subtitle">
            Vui lòng nhập thông tin đăng ký
        </p>

        <!-- Hiển thị lỗi từ Servlet -->
        <c:if test="${not empty error}">
            <div class="error">
                <c:out value="${error}" />
            </div>
        </c:if>

        <form
            action="${pageContext.request.contextPath}/register"
            method="post"
            accept-charset="UTF-8">

            <!-- Họ và tên -->
            <div class="form-group">
                <label for="fullName">
                    Họ và tên
                    <span class="required">*</span>
                </label>

                <input
                    type="text"
                    id="fullName"
                    name="fullName"
                    maxlength="150"
                    value="<c:out value='${param.fullName}' />"
                    placeholder="Nhập họ và tên"
                    required>
            </div>

            <!-- Ngày sinh -->
            <div class="form-group">
                <label for="dateOfBirth">
                    Ngày sinh
                </label>

                <input
                    type="date"
                    id="dateOfBirth"
                    name="dateOfBirth"
                    value="<c:out value='${param.dateOfBirth}' />">
            </div>

            <!-- Số điện thoại -->
            <div class="form-group">
                <label for="phoneNumber">
                    Số điện thoại
                </label>

                <input
                    type="tel"
                    id="phoneNumber"
                    name="phoneNumber"
                    maxlength="20"
                    value="<c:out value='${param.phoneNumber}' />"
                    placeholder="Nhập số điện thoại">
            </div>

            <!-- Email -->
            <div class="form-group">
                <label for="email">
                    Email
                </label>

                <input
                    type="email"
                    id="email"
                    name="email"
                    maxlength="150"
                    value="<c:out value='${param.email}' />"
                    placeholder="example@gmail.com">
            </div>

            <!-- Loại bạn đọc -->
            <div class="form-group">
                <label for="readerCategoryId">
                    Loại bạn đọc
                    <span class="required">*</span>
                </label>

                <select
                    id="readerCategoryId"
                    name="readerCategoryId"
                    required>

                    <option value="">
                        -- Chọn loại bạn đọc --
                    </option>

                    <c:forEach
                        var="category"
                        items="${readerCategories}">

                        <option
                            value="${category.id}"
                            ${param.readerCategoryId == category.id
                              ? 'selected' : ''}>

                            <c:out
                                value="${category.readerType}" />
                        </option>

                    </c:forEach>
                </select>
            </div>

            <!-- Mã bạn đọc -->
            <div class="form-group">
                <label for="readerCode">
                    Mã bạn đọc
                    <span class="required">*</span>
                </label>

                <input
                    type="text"
                    id="readerCode"
                    name="readerCode"
                    maxlength="50"
                    value="<c:out value='${param.readerCode}' />"
                    placeholder="Nhập mã bạn đọc"
                    required>
            </div>

            <p class="note">
                (*) Các trường bắt buộc.
                Bạn đọc phải có hồ sơ trong hệ thống
                trước khi đăng ký thẻ.
            </p>

            <div class="actions">
                <a
                    class="btn btn-secondary"
                    href="${pageContext.request.contextPath}/MainMenuFrm4.jsp">
                    Quay lại
                </a>

                <button
                    type="submit"
                    class="btn btn-primary">
                    Đăng ký
                </button>
            </div>

        </form>
    </div>
</div>

</body>
</html>
