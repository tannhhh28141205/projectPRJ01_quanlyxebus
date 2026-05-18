<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý tuyến xe - Hanoi Bus</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/app.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>
    <div class="sidebar-shell">
        <aside class="sidebar">
            <h4 class="section-title">Hanoi Bus</h4>
            <p class="section-subtitle mb-3">Bảng điều khiển nội bộ</p>
            <a href="${pageContext.request.contextPath}/admin-dashboard"><i class="bi bi-people"></i> Quản lý người dùng</a>
            <a href="${pageContext.request.contextPath}/manage-buses"><i class="bi bi-truck"></i> Quản lý xe bus</a>
            <a href="${pageContext.request.contextPath}/manage-routes" class="active"><i class="bi bi-map"></i> Quản lý tuyến xe</a>
            <a href="${pageContext.request.contextPath}/manage-stations"><i class="bi bi-geo-alt"></i> Quản lý điểm dừng</a>
            <a href="${pageContext.request.contextPath}/manage-schedules"><i class="bi bi-calendar-event"></i> Quản lý lịch trình</a>
            <a href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a>
        </aside>

        <main class="content-shell">
            <section class="hero">
                <div class="hero-layout">
                    <div class="hero-copy">
                        <span class="pill">Hanoi Bus Routes</span>
                        <h1>Cấu hình mạng lưới tuyến đường và điểm dừng.</h1>
                        <p>Quản lý thông tin chi tiết các tuyến xe: số hiệu, lộ trình, giá vé và màu sắc nhận diện.</p>
                    </div>
                </div>
            </section>

            <section class="panel">
                <div class="panel-header">
                    <div>
                        <h2 class="panel-title">Danh sách tuyến xe</h2>
                        <p class="panel-text">Tổng số tuyến đang hoạt động trong hệ thống.</p>
                    </div>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#routeModal" onclick="clearModal()">
                        <i class="bi bi-plus-circle me-2"></i>Thêm tuyến mới
                    </button>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th>Số hiệu</th>
                                <th>Tên tuyến</th>
                                <th>Loại</th>
                                <th>Thời gian</th>
                                <th>Tần suất</th>
                                <th>Giá vé</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${routeList}" var="r">
                                <tr>
                                    <td><span class="badge" style="background-color: ${r.colorCode != null ? r.colorCode : '#3dd6c6'}">${r.routeNumber}</span></td>
                                    <td><strong>${r.routeName}</strong></td>
                                    <td>${r.routeType}</td>
                                    <td><small>${r.startTime} - ${r.endTime}</small></td>
                                    <td>${r.frequency} phút</td>
                                    <td>${r.baseFare} đ</td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-light" onclick="editRoute(${r.routeID}, '${r.routeNumber}', '${r.routeName}', '${r.routeType}', '${r.startTime}', '${r.endTime}', ${r.frequency}, ${r.distanceKM}, ${r.durationMin}, ${r.baseFare}, '${r.colorCode}')">Sửa</button>
                                        <a href="${pageContext.request.contextPath}/manage-routes?action=delete&id=${r.routeID}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </section>
        </main>
    </div>

    <!-- Route Modal -->
    <div class="modal fade" id="routeModal" tabindex="-1">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <form action="manage-routes" method="post" id="routeForm" class="app-form">
                    <input type="hidden" name="action" id="modal-action" value="add">
                    <input type="hidden" name="id" id="modal-id">
                    <div class="modal-header border-0">
                        <h5 class="modal-title" id="modal-title">Thông tin tuyến xe</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row g-3">
                            <div class="col-md-3">
                                <label class="form-label">Số hiệu</label>
                                <input type="text" name="number" id="modal-number" class="form-control" required>
                            </div>
                            <div class="col-md-9">
                                <label class="form-label">Tên tuyến</label>
                                <input type="text" name="name" id="modal-name" class="form-control" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Loại tuyến</label>
                                <select name="type" id="modal-type" class="form-select">
                                    <option value="CITY">Nội thành</option>
                                    <option value="SUBURBAN">Ngoại thành</option>
                                    <option value="AIRPORT">Sân bay</option>
                                    <option value="BRT">BRT</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Bắt đầu</label>
                                <input type="time" name="start" id="modal-start" class="form-control" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Kết thúc</label>
                                <input type="time" name="end" id="modal-end" class="form-control" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Tần suất (phút)</label>
                                <input type="number" name="freq" id="modal-freq" class="form-control" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Cự ly (km)</label>
                                <input type="number" step="0.1" name="distance" id="modal-distance" class="form-control" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Thời gian chạy</label>
                                <input type="number" name="duration" id="modal-duration" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Giá vé (đ)</label>
                                <input type="number" name="fare" id="modal-fare" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Màu sắc</label>
                                <input type="color" name="color" id="modal-color" class="form-control form-control-color w-100" style="height: 46px;">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer border-0">
                        <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Lưu tuyến xe</button>
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
            new bootstrap.Modal(document.getElementById('routeModal')).show();
        }
    </script>
</body>
</html>
