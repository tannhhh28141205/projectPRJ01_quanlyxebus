<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quản lý lịch trình - Hanoi Bus</title>
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
        <a href="admin-dashboard"><i class="bi bi-people me-2"></i> Quản lý người dùng</a>
        <a href="manage-buses"><i class="bi bi-truck me-2"></i> Quản lý xe bus</a>
        <a href="manage-routes"><i class="bi bi-map me-2"></i> Quản lý tuyến xe</a>
        <a href="manage-schedules" class="active"><i class="bi bi-calendar-event me-2"></i> Quản lý lịch trình</a>
        <a href="reports"><i class="bi bi-bar-chart me-2"></i> Báo cáo</a>
        <hr>
        <a href="logout"><i class="bi bi-box-arrow-right me-2"></i> Đăng xuất</a>
    </div>

    <div class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Quản lý lịch trình (Trips)</h2>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addTripModal">
                <i class="bi bi-plus-circle me-2"></i>Lập lịch chuyến mới
            </button>
        </div>

        <div class="card shadow-sm">
            <div class="card-body">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Tuyến</th>
                            <th>Xe</th>
                            <th>Ngày</th>
                            <th>Giờ đi dự kiến</th>
                            <th>Hướng</th>
                            <th>Trạng thái</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listS}" var="s">
                            <tr>
                                <td>${s.scheduleID}</td>
                                <td><strong>Tuyến ${s.routeNumber}</strong></td>
                                <td>${s.licensePlate}</td>
                                <td>${s.tripDate}</td>
                                <td>${s.plannedStartTime}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${s.direction == 'OUTBOUND'}">Lượt đi</c:when>
                                        <c:otherwise>Lượt về</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${s.status == 'SCHEDULED'}">
                                            <span class="badge bg-primary">Đã lên lịch</span>
                                        </c:when>
                                        <c:when test="${s.status == 'DEPARTED'}">
                                            <span class="badge bg-warning text-dark">Đã khởi hành</span>
                                        </c:when>
                                        <c:when test="${s.status == 'ARRIVED'}">
                                            <span class="badge bg-success">Đã đến nơi</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">${s.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary"><i class="bi bi-eye"></i></button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Add Trip Modal -->
    <div class="modal fade" id="addTripModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <form action="manage-schedules" method="post">
                    <input type="hidden" name="action" value="add">
                    <div class="modal-header">
                        <h5 class="modal-title">Lập lịch chuyến xe mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Chọn tuyến</label>
                                <select name="routeID" class="form-select" required>
                                    <c:forEach items="${listR}" var="r">
                                        <option value="${r.routeID}">${r.routeNumber} - ${r.routeName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Chọn xe</label>
                                <select name="busID" class="form-select" required>
                                    <c:forEach items="${listB}" var="b">
                                        <option value="${b.busID}">${b.licensePlate} (${b.fleetNumber})</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Tài xế</label>
                                <select name="driverID" class="form-select" required>
                                    <c:forEach items="${listD}" var="d">
                                        <option value="${d.userID}">${d.fullName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Phụ xe</label>
                                <select name="assistantID" class="form-select">
                                    <option value="">Không có</option>
                                    <c:forEach items="${listA}" var="a">
                                        <option value="${a.userID}">${a.fullName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4">
                                <label class="form-label">Ngày đi</label>
                                <input type="date" name="date" class="form-control" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Giờ đi</label>
                                <input type="time" name="time" class="form-control" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Hướng đi</label>
                                <select name="direction" class="form-select">
                                    <option value="OUTBOUND">Lượt đi</option>
                                    <option value="INBOUND">Lượt về</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Xác nhận lập lịch</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
