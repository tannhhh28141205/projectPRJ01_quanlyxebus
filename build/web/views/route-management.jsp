<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quản lý tuyến xe - Hanoi Bus</title>
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
        <a href="manage-routes" class="active"><i class="bi bi-map me-2"></i> Quản lý tuyến xe</a>
        <a href="manage-schedules"><i class="bi bi-calendar-event me-2"></i> Quản lý lịch trình</a>
        <a href="reports"><i class="bi bi-bar-chart me-2"></i> Báo cáo</a>
        <hr>
        <a href="logout"><i class="bi bi-box-arrow-right me-2"></i> Đăng xuất</a>
    </div>

    <div class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Quản lý tuyến xe</h2>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#routeModal" onclick="clearModal()">
                <i class="bi bi-plus-circle me-2"></i>Thêm tuyến mới
            </button>
        </div>

        <div class="card shadow-sm">
            <div class="card-body">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Số hiệu</th>
                            <th>Tên tuyến</th>
                            <th>Loại</th>
                            <th>Thời gian</th>
                            <th>Tần suất</th>
                            <th>Cự ly</th>
                            <th>Giá vé</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${routeList}" var="r">
                            <tr>
                                <td><span class="badge" style="background-color: ${r.colorCode}">${r.routeNumber}</span></td>
                                <td><strong>${r.routeName}</strong></td>
                                <td>${r.routeType}</td>
                                <td>${r.startTime} - ${r.endTime}</td>
                                <td>${r.frequency} phút</td>
                                <td>${r.distanceKM} km</td>
                                <td>${r.baseFare} VND</td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary" onclick="editRoute(${r.routeID}, '${r.routeNumber}', '${r.routeName}', '${r.routeType}', '${r.startTime}', '${r.endTime}', ${r.frequency}, ${r.distanceKM}, ${r.durationMin}, ${r.baseFare}, '${r.colorCode}')">
                                        <i class="bi bi-pencil"></i>
                                    </button>
                                    <a href="manage-routes?action=delete&id=${r.routeID}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa tuyến này?')">
                                        <i class="bi bi-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Route Modal -->
    <div class="modal fade" id="routeModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <form action="manage-routes" method="post" id="routeForm">
                    <input type="hidden" name="action" id="modal-action" value="add">
                    <input type="hidden" name="id" id="modal-id">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modal-title">Thêm tuyến xe mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-md-3">
                                <label class="form-label">Số hiệu</label>
                                <input type="text" name="number" id="modal-number" class="form-control" placeholder="01" required>
                            </div>
                            <div class="col-md-9">
                                <label class="form-label">Tên tuyến</label>
                                <input type="text" name="name" id="modal-name" class="form-control" placeholder="Bến xe Mỹ Đình - Bến xe Giáp Bát" required>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4">
                                <label class="form-label">Loại tuyến</label>
                                <select name="type" id="modal-type" class="form-select">
                                    <option value="CITY">Nội thành (CITY)</option>
                                    <option value="SUBURBAN">Ngoại thành (SUBURBAN)</option>
                                    <option value="AIRPORT">Sân bay (AIRPORT)</option>
                                    <option value="BRT">BRT</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Giờ bắt đầu</label>
                                <input type="time" name="start" id="modal-start" class="form-control" value="05:00" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Giờ kết thúc</label>
                                <input type="time" name="end" id="modal-end" class="form-control" value="21:00" required>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4">
                                <label class="form-label">Tần suất (phút)</label>
                                <input type="number" name="freq" id="modal-freq" class="form-control" value="15" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Cự ly (km)</label>
                                <input type="number" step="0.1" name="distance" id="modal-distance" class="form-control" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Thời gian chạy (phút)</label>
                                <input type="number" name="duration" id="modal-duration" class="form-control" required>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Giá vé cơ bản (VND)</label>
                                <input type="number" name="fare" id="modal-fare" class="form-control" value="7000" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Màu nhận diện</label>
                                <input type="color" name="color" id="modal-color" class="form-control form-control-color w-100" value="#00529C">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function clearModal() {
            document.getElementById('modal-action').value = 'add';
            document.getElementById('modal-id').value = '';
            document.getElementById('modal-title').innerText = 'Thêm tuyến xe mới';
            document.getElementById('routeForm').reset();
        }

        function editRoute(id, number, name, type, start, end, freq, distance, duration, fare, color) {
            document.getElementById('modal-action').value = 'edit';
            document.getElementById('modal-id').value = id;
            document.getElementById('modal-title').innerText = 'Chỉnh sửa tuyến xe';
            
            document.getElementById('modal-number').value = number;
            document.getElementById('modal-name').value = name;
            document.getElementById('modal-type').value = type;
            document.getElementById('modal-start').value = start.substring(0, 5);
            document.getElementById('modal-end').value = end.substring(0, 5);
            document.getElementById('modal-freq').value = freq;
            document.getElementById('modal-distance').value = distance;
            document.getElementById('modal-duration').value = duration;
            document.getElementById('modal-fare').value = fare;
            document.getElementById('modal-color').value = color;
            
            var modal = new bootstrap.Modal(document.getElementById('routeModal'));
            modal.show();
        }
    </script>
</body>
</html>
