<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông báo - Hanoi Bus</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/app.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark app-navbar">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/index.html">Hanoi Bus</a>
            <div class="ms-auto">
                <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/tim-tuyen">Về trang chủ</a>
            </div>
        </div>
    </nav>

    <main class="page-wrap">
        <section class="hero">
            <div class="hero-layout">
                <div class="hero-copy">
                    <span class="pill">Trung tâm thông báo</span>
                    <h1>Thông báo cá nhân và cập nhật hệ thống tại một nơi.</h1>
                    <p>
                        Các thông báo mới sẽ hiển thị ở đây để người dùng không bỏ lỡ tình trạng vé, chuyến và thay đổi vận hành.
                    </p>
                </div>
                <div class="hero-side">
                    <div class="panel">
                        <div class="status-chip">Thông báo vé</div>
                        <div class="status-chip" style="margin-top: 10px;">Cập nhật chuyến xe</div>
                        <div class="status-chip" style="margin-top: 10px;">Nhắc việc hệ thống</div>
                    </div>
                </div>
            </div>
        </section>

        <section class="panel" style="margin-top: 22px;">
            <div class="stack">
                <c:forEach items="${notificationList}" var="n">
                    <div class="list-group-item rounded-4">
                        <div class="d-flex justify-content-between align-items-start gap-3">
                            <div>
                                <h3 class="panel-title" style="font-size: 1.05rem;">${n.title}</h3>
                                <p class="panel-text mb-0">${n.message}</p>
                            </div>
                            <span class="status-chip">${n.createdAt}</span>
                        </div>
                        <div class="mt-3">
                            <span class="pill">${n.notificationType}</span>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>

        <c:if test="${empty notificationList}">
            <div class="panel" style="margin-top: 22px;">
                <div class="empty-state">Chưa có thông báo mới.</div>
            </div>
        </c:if>
    </main>
</body>
</html>
