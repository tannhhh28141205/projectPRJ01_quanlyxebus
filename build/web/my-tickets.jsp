<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vé của tôi - Hanoi Bus</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/app.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark app-navbar">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/index.html">Hanoi Bus</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#ticketNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="ticketNav">
                <ul class="navbar-nav me-auto gap-lg-1">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/tim-tuyen">Tra cứu tuyến</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/mua-ve">Mua vé</a></li>
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/ve-cua-toi">Vé của tôi</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <main class="page-wrap">
        <section class="hero">
            <div class="hero-layout">
                <div class="hero-copy">
                    <span class="pill">Lịch sử vé</span>
                    <h1>Theo dõi mọi vé đã đăng ký và trạng thái thanh toán.</h1>
                    <p>
                        Màn hình này tổng hợp vé lượt, vé tháng, đối tượng ưu tiên và thời hạn sử dụng để bạn kiểm tra nhanh.
                    </p>
                </div>
                <div class="hero-side">
                    <div class="panel">
                        <div class="status-chip">Vé đã thanh toán</div>
                        <div class="status-chip" style="margin-top: 10px;">Vé chờ thanh toán</div>
                        <div class="status-chip" style="margin-top: 10px;">Hạn dùng & lộ trình</div>
                    </div>
                </div>
            </div>
        </section>

        <section class="panel" style="margin-top: 22px;">
            <div class="panel-header">
                <div>
                    <h2 class="panel-title">Lịch sử đăng ký vé</h2>
                    <p class="panel-text">Danh sách các vé bạn đã tạo trong hệ thống.</p>
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th>Mã vé</th>
                            <th>Tuyến</th>
                            <th>Loại vé</th>
                            <th>Đối tượng</th>
                            <th>Giá vé</th>
                            <th>Ngày đăng ký</th>
                            <th>Hạn dùng</th>
                            <th>Thanh toán</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listT}" var="t">
                            <tr>
                                <td><strong>#${t.ticketID}</strong></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty t.routeNumber}">
                                            <span class="badge bg-primary">Tuyến ${t.routeNumber}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">Liên tuyến</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${t.ticketType}</td>
                                <td>${t.category}</td>
                                <td>${t.price} VNĐ</td>
                                <td>${t.issueDate}</td>
                                <td>${t.expiryDate}</td>
                                <td>
                                    <c:if test="${t.isPaid}">
                                        <span class="badge bg-success">Đã thanh toán</span>
                                    </c:if>
                                    <c:if test="${!t.isPaid}">
                                        <span class="badge bg-danger">Chờ thanh toán</span>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <c:if test="${empty listT}">
                <div class="empty-state mt-3">Bạn chưa đăng ký vé nào.</div>
            </c:if>
        </section>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
