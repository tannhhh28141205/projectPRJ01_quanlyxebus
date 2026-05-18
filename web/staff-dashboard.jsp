<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dispatcher Dashboard - Hanoi Bus</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/app.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>
    <div class="sidebar-shell">
        <aside class="sidebar">
            <h4 class="section-title">Hanoi Bus</h4>
            <p class="section-subtitle mb-3">Điều phối vận hành</p>
            <a href="${pageContext.request.contextPath}/staff-dashboard" class="active"><i class="bi bi-speedometer2"></i> Tổng quan</a>
            <a href="${pageContext.request.contextPath}/manage-buses"><i class="bi bi-truck"></i> Quản lý xe bus</a>
            <a href="${pageContext.request.contextPath}/manage-routes"><i class="bi bi-map"></i> Quản lý tuyến xe</a>
            <a href="${pageContext.request.contextPath}/manage-stations"><i class="bi bi-geo-alt"></i> Quản lý điểm dừng</a>
            <a href="${pageContext.request.contextPath}/manage-schedules"><i class="bi bi-calendar-event"></i> Lập lịch chạy</a>
            <a href="${pageContext.request.contextPath}/bao-cao"><i class="bi bi-bar-chart"></i> Xem báo cáo</a>
            <a href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a>
        </aside>

        <main class="content-shell">
            <section class="hero">
                <div class="hero-layout">
                    <div class="hero-copy">
                        <span class="pill">Dispatcher</span>
                        <h1>Theo dõi và điều phối vận hành toàn mạng lưới.</h1>
                        <p>Kiểm soát lịch trình, trạng thái xe và đảm bảo các chuyến đi đúng giờ.</p>
                    </div>
                </div>
            </section>

            <section class="grid-two">
                <div class="panel">
                    <div class="panel-header">
                        <div>
                            <h2 class="panel-title">Phân công lịch mới</h2>
                            <p class="panel-text">Tạo chuyến đi nhanh cho ngày làm việc.</p>
                        </div>
                    </div>
                    <form action="staff-dashboard" method="post" class="app-form">
                        <input type="hidden" name="action" value="addSchedule">
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
                                <label class="form-label">Ngày chạy</label>
                                <input type="date" name="date" class="form-control" required>
                            </div>
                            <div class="col-12">
                                <button type="submit" class="btn btn-primary w-100">Xác nhận phân công</button>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="panel">
                    <div class="panel-header">
                        <div>
                            <h2 class="panel-title">Trạng thái vận hành</h2>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>Tuyến</th>
                                    <th>Xe</th>
                                    <th>Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${listS}" var="s" end="5">
                                    <tr>
                                        <td><strong>${s.routeNumber}</strong></td>
                                        <td>${s.licensePlate}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${s.status == 'SCHEDULED'}"><span class="badge bg-secondary">Chờ chạy</span></c:when>
                                                <c:when test="${s.status == 'DEPARTED'}"><span class="badge bg-primary">Đang chạy</span></c:when>
                                                <c:when test="${s.status == 'ARRIVED'}"><span class="badge bg-success">Đã đến</span></c:when>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="mt-3">
                        <a href="${pageContext.request.contextPath}/manage-schedules" class="btn btn-sm btn-outline-light w-100">Chi tiết lịch trình</a>
                    </div>
                </div>
            </section>
        </main>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
