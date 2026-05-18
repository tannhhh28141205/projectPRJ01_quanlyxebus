<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quản lý người dùng - Hanoi Bus</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        body { background-color: #f8f9fa; }
        .sidebar { height: 100vh; background: #212529; color: white; position: fixed; width: 250px; }
        .sidebar a { color: rgba(255,255,255,0.8); text-decoration: none; padding: 15px 20px; display: block; }
        .sidebar a:hover { background: #343a40; color: white; }
        .sidebar a.active { background: #0d6efd; color: white; }
        .main-content { margin-left: 250px; padding: 20px; }
    </style>
</head>
<body>
    <div class="sidebar">
        <h4 class="p-3 text-center text-primary">Hanoi Bus</h4>
        <hr>
        <a href="admin-dashboard" class="active"><i class="bi bi-people me-2"></i> Quản lý người dùng</a>
        <a href="manage-buses"><i class="bi bi-truck me-2"></i> Quản lý xe bus</a>
        <a href="manage-routes"><i class="bi bi-map me-2"></i> Quản lý tuyến xe</a>
        <a href="manage-schedules"><i class="bi bi-calendar-event me-2"></i> Quản lý lịch trình</a>
        <a href="reports"><i class="bi bi-bar-chart me-2"></i> Báo cáo</a>
        <hr>
        <a href="logout"><i class="bi bi-box-arrow-right me-2"></i> Đăng xuất</a>
    </div>

    <div class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Quản lý người dùng</h2>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
                <i class="bi bi-person-plus me-2"></i>Thêm người dùng mới
            </button>
        </div>

        <div class="card shadow-sm">
            <div class="card-body">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Họ tên</th>
                            <th>Email / SĐT</th>
                            <th>Vai trò</th>
                            <th>Trạng thái</th>
                            <th>Ngày tạo</th>
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
                                    <div><i class="bi bi-envelope me-1"></i> ${u.email}</div>
                                    <div class="text-muted small"><i class="bi bi-phone me-1"></i> ${u.phoneNumber}</div>
                                </td>
                                <td><span class="badge bg-info text-dark">${u.roleName}</span></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.active}">
                                            <span class="badge bg-success">Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">Khóa</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${u.createdAt}</td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></button>
                                    <button class="btn btn-sm btn-outline-danger"><i class="bi bi-lock"></i></button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Add User Modal -->
    <div class="modal fade" id="addUserModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="admin-dashboard" method="post">
                    <input type="hidden" name="action" value="add">
                    <div class="modal-header">
                        <h5 class="modal-title">Thêm người dùng mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Username</label>
                            <input type="text" name="user" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mật khẩu</label>
                            <input type="password" name="pass" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Họ và tên</label>
                            <input type="text" name="name" class="form-control" required>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <label class="form-label">Email</label>
                                <input type="email" name="email" class="form-control">
                            </div>
                            <div class="col">
                                <label class="form-label">Số điện thoại</label>
                                <input type="text" name="phone" class="form-control">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Vai trò</label>
                            <select name="roleID" class="form-select">
                                <option value="1">Quản trị viên (ADMIN)</option>
                                <option value="2">Điều độ viên (DISPATCHER)</option>
                                <option value="3">Tài xế (DRIVER)</option>
                                <option value="4">Phụ xe (ASSISTANT)</option>
                                <option value="5" selected>Khách hàng (CUSTOMER)</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Tạo tài khoản</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
