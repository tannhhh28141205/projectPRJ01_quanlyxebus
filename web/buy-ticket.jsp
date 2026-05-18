<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mua vé - Hanoi Bus</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/app.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark app-navbar">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/index.html">Hanoi Bus</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#buyNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="buyNav">
                <ul class="navbar-nav me-auto gap-lg-1">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/tim-tuyen">Tra cứu tuyến</a></li>
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/mua-ve">Mua vé</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/ve-cua-toi">Vé của tôi</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <main class="page-wrap">
        <section class="grid-two">
            <div class="panel">
                <div class="panel-header">
                    <div>
                        <span class="pill">Đăng ký vé</span>
                        <h1 class="section-title mt-3">Chọn loại vé phù hợp với nhu cầu di chuyển.</h1>
                        <p class="section-subtitle">Hỗ trợ vé lượt, vé tháng 1 tuyến và vé tháng liên tuyến.</p>
                    </div>
                </div>

                <c:if test="${not empty mess}">
                    <div class="alert alert-success">${mess}</div>
                </c:if>

                <form action="mua-ve" method="post" class="app-form">
                    <div class="mb-3">
                        <label class="form-label">Loại vé</label>
                        <select name="type" class="form-select" id="ticketType" onchange="toggleRoute()" required>
                            <option value="SINGLE">Vé lượt (7.000đ)</option>
                            <option value="MONTHLY_ONE">Vé tháng 1 tuyến (100.000đ)</option>
                            <option value="MONTHLY_ALL">Vé tháng liên tuyến (200.000đ)</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Đối tượng</label>
                        <select name="category" class="form-select" required>
                            <option value="NORMAL">Bình thường</option>
                            <option value="STUDENT">Học sinh, sinh viên (giảm 50%)</option>
                            <option value="SENIOR">Người cao tuổi (giảm 50%)</option>
                        </select>
                    </div>
                    <div class="mb-4" id="routeSelect" style="display: none;">
                        <label class="form-label">Chọn tuyến cho vé 1 tuyến</label>
                        <select name="routeID" class="form-select">
                            <c:forEach items="${listR}" var="r">
                                <option value="${r.routeID}">${r.routeNumber} - ${r.routeName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-danger w-100">Xác nhận đăng ký</button>
                </form>
            </div>

            <div class="panel">
                <div class="panel-header">
                    <div>
                        <span class="pill">Hướng dẫn</span>
                        <h2 class="panel-title mt-3">Gợi ý chọn vé</h2>
                        <p class="panel-text">Các lựa chọn dưới đây giúp hành khách dễ chọn nhanh hơn.</p>
                    </div>
                </div>
                <div class="stack">
                    <div class="status-chip">Vé lượt cho chuyến đi đơn lẻ</div>
                    <div class="status-chip">Vé tháng 1 tuyến cho người đi cố định</div>
                    <div class="status-chip">Vé tháng liên tuyến cho nhu cầu linh hoạt</div>
                    <div class="status-chip">Hỗ trợ giảm giá theo đối tượng</div>
                </div>
            </div>
        </section>
    </main>

    <script>
        function toggleRoute() {
            var type = document.getElementById("ticketType").value;
            var routeSelect = document.getElementById("routeSelect");
            routeSelect.style.display = type === "MONTHLY_ONE" ? "block" : "none";
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
