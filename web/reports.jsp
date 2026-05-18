<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Báo cáo - Hanoi Bus</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/app.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark app-navbar">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/index.html">Hanoi Bus Stats</a>
            <div class="ms-auto">
                <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
            </div>
        </div>
    </nav>

    <main class="page-wrap">
        <section class="hero">
            <div class="hero-layout">
                <div class="hero-copy">
                    <span class="pill">Thống kê hệ thống</span>
                    <h1>Báo cáo doanh thu và trạng thái chuyến rõ ràng hơn.</h1>
                    <p>
                        Dashboard báo cáo tập trung vào số liệu có ý nghĩa: doanh thu, chuyến đã hoàn thành và chuyến đang chạy.
                    </p>
                </div>
                <div class="hero-side">
                    <div class="panel">
                        <div class="status-chip">Doanh thu</div>
                        <div class="status-chip" style="margin-top: 10px;">Chuyến hoàn thành</div>
                        <div class="status-chip" style="margin-top: 10px;">Chuyến đang chạy</div>
                    </div>
                </div>
            </div>
        </section>

        <section class="metric-grid" style="margin-top: 22px;">
            <div class="metric-card">
                <div class="metric-label">Tổng doanh thu</div>
                <p class="metric-value">${totalRevenue}</p>
                <p class="metric-note">Dựa trên các vé đã thanh toán</p>
            </div>
            <div class="metric-card">
                <div class="metric-label">Chuyến đã hoàn thành</div>
                <p class="metric-value">${tripStats['ARRIVED'] != null ? tripStats['ARRIVED'] : 0}</p>
                <p class="metric-note">Tổng số chuyến kết thúc thành công</p>
            </div>
            <div class="metric-card">
                <div class="metric-label">Chuyến đang chạy</div>
                <p class="metric-value">${tripStats['DEPARTED'] != null ? tripStats['DEPARTED'] : 0}</p>
                <p class="metric-note">Theo dõi vận hành theo thời gian thực</p>
            </div>
            <div class="metric-card">
                <div class="metric-label">Tổng chuyến</div>
                <p class="metric-value">${tripStats['SCHEDULED'] != null ? tripStats['SCHEDULED'] : 0}</p>
                <p class="metric-note">Các chuyến đã lên lịch</p>
            </div>
        </section>

        <section class="grid-two" style="margin-top: 22px;">
            <div class="panel">
                <div class="panel-header">
                    <div>
                        <h2 class="panel-title">Doanh thu theo đối tượng</h2>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th>Đối tượng</th>
                                <th>Số tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${revCat}" var="entry">
                                <tr>
                                    <td>${entry.key}</td>
                                    <td><strong>${entry.value}</strong></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="panel">
                <div class="panel-header">
                    <div>
                        <h2 class="panel-title">Top tuyến phổ biến</h2>
                        <p class="panel-text">Dựa trên số lượng vé đã bán.</p>
                    </div>
                </div>
                <div class="stack">
                    <c:forEach items="${popRoutes}" var="entry">
                        <div class="list-group-item rounded-4 d-flex justify-content-between align-items-center">
                            <span>Tuyến số ${entry.key}</span>
                            <span class="badge bg-danger rounded-pill">${entry.value} vé</span>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
    </main>
</body>
</html>
