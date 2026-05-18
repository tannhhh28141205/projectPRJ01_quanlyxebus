<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Dashboard - Hanoi Bus</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/app.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark app-navbar">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/index.html">Hanoi Bus Driver</a>
            <div class="ms-auto">
                <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
            </div>
        </div>
    </nav>

    <main class="page-wrap">
        <section class="hero">
            <div class="hero-layout">
                <div class="hero-copy">
                    <span class="pill">Tài xế</span>
                    <h1>Kiểm soát chuyến của bạn rõ ràng và nhanh hơn.</h1>
                    <p>
                        Tài xế có thể xem lịch trình, check-in khi bắt đầu và check-out khi kết thúc chuyến.
                    </p>
                </div>
                <div class="hero-side">
                    <div class="panel">
                        <div class="status-chip">SCHEDULED = Chờ chạy</div>
                        <div class="status-chip" style="margin-top: 10px;">DEPARTED = Đang chạy</div>
                        <div class="status-chip" style="margin-top: 10px;">ARRIVED = Hoàn thành</div>
                    </div>
                </div>
            </div>
        </section>

        <section class="panel" style="margin-top: 22px;">
            <div class="panel-header">
                <div>
                    <h2 class="panel-title">Lịch trình của tôi</h2>
                    <p class="panel-text">Các chuyến được phân công trong hệ thống.</p>
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th>Tuyến</th>
                            <th>Xe (Biển số)</th>
                            <th>Ngày chạy</th>
                            <th>Trạng thái</th>
                            <th>Check-in</th>
                            <th>Check-out</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listS}" var="s">
                            <tr>
                                <td>${s.routeNumber}</td>
                                <td>${s.licensePlate}</td>
                                <td>${s.tripDate}</td>
                                <td>
                                    <c:if test="${s.status == 'SCHEDULED'}"><span class="badge bg-secondary">Chưa bắt đầu</span></c:if>
                                    <c:if test="${s.status == 'DEPARTED'}"><span class="badge bg-primary">Đang chạy</span></c:if>
                                    <c:if test="${s.status == 'ARRIVED'}"><span class="badge bg-success">Hoàn thành</span></c:if>
                                </td>
                                <td>
                                    <c:if test="${s.status == 'SCHEDULED'}">
                                        <a href="driver-dashboard?action=DEPARTED&sid=${s.scheduleID}" class="btn btn-sm btn-primary">Check-in</a>
                                    </c:if>
                                    <c:if test="${s.status != 'SCHEDULED'}">
                                        ${s.actualStartTime}
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${s.status == 'DEPARTED'}">
                                        <a href="driver-dashboard?action=ARRIVED&sid=${s.scheduleID}" class="btn btn-sm btn-danger">Check-out</a>
                                    </c:if>
                                    <c:if test="${s.status == 'ARRIVED'}">
                                        ${s.actualEndTime}
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </section>
    </main>
</body>
</html>
