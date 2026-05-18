<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Hanoi Bus</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/app.css">
</head>
<body>
    <main class="page-wrap" style="min-height: 100vh; display: grid; place-items: center;">
        <section class="hero" style="width: min(980px, 100%);">
            <div class="hero-layout">
                <div class="hero-copy">
                    <span class="pill">Hanoi Bus Control Center</span>
                    <h1>Đăng nhập để quản lý tuyến, vé và lịch trình.</h1>
                    <p>
                        Một tài khoản, nhiều vai trò: khách hàng, phụ xe, tài xế, điều phối và quản trị.
                        Giao diện mới ưu tiên tốc độ thao tác và rõ ràng trên cả máy tính lẫn điện thoại.
                    </p>
                    <div class="hero-actions">
                        <a class="btn btn-outline-light" href="${pageContext.request.contextPath}/index.html">Về trang chủ</a>
                        <a class="btn btn-primary" href="${pageContext.request.contextPath}/tim-tuyen">Tra cứu tuyến</a>
                    </div>
                </div>
                <div class="panel">
                    <div class="panel-header">
                        <div>
                            <h2 class="panel-title">Đăng nhập hệ thống</h2>
                            <p class="panel-text">Sử dụng tài khoản được cấp để truy cập dashboard.</p>
                        </div>
                    </div>

                    <p class="text-danger mb-3">${mess}</p>

                    <form action="login" method="post" class="app-form">
                        <div class="mb-3">
                            <label class="form-label">Tên đăng nhập</label>
                            <input type="text" name="user" class="form-control" required placeholder="Nhập username">
                        </div>
                        <div class="mb-4">
                            <label class="form-label">Mật khẩu</label>
                            <input type="password" name="pass" class="form-control" required placeholder="Nhập password">
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
                    </form>
                </div>
            </div>
        </section>
    </main>
</body>
</html>
