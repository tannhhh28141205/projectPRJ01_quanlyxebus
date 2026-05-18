<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quản lý điểm dừng - Hanoi Bus</title>
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
        <a href="manage-stations" class="active"><i class="bi bi-geo-alt me-2"></i> Quản lý điểm dừng</a>
        <a href="manage-schedules"><i class="bi bi-calendar-event me-2"></i> Quản lý lịch trình</a>
        <a href="reports"><i class="bi bi-bar-chart me-2"></i> Báo cáo</a>
        <hr>
        <a href="logout"><i class="bi bi-box-arrow-right me-2"></i> Đăng xuất</a>
    </div>

    <div class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Quản lý điểm dừng (Stations)</h2>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addStationModal">
                <i class="bi bi-plus-circle me-2"></i>Thêm điểm dừng mới
            </button>
        </div>

        <div class="card shadow-sm">
            <div class="card-body">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Mã</th>
                            <th>Tên trạm</th>
                            <th>Địa chỉ</th>
                            <th>Quận/Huyện</th>
                            <th>Vị trí (Lat, Lon)</th>
                            <th>Nhà chờ</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${stationList}" var="s">
                            <tr>
                                <td><code>${s.stationCode}</code></td>
                                <td><strong>${s.stationName}</strong></td>
                                <td>${s.address}</td>
                                <td>${s.district}</td>
                                <td><small>${s.latitude}, ${s.longitude}</small></td>
                                <td>
                                    <c:if test="${s.hasShelter}"><i class="bi bi-check-circle-fill text-success"></i></c:if>
                                    <c:if test="${!s.hasShelter}"><i class="bi bi-x-circle text-muted"></i></c:if>
                                </td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Add Station Modal -->
    <div class="modal fade" id="addStationModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="manage-stations" method="post">
                    <input type="hidden" name="action" value="add">
                    <div class="modal-header">
                        <h5 class="modal-title">Thêm điểm dừng mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Mã trạm</label>
                            <input type="text" name="code" class="form-control" placeholder="S_MYDINH" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Tên trạm</label>
                            <input type="text" name="name" class="form-control" placeholder="Bến xe Mỹ Đình" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Địa chỉ</label>
                            <input type="text" name="address" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Quận/Huyện</label>
                            <input type="text" name="district" class="form-control" required>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <label class="form-label">Vĩ độ (Lat)</label>
                                <input type="number" step="0.000001" name="lat" class="form-control" required>
                            </div>
                            <div class="col">
                                <label class="form-label">Kinh độ (Lon)</label>
                                <input type="number" step="0.000001" name="lon" class="form-control" required>
                            </div>
                        </div>
                        <div class="form-check mb-3">
                            <input class="form-check-input" type="checkbox" name="shelter" id="shelterCheck">
                            <label class="form-check-input" for="shelterCheck">Có nhà chờ</label>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Lưu thông tin</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
