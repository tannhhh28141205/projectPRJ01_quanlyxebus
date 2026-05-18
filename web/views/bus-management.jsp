<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý xe bus - Hanoi Bus</title>
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
            <a href="${pageContext.request.contextPath}/manage-buses" class="active"><i class="bi bi-truck"></i> Quản lý xe bus</a>
            <a href="${pageContext.request.contextPath}/manage-routes"><i class="bi bi-map"></i> Quản lý tuyến xe</a>
            <a href="${pageContext.request.contextPath}/manage-schedules"><i class="bi bi-calendar-event"></i> Quản lý lịch trình</a>
            <a href="${pageContext.request.contextPath}/bao-cao"><i class="bi bi-bar-chart"></i> Báo cáo</a>
            <a href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a>
        </aside>

        <main class="content-shell">
            <section class="hero">
                <div class="hero-layout">
                    <div class="hero-copy">
                        <span class="pill">Quản lý đội xe</span>
                        <h1>Danh sách xe bus, trạng thái và thông tin kỹ thuật.</h1>
                        <p>
                            Trang này dành cho quản trị đội xe với khả năng thêm mới, cập nhật và xóa phương tiện.
                        </p>
                    </div>
                    <div class="hero-side">
                        <div class="panel">
                            <div class="status-chip">Biển số</div>
                            <div class="status-chip" style="margin-top: 10px;">Sức chứa</div>
                            <div class="status-chip" style="margin-top: 10px;">Tình trạng hoạt động</div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="panel">
                <div class="panel-header">
                    <div>
                        <h2 class="panel-title">Danh sách xe bus</h2>
                        <p class="panel-text">Quản lý toàn bộ phương tiện đang có trong hệ thống.</p>
                    </div>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBusModal">
                        <i class="bi bi-plus-circle me-2"></i>Thêm xe mới
                    </button>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Biển số</th>
                                <th>Số hiệu</th>
                                <th>Sức chứa</th>
                                <th>Loại xe</th>
                                <th>Hãng xe</th>
                                <th>Năm SX</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${busList}" var="b">
                                <tr>
                                    <td>${b.busID}</td>
                                    <td><strong>${b.licensePlate}</strong></td>
                                    <td>${b.fleetNumber}</td>
                                    <td>
                                        <span class="badge bg-secondary">${b.capacitySeats} chỗ ngồi</span>
                                        <span class="badge bg-light text-dark">${b.capacityStanding} chỗ đứng</span>
                                    </td>
                                    <td>${b.busType}</td>
                                    <td>${b.brand}</td>
                                    <td>${b.manufactureYear}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${b.status == 'ACTIVE'}"><span class="badge bg-success">Đang hoạt động</span></c:when>
                                            <c:when test="${b.status == 'MAINTENANCE'}"><span class="badge bg-warning text-dark">Bảo trì</span></c:when>
                                            <c:otherwise><span class="badge bg-danger">${b.status}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-light" onclick="editBus(${b.busID}, '${b.licensePlate}', '${b.fleetNumber}', ${b.capacitySeats}, ${b.capacityStanding}, '${b.busType}', '${b.brand}', ${b.manufactureYear}, '${b.status}')">Sửa</button>
                                        <a href="${pageContext.request.contextPath}/manage-buses?action=delete&id=${b.busID}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa xe này?')">Xóa</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </section>
        </main>
    </div>

    <div class="modal fade" id="addBusModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form action="manage-buses" method="post" class="app-form">
                    <input type="hidden" name="action" value="add">
                    <div class="modal-header border-0">
                        <h5 class="modal-title">Thêm xe bus mới</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Biển số xe</label>
                                <input type="text" name="plate" class="form-control" placeholder="29B-123.45" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Số hiệu đoàn</label>
                                <input type="text" name="fleet" class="form-control" placeholder="16-01">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Số chỗ ngồi</label>
                                <input type="number" name="seats" class="form-control" value="30" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Số chỗ đứng</label>
                                <input type="number" name="standing" class="form-control" value="30" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label">Loại xe</label>
                                <select name="type" class="form-select">
                                    <option value="DIESEL">DIESEL</option>
                                    <option value="CNG">CNG</option>
                                    <option value="EV">EV (Điện)</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Hãng sản xuất</label>
                                <input type="text" name="brand" class="form-control" placeholder="Thaco, Daewoo...">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Năm sản xuất</label>
                                <input type="number" name="year" class="form-control" value="2023">
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

    <div class="modal fade" id="editBusModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form action="manage-buses" method="post" class="app-form">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="id" id="edit-id">
                    <div class="modal-header border-0">
                        <h5 class="modal-title">Chỉnh sửa thông tin xe</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Biển số xe</label>
                                <input type="text" name="plate" id="edit-plate" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Số hiệu đoàn</label>
                                <input type="text" name="fleet" id="edit-fleet" class="form-control">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Số chỗ ngồi</label>
                                <input type="number" name="seats" id="edit-seats" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Số chỗ đứng</label>
                                <input type="number" name="standing" id="edit-standing" class="form-control" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label">Loại xe</label>
                                <select name="type" id="edit-type" class="form-select">
                                    <option value="DIESEL">DIESEL</option>
                                    <option value="CNG">CNG</option>
                                    <option value="EV">EV (Điện)</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Hãng sản xuất</label>
                                <input type="text" name="brand" id="edit-brand" class="form-control">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Năm sản xuất</label>
                                <input type="number" name="year" id="edit-year" class="form-control">
                            </div>
                            <div class="col-12">
                                <label class="form-label">Trạng thái</label>
                                <select name="status" id="edit-status" class="form-select">
                                    <option value="ACTIVE">Đang hoạt động</option>
                                    <option value="MAINTENANCE">Bảo trì</option>
                                    <option value="BROKEN">Hỏng</option>
                                    <option value="RETIRED">Ngừng sử dụng</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer border-0">
                        <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editBus(id, plate, fleet, seats, standing, type, brand, year, status) {
            document.getElementById('edit-id').value = id;
            document.getElementById('edit-plate').value = plate;
            document.getElementById('edit-fleet').value = fleet;
            document.getElementById('edit-seats').value = seats;
            document.getElementById('edit-standing').value = standing;
            document.getElementById('edit-type').value = type;
            document.getElementById('edit-brand').value = brand;
            document.getElementById('edit-year').value = year;
            document.getElementById('edit-status').value = status;
            new bootstrap.Modal(document.getElementById('editBusModal')).show();
        }
    </script>
</body>
</html>
