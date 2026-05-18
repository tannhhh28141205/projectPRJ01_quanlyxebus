<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý điểm dừng - Hanoi Bus</title>
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
            <a href="${pageContext.request.contextPath}/manage-routes"><i class="bi bi-map"></i> Quản lý tuyến xe</a>
            <a href="${pageContext.request.contextPath}/manage-stations" class="active"><i class="bi bi-geo-alt"></i> Quản lý điểm dừng</a>
            <a href="${pageContext.request.contextPath}/manage-schedules"><i class="bi bi-calendar-event"></i> Quản lý lịch trình</a>
            <a href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a>
        </aside>

        <main class="content-shell">
            <section class="hero">
                <div class="hero-layout">
                    <div class="hero-copy">
                        <span class="pill">Bus Stations</span>
                        <h1>Quản lý hệ thống điểm dừng và nhà chờ.</h1>
                        <p>Cập nhật tọa độ GPS, địa chỉ và tiện ích tại mỗi trạm dừng trong mạng lưới.</p>
                    </div>
                </div>
            </section>

            <section class="panel">
                <div class="panel-header">
                    <div>
                        <h2 class="panel-title">Danh sách trạm dừng</h2>
                        <p class="panel-text">Toàn bộ các điểm đón trả khách đã được đăng ký.</p>
                    </div>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addStationModal">
                        <i class="bi bi-plus-circle me-2"></i>Thêm trạm mới
                    </button>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th>Mã</th>
                                <th>Tên trạm</th>
                                <th>Địa chỉ</th>
                                <th>Quận/Huyện</th>
                                <th>Vị trí</th>
                                <th>Tiện ích</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${stationList}" var="s">
                                <tr>
                                    <td><code>${s.stationCode}</code></td>
                                    <td><strong>${s.stationName}</strong></td>
                                    <td><small>${s.address}</small></td>
                                    <td>${s.district}</td>
                                    <td><small>${s.latitude}, ${s.longitude}</small></td>
                                    <td>
                                        <c:if test="${s.hasShelter}"><span class="badge bg-success">Nhà chờ</span></c:if>
                                        <c:if test="${s.hasLedBoard}"><span class="badge bg-info">Bảng LED</span></c:if>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-light">Sửa</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </section>
        </main>
    </div>

    <!-- Add Station Modal -->
    <div class="modal fade" id="addStationModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form action="manage-stations" method="post" class="app-form">
                    <input type="hidden" name="action" value="add">
                    <div class="modal-header border-0">
                        <h5 class="modal-title">Thêm điểm dừng mới</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Mã trạm</label>
                                <input type="text" name="code" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Tên trạm</label>
                                <input type="text" name="name" class="form-control" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label">Địa chỉ</label>
                                <input type="text" name="address" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Quận/Huyện</label>
                                <input type="text" name="district" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Phường/Xã</label>
                                <input type="text" name="ward" class="form-control">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Vĩ độ (Lat)</label>
                                <input type="number" step="0.000001" name="lat" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Kinh độ (Lon)</label>
                                <input type="number" step="0.000001" name="lon" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="shelter" id="shelterCheck">
                                    <label class="form-check-label" for="shelterCheck">Có nhà chờ</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="led" id="ledCheck">
                                    <label class="form-check-label" for="ledCheck">Có bảng LED</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer border-0">
                        <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Lưu thông tin</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
