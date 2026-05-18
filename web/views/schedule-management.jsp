<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý lịch trình - Hanoi Bus</title>
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
            <a href="${pageContext.request.contextPath}/manage-stations"><i class="bi bi-geo-alt"></i> Quản lý điểm dừng</a>
            <a href="${pageContext.request.contextPath}/manage-schedules" class="active"><i class="bi bi-calendar-event"></i> Quản lý lịch trình</a>
            <a href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a>
        </aside>

        <main class="content-shell">
            <section class="hero">
                <div class="hero-layout">
                    <div class="hero-copy">
                        <span class="pill">Bus Schedules</span>
                        <h1>Lập kế hoạch và điều phối các chuyến xe.</h1>
                        <p>Phân công phương tiện và nhân sự cho từng khung giờ chạy trong ngày.</p>
                    </div>
                </div>
            </section>

            <section class="panel">
                <div class="panel-header">
                    <div>
                        <h2 class="panel-title">Danh sách lịch trình</h2>
                        <p class="panel-text">Các chuyến xe đã được lên kế hoạch và trạng thái vận hành.</p>
                    </div>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addTripModal">
                        <i class="bi bi-plus-circle me-2"></i>Lập lịch chuyến mới
                    </button>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th>Tuyến</th>
                                <th>Xe</th>
                                <th>Ngày chạy</th>
                                <th>Giờ khởi hành</th>
                                <th>Hướng</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${listS}" var="s">
                                <tr>
                                    <td><strong>Tuyến ${s.routeNumber}</strong></td>
                                    <td>${s.licensePlate}</td>
                                    <td><small>${s.tripDate}</small></td>
                                    <td>${s.plannedStartTime}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${s.direction == 'OUTBOUND'}">Lượt đi</c:when>
                                            <c:otherwise>Lượt về</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${s.status == 'SCHEDULED'}"><span class="badge bg-secondary">Đã lên lịch</span></c:when>
                                            <c:when test="${s.status == 'DEPARTED'}"><span class="badge bg-primary">Đang chạy</span></c:when>
                                            <c:when test="${s.status == 'ARRIVED'}"><span class="badge bg-success">Hoàn thành</span></c:when>
                                            <c:otherwise><span class="badge bg-danger">${s.status}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-light">Chi tiết</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </section>
        </main>
    </div>

    <!-- Add Trip Modal -->
    <div class="modal fade" id="addTripModal" tabindex="-1">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <form action="manage-schedules" method="post" class="app-form">
                    <input type="hidden" name="action" value="add">
                    <div class="modal-header border-0">
                        <h5 class="modal-title">Lập lịch chuyến xe mới</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Tuyến xe</label>
                                <select name="routeID" class="form-select" required>
                                    <c:forEach items="${listR}" var="r">
                                        <option value="${r.routeID}">${r.routeNumber} - ${r.routeName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Xe bus</label>
                                <select name="busID" class="form-select" required>
                                    <c:forEach items="${listB}" var="b">
                                        <option value="${b.busID}">${b.licensePlate}</option>
                                    </c:forEach>
                                </select>
                            </div>
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
                                    <option value="0">-- Không có --</option>
                                    <c:forEach items="${listA}" var="a">
                                        <option value="${a.userID}">${a.fullName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Ngày chạy</label>
                                <input type="date" name="date" class="form-control" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Giờ đi</label>
                                <input type="time" name="time" class="form-control" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Hướng</label>
                                <select name="direction" class="form-select">
                                    <option value="OUTBOUND">Lượt đi</option>
                                    <option value="INBOUND">Lượt về</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer border-0">
                        <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Xác nhận lịch chạy</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
