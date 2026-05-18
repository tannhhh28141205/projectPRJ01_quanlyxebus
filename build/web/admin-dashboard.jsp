<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Hanoi Bus</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/app.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>
    <div class="sidebar-shell">
        <aside class="sidebar">
            <h4 class="section-title">Hanoi Bus</h4>
            <p class="section-subtitle mb-3">Quản trị hệ thống</p>
            <a href="admin-dashboard" class="active"><i class="bi bi-people"></i> Người dùng</a>
            <a href="manage-buses"><i class="bi bi-truck"></i> Xe bus</a>
            <a href="manage-routes"><i class="bi bi-map"></i> Tuyến xe</a>
            <a href="manage-stations"><i class="bi bi-geo-alt"></i> Điểm dừng</a>
            <a href="manage-schedules"><i class="bi bi-calendar-event"></i> Lịch trình</a>
            <a href="logout"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a>
        </aside>

        <main class="content-shell">
            <section class="hero">
                <div class="hero-layout">
                    <div class="hero-copy">
                        <span class="pill">Admin</span>
                        <h1>Quản lý toàn bộ tài khoản và cấu hình hệ thống.</h1>
                        <p>Dành riêng cho người quản trị cấp cao để kiểm soát nhân sự và dữ liệu nền.</p>
                    </div>
                </div>
            </section>

            <section class="panel">
                <div class="panel-header">
                    <div>
                        <h2 class="panel-title">Quản lý người dùng</h2>
                    </div>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
                        <i class="bi bi-person-plus me-2"></i>Thêm người dùng
                    </button>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Username</th>
                                <th>Họ tên</th>
                                <th>Email / SĐT</th>
                                <th>Vai trò</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${listU}" var="u">
                                <tr>
                                    <td>${u.userID}</td>
                                    <td><strong>${u.username}</strong></td>
                                    <td>${u.fullName}</td>
                                    <td>
                                        <div><small>${u.email}</small></div>
                                        <div><small>${u.phoneNumber}</small></div>
                                    </td>
                                    <td><span class="badge bg-info text-dark">${u.roleName}</span></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${u.active}"><span class="badge bg-success">Hoạt động</span></c:when>
                                            <c:otherwise><span class="badge bg-secondary">Khóa</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-light"><i class="bi bi-pencil"></i></button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </section>
        </main>
    </div>

    <!-- Add User Modal -->
    <div class="modal fade" id="addUserModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form action="admin-dashboard" method="post" class="app-form">
                    <input type="hidden" name="action" value="add">
                    <div class="modal-header border-0">
                        <h5 class="modal-title">Thêm người dùng mới</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Username</label>
                                <input type="text" name="user" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Mật khẩu</label>
                                <input type="password" name="pass" class="form-control" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label">Họ và tên</label>
                                <input type="text" name="name" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Email</label>
                                <input type="email" name="email" class="form-control">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Số điện thoại</label>
                                <input type="text" name="phone" class="form-control">
                            </div>
                            <div class="col-12">
                                <label class="form-label">Vai trò</label>
                                <select name="roleID" class="form-select">
                                    <option value="1">Quản trị viên (ADMIN)</option>
                                    <option value="2">Điều độ viên (DISPATCHER)</option>
                                    <option value="3">Tài xế (DRIVER)</option>
                                    <option value="4">Phụ xe (ASSISTANT)</option>
                                    <option value="5">Khách hàng (CUSTOMER)</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer border-0">
                        <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Tạo tài khoản</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
