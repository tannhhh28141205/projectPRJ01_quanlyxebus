<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assistant Dashboard - Hanoi Bus</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/app.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark app-navbar">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/index.html">Hanoi Bus Assistant</a>
            <div class="ms-auto">
                <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
            </div>
        </div>
    </nav>

    <main class="page-wrap">
        <section class="hero">
            <div class="hero-layout">
                <div class="hero-copy">
                    <span class="pill">Phụ xe</span>
                    <h1>Kiểm tra vé và bán vé tại quầy nhanh hơn.</h1>
                    <p>
                        Giao diện tối ưu cho thao tác tại điểm bán: tra cứu vé, xác nhận trạng thái và xuất vé mới.
                    </p>
                </div>
                <div class="hero-side">
                    <div class="panel">
                        <div class="status-chip">Tra cứu vé</div>
                        <div class="status-chip" style="margin-top: 10px;">Bán vé trực tiếp</div>
                        <div class="status-chip" style="margin-top: 10px;">Xác nhận thanh toán</div>
                    </div>
                </div>
            </div>
        </section>

        <section class="grid-two" style="margin-top: 22px;">
            <div class="panel">
                <div class="panel-header">
                    <div>
                        <h2 class="panel-title">Kiểm tra vé hành khách</h2>
                        <p class="panel-text">Nhập mã vé để xem thông tin nhanh.</p>
                    </div>
                </div>
                <form action="assistant-dashboard" method="get" class="app-form">
                    <input type="hidden" name="action" value="checkTicket">
                    <div class="input-group mb-3">
                        <input type="number" name="ticketID" class="form-control" placeholder="Nhập mã vé (Ticket ID)" required>
                        <button class="btn btn-warning" type="submit">Kiểm tra</button>
                    </div>
                </form>

                <c:if test="${not empty foundTicket}">
                    <div class="alert alert-info">
                        <h5>Thông tin vé #${foundTicket.ticketID}</h5>
                        <p>Loại vé: <strong>${foundTicket.ticketType}</strong></p>
                        <p>Đối tượng: <strong>${foundTicket.category}</strong></p>
                        <p>Hạn dùng: <strong>${foundTicket.expiryDate}</strong></p>
                        <p>Trạng thái:
                            <c:if test="${foundTicket.isPaid}"><span class="badge bg-success">Đã thanh toán</span></c:if>
                            <c:if test="${!foundTicket.isPaid}"><span class="badge bg-danger">Chưa thanh toán</span></c:if>
                        </p>
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>
            </div>

            <div class="panel">
                <div class="panel-header">
                    <div>
                        <h2 class="panel-title">Bán vé lẻ trực tiếp</h2>
                        <p class="panel-text">Xuất vé cho khách tại quầy theo tuyến và đối tượng.</p>
                    </div>
                </div>

                <c:if test="${not empty success}">
                    <div class="alert alert-success">${success}</div>
                </c:if>

                <form action="assistant-dashboard" method="post" class="app-form">
                    <input type="hidden" name="action" value="sellTicket">
                    <div class="mb-3">
                        <label class="form-label">Mã khách hàng (customerID)</label>
                        <input type="number" name="customerID" class="form-control" required min="1">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Chọn tuyến</label>
                        <select name="routeID" class="form-select" required>
                            <c:forEach items="${listR}" var="r">
                                <option value="${r.routeID}">${r.routeNumber} - ${r.routeName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-4">
                        <label class="form-label">Đối tượng</label>
                        <select name="category" class="form-select" required>
                            <option value="NORMAL">Bình thường (7.000đ)</option>
                            <option value="STUDENT">Học sinh/Sinh viên (3.500đ)</option>
                            <option value="SENIOR">Người cao tuổi (3.500đ)</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-dark w-100">Xuất vé & Thu tiền</button>
                </form>
            </div>
        </section>
    </main>
</body>
</html>
