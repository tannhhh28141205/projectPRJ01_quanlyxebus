<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tin tức - Hanoi Bus</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/app.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark app-navbar">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/index.html">Hanoi Bus</a>
            <div class="ms-auto">
                <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/tim-tuyen">Về trang tìm tuyến</a>
            </div>
        </div>
    </nav>

    <main class="page-wrap">
        <section class="hero">
            <div class="hero-layout">
                <div class="hero-copy">
                    <span class="pill">Bản tin hệ thống</span>
                    <h1>Tin tức và thông báo vận hành cập nhật theo thời gian.</h1>
                    <p>
                        Theo dõi các thay đổi tuyến, lịch bảo trì, chính sách vé và sự kiện hệ thống ngay trong một trang.
                    </p>
                </div>
                <div class="hero-side">
                    <div class="panel">
                        <div class="status-chip">Cập nhật điều hành</div>
                        <div class="status-chip" style="margin-top: 10px;">Thông tin dành cho hành khách</div>
                        <div class="status-chip" style="margin-top: 10px;">Bản tin và sự kiện hệ thống</div>
                    </div>
                </div>
            </div>
        </section>

        <section class="grid-two" style="margin-top: 22px;">
            <c:forEach items="${newsList}" var="n">
                <article class="panel">
                    <div class="d-flex justify-content-between align-items-start gap-3">
                        <div>
                            <span class="pill">${n.category}</span>
                            <h2 class="panel-title mt-3">${n.title}</h2>
                        </div>
                        <span class="status-chip">${n.createdAt}</span>
                    </div>
                    <p class="panel-text mt-3">${n.content}</p>
                    <div class="d-flex justify-content-between align-items-center mt-4">
                        <span class="status-chip">Tác giả: ${n.authorName}</span>
                        <span class="status-chip">Lượt xem: ${n.viewCount}</span>
                    </div>
                </article>
            </c:forEach>
        </section>

        <c:if test="${empty newsList}">
            <div class="panel" style="margin-top: 22px;">
                <div class="empty-state">Chưa có tin tức nào được đăng.</div>
            </div>
        </c:if>
    </main>
</body>
</html>
