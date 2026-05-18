<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tìm tuyến - Hanoi Bus</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/app.css">
    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin=""/>
    <style>
        #map { height: 450px; width: 100%; border-radius: 14px; z-index: 1; }
        .leaflet-popup-content-wrapper { background: var(--bg-2); color: var(--text-main); border: 1px solid var(--line); }
        .leaflet-popup-tip { background: var(--bg-2); }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark app-navbar">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/index.html">Hanoi Bus</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto gap-lg-1">
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/tim-tuyen">Tra cứu tuyến</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/mua-ve">Mua vé</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/tin-tuc">Tin tức</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/thong-bao">Thông báo</a></li>
                </ul>
                <ul class="navbar-nav gap-lg-1">
                    <c:choose>
                        <c:when test="${sessionScope.acc != null}">
                            <li class="nav-item"><span class="nav-link">Xin chào, ${sessionScope.acc.fullName}</span></li>
                            <li class="nav-item"><a class="nav-link text-warning" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login">Đăng nhập</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <main class="page-wrap">
        <section class="hero">
            <div class="hero-layout">
                <div class="hero-copy">
                    <span class="pill">Tra cứu thông minh</span>
                    <h1>Tìm tuyến xe và trạm dừng nhanh chóng.</h1>
                    <p>
                        Chọn điểm đi và điểm đến để xem các tuyến phù hợp cùng bản đồ lộ trình chi tiết.
                    </p>
                </div>
                <div class="hero-side">
                    <div class="panel">
                        <p class="metric-label">Hanoi Bus Maps</p>
                        <h3 class="panel-title">Lộ trình trực quan</h3>
                        <p class="panel-text">Hiển thị trạm dừng và đường đi trên bản đồ số.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="grid-two" style="margin-top: 22px;">
            <div class="panel">
                <div class="panel-header">
                    <div>
                        <h2 class="panel-title">Tìm tuyến qua 2 trạm</h2>
                        <p class="panel-text">Chọn đúng trạm để tìm các tuyến đi qua cả hai điểm.</p>
                    </div>
                </div>
                <form action="tim-tuyen" method="post" class="app-form">
                    <div class="row g-3">
                        <div class="col-md-5">
                            <label class="form-label">Điểm bắt đầu</label>
                            <select name="startStation" class="form-select" required>
                                <option value="">-- Chọn trạm đi --</option>
                                <c:forEach items="${listS}" var="s">
                                    <option value="${s.stationID}" ${param.startStation == s.stationID ? 'selected' : ''}>${s.stationName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-5">
                            <label class="form-label">Điểm kết thúc</label>
                            <select name="endStation" class="form-select" required>
                                <option value="">-- Chọn trạm đến --</option>
                                <c:forEach items="${listS}" var="s">
                                    <option value="${s.stationID}" ${param.endStation == s.stationID ? 'selected' : ''}>${s.stationName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-2 d-flex align-items-end">
                            <button type="submit" class="btn btn-primary w-100">Tìm</button>
                        </div>
                    </div>
                </form>
            </div>

            <div class="panel">
                <div class="panel-header">
                    <div>
                        <h2 class="panel-title">Gợi ý nhanh</h2>
                        <p class="panel-text">Tra cứu xong bạn có thể xem lộ trình trên bản đồ.</p>
                    </div>
                </div>
                <div class="stack">
                    <div class="status-chip">Chọn tuyến để xem danh sách trạm</div>
                    <div class="status-chip">Nhấn "Xem bản đồ" để xem lộ trình</div>
                </div>
            </div>
        </section>

        <c:if test="${not empty routeList}">
            <section class="panel" style="margin-top: 22px;">
                <div class="panel-header">
                    <div>
                        <h2 class="panel-title">Kết quả tìm kiếm</h2>
                        <p class="panel-text">Các tuyến đi qua hai trạm bạn đã chọn.</p>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th>Số hiệu</th>
                                <th>Tên tuyến</th>
                                <th>Giá vé</th>
                                <th>Tần suất</th>
                                <th>Lộ trình</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${routeList}" var="r">
                                <tr>
                                    <td><span class="badge" style="background-color: ${r.colorCode != null ? r.colorCode : '#ff4757'}">${r.routeNumber}</span></td>
                                    <td><strong>${r.routeName}</strong></td>
                                    <td>${r.baseFare} đ</td>
                                    <td>${r.frequency} phút</td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-info" onclick="showMap(${r.routeID}, '${r.routeNumber} - ${r.routeName}')">
                                            <i class="bi bi-map"></i> Xem bản đồ
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </section>
        </c:if>
    </main>

    <!-- Map Modal -->
    <div class="modal fade" id="mapModal" tabindex="-1">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-0">
                    <h5 class="modal-title" id="mapModalTitle">Lộ trình tuyến xe</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-0">
                    <div id="map"></div>
                    <div class="p-3">
                        <h6 class="mb-2">Danh sách các trạm dừng:</h6>
                        <div id="stationList" class="d-flex flex-wrap gap-2">
                            <!-- Stations will be listed here -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Leaflet JS -->
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        let map;
        let markers = [];
        let polyline;

        function initMap() {
            if (!map) {
                map = L.map('map').setView([21.0285, 105.8542], 13); // Hà Nội
                L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                    attribution: '© OpenStreetMap contributors'
                }).addTo(map);
            }
        }

        function showMap(routeID, title) {
            document.getElementById('mapModalTitle').innerText = 'Lộ trình: ' + title;
            const modal = new bootstrap.Modal(document.getElementById('mapModal'));
            modal.show();

            // Delay map initialization until modal is shown
            setTimeout(() => {
                initMap();
                fetchStations(routeID);
            }, 300);
        }

        function fetchStations(routeID) {
            fetch('get-route-stations?routeID=' + routeID)
                .then(response => response.json())
                .then(data => {
                    renderStations(data);
                })
                .catch(err => console.error('Error fetching stations:', err));
        }

        function renderStations(stations) {
            // Clear old markers and lines
            markers.forEach(m => map.removeLayer(m));
            markers = [];
            if (polyline) map.removeLayer(polyline);

            const stationDiv = document.getElementById('stationList');
            stationDiv.innerHTML = '';

            const latlngs = [];

            stations.forEach((s, index) => {
                const pos = [s.latitude, s.longitude];
                latlngs.push(pos);

                // Add marker
                const marker = L.marker(pos).addTo(map)
                    .bindPopup(`<b>${index + 1}. ${s.stationName}</b>`);
                markers.push(marker);

                // Add to list
                const chip = document.createElement('span');
                chip.className = 'status-chip';
                chip.innerText = (index + 1) + '. ' + s.stationName;
                stationDiv.appendChild(chip);
            });

            // Draw route line
            if (latlngs.length > 0) {
                polyline = L.polyline(latlngs, {color: '#3dd6c6', weight: 4}).addTo(map);
                map.fitBounds(polyline.getBounds());
            }
        }
    </script>
</body>
</html>
