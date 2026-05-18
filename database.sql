-- =======================================================
-- TẠO DATABASE: HanoiBusDB (BẢN HOÀN CHỈNH)
-- =======================================================
CREATE DATABASE HanoiBusDB;
GO

USE HanoiBusDB;
GO

-- =======================================================
-- PHẦN 1: TẠO CẤU TRÚC BẢNG (TABLES)
-- =======================================================

CREATE TABLE Roles (
    roleID INT IDENTITY(1,1) PRIMARY KEY,
    roleCode VARCHAR(20) NOT NULL UNIQUE,
    roleName NVARCHAR(100) NOT NULL,
    description NVARCHAR(255)
);

CREATE TABLE Users (
    userID INT IDENTITY(1,1) PRIMARY KEY,
    roleID INT NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    passwordHash VARCHAR(255) NOT NULL,
    fullName NVARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phoneNumber VARCHAR(15) UNIQUE,
    dateOfBirth DATE,
    gender VARCHAR(10) CHECK (gender IN ('MALE', 'FEMALE', 'OTHER')),
    address NVARCHAR(255),
    avatarUrl VARCHAR(255),
    lastLogin DATETIME,
    isActive BIT DEFAULT 1,
    createdAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (roleID) REFERENCES Roles(roleID)
);

CREATE TABLE Wallets (
    walletID INT IDENTITY(1,1) PRIMARY KEY,
    userID INT UNIQUE NOT NULL,
    balance DECIMAL(18,2) DEFAULT 0.00,
    currency VARCHAR(10) DEFAULT 'VND',
    lastUpdated DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (userID) REFERENCES Users(userID)
);

CREATE TABLE Transactions (
    transactionID INT IDENTITY(1,1) PRIMARY KEY,
    walletID INT NOT NULL,
    amount DECIMAL(18,2) NOT NULL,
    transactionType VARCHAR(20) CHECK (transactionType IN ('DEPOSIT', 'WITHDRAW', 'PAYMENT', 'REFUND')),
    paymentMethod VARCHAR(50) CHECK (paymentMethod IN ('VNPAY', 'MOMO', 'ZALOPAY', 'BANK_TRANSFER', 'SYSTEM')),
    referenceCode VARCHAR(100) UNIQUE,
    status VARCHAR(20) DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'SUCCESS', 'FAILED', 'CANCELLED')),
    description NVARCHAR(255),
    createdAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (walletID) REFERENCES Wallets(walletID)
);

CREATE TABLE Stations (
    stationID INT IDENTITY(1,1) PRIMARY KEY,
    stationCode VARCHAR(20) UNIQUE NOT NULL,
    stationName NVARCHAR(255) NOT NULL,
    address NVARCHAR(255),
    ward NVARCHAR(50),
    district NVARCHAR(50),
    latitude DECIMAL(10, 8) NOT NULL,
    longitude DECIMAL(11, 8) NOT NULL,
    hasShelter BIT DEFAULT 0,
    hasLedBoard BIT DEFAULT 0,
    isActive BIT DEFAULT 1
);

CREATE TABLE Routes (
    routeID INT IDENTITY(1,1) PRIMARY KEY,
    routeNumber VARCHAR(10) NOT NULL UNIQUE,
    routeName NVARCHAR(255) NOT NULL,
    routeType VARCHAR(20) DEFAULT 'CITY' CHECK (routeType IN ('CITY', 'SUBURBAN', 'AIRPORT', 'BRT')),
    startTime TIME NOT NULL,
    endTime TIME NOT NULL,
    frequencyMin INT NOT NULL,
    distanceKM DECIMAL(5,2),
    durationMin INT,
    baseFare DECIMAL(10,2) NOT NULL,
    colorCode VARCHAR(10) DEFAULT '#00529C',
    polylinePoints NVARCHAR(MAX),
    isActive BIT DEFAULT 1
);

CREATE TABLE Route_Stations (
    routeID INT NOT NULL,
    stationID INT NOT NULL,
    direction VARCHAR(10) NOT NULL CHECK (direction IN ('OUTBOUND', 'INBOUND')),
    stopOrder INT NOT NULL,
    distanceToNextKM DECIMAL(5,2),
    timeOffsetMin INT,
    PRIMARY KEY (routeID, stationID, direction),
    FOREIGN KEY (routeID) REFERENCES Routes(routeID),
    FOREIGN KEY (stationID) REFERENCES Stations(stationID)
);

CREATE TABLE Buses (
    busID INT IDENTITY(1,1) PRIMARY KEY,
    licensePlate VARCHAR(20) NOT NULL UNIQUE,
    fleetNumber VARCHAR(20) UNIQUE,
    capacitySeats INT NOT NULL,
    capacityStanding INT NOT NULL,
    busType VARCHAR(20) DEFAULT 'DIESEL' CHECK (busType IN ('DIESEL', 'CNG', 'EV')),
    brand VARCHAR(50),
    manufactureYear INT,
    lastMaintenanceDate DATE,
    status VARCHAR(20) DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE', 'MAINTENANCE', 'BROKEN', 'RETIRED'))
);

CREATE TABLE Maintenance_History (
    maintenanceID INT IDENTITY(1,1) PRIMARY KEY,
    busID INT NOT NULL,
    maintenanceDate DATE NOT NULL,
    maintenanceType VARCHAR(50) CHECK (maintenanceType IN ('ROUTINE', 'REPAIR', 'INSPECTION')),
    description NVARCHAR(MAX) NOT NULL,
    cost DECIMAL(18,2) DEFAULT 0,
    technicianName NVARCHAR(100),
    nextDueDate DATE,
    FOREIGN KEY (busID) REFERENCES Buses(busID)
);

CREATE TABLE Trips (
    tripID INT IDENTITY(1,1) PRIMARY KEY,
    routeID INT NOT NULL,
    busID INT NOT NULL,
    driverID INT NOT NULL,
    assistantID INT,
    direction VARCHAR(10) NOT NULL CHECK (direction IN ('OUTBOUND', 'INBOUND')),
    tripDate DATE NOT NULL,
    plannedStartTime DATETIME NOT NULL,
    plannedEndTime DATETIME,
    actualStartTime DATETIME,
    actualEndTime DATETIME,
    status VARCHAR(20) DEFAULT 'SCHEDULED' 
    CHECK (status IN ('SCHEDULED', 'DEPARTED', 'ARRIVED', 'DELAYED', 'CANCELLED')),
    notes NVARCHAR(255),
    FOREIGN KEY (routeID) REFERENCES Routes(routeID),
    FOREIGN KEY (busID) REFERENCES Buses(busID),
    FOREIGN KEY (driverID) REFERENCES Users(userID),
    FOREIGN KEY (assistantID) REFERENCES Users(userID)
);

CREATE TABLE Trip_Logs (
    logID BIGINT IDENTITY(1,1) PRIMARY KEY,
    tripID INT NOT NULL,
    logTime DATETIME DEFAULT GETDATE(),
    latitude DECIMAL(10, 8) NOT NULL,
    longitude DECIMAL(11, 8) NOT NULL,
    currentSpeed DECIMAL(5,2),
    eventType VARCHAR(50) CHECK (eventType IN ('MOVING', 'STOPPED', 'DOOR_OPEN', 'DOOR_CLOSED', 'OVERSPEED')),
    FOREIGN KEY (tripID) REFERENCES Trips(tripID)
);

CREATE TABLE Tickets (
    ticketID INT IDENTITY(1,1) PRIMARY KEY,
    ticketCode VARCHAR(50) UNIQUE NOT NULL,
    customerID INT NOT NULL,
    routeID INT,
    transactionID INT,
    ticketType VARCHAR(20) NOT NULL CHECK (ticketType IN ('SINGLE', 'DAY_PASS', 'MONTHLY_ONE', 'MONTHLY_ALL')),
    passengerCategory VARCHAR(20) NOT NULL CHECK (passengerCategory IN ('STUDENT', 'WORKER', 'SENIOR', 'NORMAL')),
    price DECIMAL(10,2) NOT NULL,
    validFrom DATETIME NOT NULL,
    validTo DATETIME NOT NULL,
    qrCodeString VARCHAR(255) UNIQUE,
    status VARCHAR(20) DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE', 'USED', 'EXPIRED', 'CANCELLED')),
    createdAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (customerID) REFERENCES Users(userID),
    FOREIGN KEY (routeID) REFERENCES Routes(routeID),
    FOREIGN KEY (transactionID) REFERENCES Transactions(transactionID)
);

CREATE TABLE Ticket_Usage_Logs (
    usageID INT IDENTITY(1,1) PRIMARY KEY,
    ticketID INT NOT NULL,
    tripID INT NOT NULL,
    boardedAtStationID INT,
    scanTime DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ticketID) REFERENCES Tickets(ticketID),
    FOREIGN KEY (tripID) REFERENCES Trips(tripID),
    FOREIGN KEY (boardedAtStationID) REFERENCES Stations(stationID)
);

CREATE TABLE News (
    newsID INT IDENTITY(1,1) PRIMARY KEY,
    authorID INT NOT NULL,
    title NVARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    content NVARCHAR(MAX) NOT NULL,
    thumbnailUrl VARCHAR(255),
    category VARCHAR(50) DEFAULT 'NEWS' CHECK (category IN ('NEWS', 'ANNOUNCEMENT', 'ROUTE_UPDATE', 'PROMOTION')),
    viewCount INT DEFAULT 0,
    isPublished BIT DEFAULT 1,
    createdAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (authorID) REFERENCES Users(userID)
);

CREATE TABLE Feedbacks (
    feedbackID INT IDENTITY(1,1) PRIMARY KEY,
    customerID INT NOT NULL,
    tripID INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    feedbackType VARCHAR(50) CHECK (feedbackType IN ('DRIVER_ATTITUDE', 'VEHICLE_QUALITY', 'DELAY', 'OTHER')),
    subject NVARCHAR(255),
    message NVARCHAR(MAX) NOT NULL,
    attachedImages NVARCHAR(MAX),
    replyMessage NVARCHAR(MAX),
    status VARCHAR(20) DEFAULT 'OPEN' CHECK (status IN ('OPEN', 'REVIEWING', 'RESOLVED', 'REJECTED')),
    createdAt DATETIME DEFAULT GETDATE(),
    updatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (customerID) REFERENCES Users(userID),
    FOREIGN KEY (tripID) REFERENCES Trips(tripID)
);

CREATE TABLE Notifications (
    notificationID INT IDENTITY(1,1) PRIMARY KEY,
    userID INT NOT NULL,
    title NVARCHAR(255) NOT NULL,
    message NVARCHAR(MAX) NOT NULL,
    notificationType VARCHAR(50) CHECK (notificationType IN ('SYSTEM', 'PROMOTION', 'TRIP_ALERT', 'TICKET_EXPIRED')),
    isRead BIT DEFAULT 0,
    createdAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (userID) REFERENCES Users(userID)
);
GO

-- =======================================================
-- PHẦN 2: THÊM DỮ LIỆU (DATA)
-- =======================================================

-- 1. Roles
INSERT INTO Roles (roleCode, roleName, description) VALUES
('ADMIN', N'Quản trị viên', N'Quản lý hệ thống'),
('DISPATCHER', N'Điều độ viên', N'Lên lịch xe'),
('DRIVER', N'Tài xế', N'Lái xe buýt'),
('ASSISTANT', N'Phụ xe', N'Soát vé'),
('CUSTOMER', N'Khách hàng', N'Hành khách');

-- 2. Users
INSERT INTO Users (roleID, username, passwordHash, fullName, email, phoneNumber, dateOfBirth, gender, address) VALUES
(1, 'admin', 'hash123', N'Trần Quản Trị', 'admin@hanoibus.vn', '0901000000', '1985-05-15', 'MALE', N'Cầu Giấy, HN'),
(2, 'dieudo1', 'hash123', N'Lê Điều Hành', 'dieudo@hanoibus.vn', '0902000000', '1990-10-20', 'MALE', N'Nam Từ Liêm, HN'),
(3, 'taixe1', 'hash123', N'Nguyễn Văn Lái', 'tx1@hanoibus.vn', '0903000000', '1982-02-12', 'MALE', N'Hà Đông, HN'),
(3, 'taixe2', 'hash123', N'Phạm Bác Tài', 'tx2@hanoibus.vn', '0904000000', '1980-08-08', 'MALE', N'Thanh Xuân, HN'),
(4, 'phuxe1', 'hash123', N'Võ Soát Vé', 'px1@hanoibus.vn', '0905000000', '1995-12-01', 'MALE', N'Đống Đa, HN'),
(4, 'phuxe2', 'hash123', N'Hoàng Lơ Xe', 'px2@hanoibus.vn', '0906000000', '1998-04-18', 'MALE', N'Hoàng Mai, HN'),
(5, 'khach_tuananh', 'hash123', N'Đinh Tuấn Anh', 'tuananh@gmail.com', '0907000000', '2004-09-02', 'MALE', N'Thạch Thất, HN'),
(5, 'khach_loan', 'hash123', N'Trần Loan', 'loan@gmail.com', '0908000000', '2004-11-25', 'FEMALE', N'Hòa Lạc, HN');

-- 3. Wallets & Transactions
INSERT INTO Wallets (userID, balance, currency) VALUES (7, 200000.00, 'VND'), (8, 50000.00, 'VND');

INSERT INTO Transactions (walletID, amount, transactionType, paymentMethod, referenceCode, status) VALUES
(1, 250000.00, 'DEPOSIT', 'VNPAY', 'VN_TXN_001', 'SUCCESS'),
(2, 50000.00, 'DEPOSIT', 'MOMO', 'MM_TXN_001', 'SUCCESS');

-- 4. Stations (ID từ 1 đến 12)
INSERT INTO Stations (stationCode, stationName, address, district, latitude, longitude, hasShelter) VALUES
('S_MYDINH', N'Bến xe Mỹ Đình', N'20 Phạm Hùng', N'Nam Từ Liêm', 21.028511, 105.778153, 1),    -- ID 1
('S_DHQG', N'Đại học Quốc Gia HN', N'144 Xuân Thủy', N'Cầu Giấy', 21.037814, 105.781358, 1),  -- ID 2
('S_NTS', N'Ngã Tư Sở', N'278 Tây Sơn', N'Đống Đa', 21.006245, 105.820847, 0),               -- ID 3
('S_GIAPBAT', N'Bến xe Giáp Bát', N'Giải Phóng', N'Hoàng Mai', 20.980649, 105.841571, 1),    -- ID 4
('S_NHON', N'Bến xe Nhổn', N'Đường 32', N'Bắc Từ Liêm', 21.054321, 105.735123, 1),           -- ID 5
('S_GIALAM', N'Bến xe Gia Lâm', N'Ngô Gia Khảm', N'Long Biên', 21.049444, 105.878333, 1),    -- ID 6
('S_YENNGHIA', N'Bến xe Yên Nghĩa', N'Quốc Lộ 6', N'Hà Đông', 20.950833, 105.748333, 1),     -- ID 7
('S_LONGBIEN', N'Điểm trung chuyển Long Biên', N'Yên Phụ', N'Ba Đình', 21.039823, 105.849151, 1), -- ID 8
('S_BKHN', N'Đại học Bách Khoa HN', N'Đại Cồ Việt', N'Hai Bà Trưng', 21.006543, 105.843123, 0),   -- ID 9
('S_TRANPHU', N'HV Công nghệ Bưu chính', N'Trần Phú', N'Hà Đông', 20.980649, 105.787654, 1),  -- ID 10
('S_BACCO', N'Điểm trung chuyển Bác Cổ', N'Trần Nhật Duật', N'Hoàn Kiếm', 21.026456, 105.859664, 1), -- ID 11
('S_FPT_HOALAC', N'Đại học FPT', N'Khu CNC Hòa Lạc', N'Thạch Thất', 21.012920, 105.527022, 1);    -- ID 12

-- 5. Routes (ID từ 1 đến 7)
INSERT INTO Routes (routeNumber, routeName, routeType, startTime, endTime, frequencyMin, distanceKM, durationMin, baseFare) VALUES
('16', N'Bến xe Mỹ Đình - Bến xe Giáp Bát', 'CITY', '05:00', '21:00', 15, 15.5, 45, 7000),  -- ID 1
('32', N'Bến xe Nhổn - Bến xe Giáp Bát', 'CITY', '05:05', '22:30', 10, 20.0, 60, 7000),     -- ID 2
('01', N'Bến xe Gia Lâm - Bến xe Yên Nghĩa', 'CITY', '05:00', '22:30', 10, 23.5, 75, 7000), -- ID 3
('02', N'Bác Cổ - Bến xe Yên Nghĩa', 'CITY', '05:00', '22:30', 15, 18.2, 60, 7000),         -- ID 4
('21A', N'Bến xe Giáp Bát - Bến xe Yên Nghĩa', 'CITY', '05:00', '21:00', 10, 16.5, 55, 7000),-- ID 5
('26', N'ĐHQG - Sân vận động Quốc Gia', 'CITY', '05:00', '22:30', 12, 19.5, 65, 7000),      -- ID 6
('74', N'Bến xe Mỹ Đình - Xuân Khanh', 'SUBURBAN', '05:00', '20:30', 20, 45.0, 90, 9000);   -- ID 7

-- 6. Route_Stations (Gắn trạm vào tuyến)
INSERT INTO Route_Stations (routeID, stationID, direction, stopOrder) VALUES
-- Tuyến 16: Mỹ Đình(1) -> ĐHQG(2) -> Ngã Tư Sở(3) -> Giáp Bát(4)
(1, 1, 'OUTBOUND', 1), (1, 2, 'OUTBOUND', 2), (1, 3, 'OUTBOUND', 3), (1, 4, 'OUTBOUND', 4),
-- Tuyến 32: Nhổn(5) -> ĐHQG(2) -> Giáp Bát(4)
(2, 5, 'OUTBOUND', 1), (2, 2, 'OUTBOUND', 2), (2, 4, 'OUTBOUND', 3),
-- Tuyến 01: Gia Lâm(6) -> Long Biên(8) -> NTS(3) -> Trần Phú(10) -> Yên Nghĩa(7)
(3, 6, 'OUTBOUND', 1), (3, 8, 'OUTBOUND', 2), (3, 3, 'OUTBOUND', 3), (3, 10, 'OUTBOUND', 4), (3, 7, 'OUTBOUND', 5),
-- Tuyến 02: Bác Cổ(11) -> NTS(3) -> Trần Phú(10) -> Yên Nghĩa(7)
(4, 11, 'OUTBOUND', 1), (4, 3, 'OUTBOUND', 2), (4, 10, 'OUTBOUND', 3), (4, 7, 'OUTBOUND', 4),
-- Tuyến 21A: Giáp Bát(4) -> NTS(3) -> Trần Phú(10) -> Yên Nghĩa(7)
(5, 4, 'OUTBOUND', 1), (5, 3, 'OUTBOUND', 2), (5, 10, 'OUTBOUND', 3), (5, 7, 'OUTBOUND', 4),
-- Tuyến 26: ĐHQG(2) -> NTS(3) -> Bách Khoa(9) -> Giáp Bát(4)
(6, 2, 'OUTBOUND', 1), (6, 3, 'OUTBOUND', 2), (6, 9, 'OUTBOUND', 3), (6, 4, 'OUTBOUND', 4),
-- Tuyến 74: Mỹ Đình(1) -> Đại học FPT Hòa Lạc(12)
(7, 1, 'OUTBOUND', 1), (7, 12, 'OUTBOUND', 2);

-- 7. Buses & Maintenance
INSERT INTO Buses (licensePlate, fleetNumber, capacitySeats, capacityStanding, busType) VALUES
('29B-111.11', '16-01', 30, 30, 'DIESEL'),
('29B-222.22', '32-01', 30, 30, 'CNG'),
('29B-333.33', '01-01', 30, 30, 'DIESEL'),
('29B-444.44', '74-01', 35, 25, 'DIESEL');

INSERT INTO Maintenance_History (busID, maintenanceDate, maintenanceType, description) VALUES
(1, GETDATE(), 'ROUTINE', N'Bảo dưỡng định kỳ 5000km');

-- 8. Trips & Trip_Logs
INSERT INTO Trips (routeID, busID, driverID, assistantID, direction, tripDate, plannedStartTime) VALUES
(7, 4, 3, 5, 'OUTBOUND', CAST(GETDATE() AS DATE), GETDATE()); -- Tuyến 74 đi FPT

INSERT INTO Trip_Logs (tripID, latitude, longitude, currentSpeed, eventType) VALUES
(1, 21.012920, 105.527022, 0, 'STOPPED'); -- Xe đang dừng tại ĐH FPT

-- 9. Tickets & Usage Logs
INSERT INTO Tickets (ticketCode, customerID, routeID, ticketType, passengerCategory, price, validFrom, validTo) VALUES
('TK-MONTH-A1', 7, NULL, 'MONTHLY_ALL', 'STUDENT', 100000.00, GETDATE(), DATEADD(MONTH, 1, GETDATE()));

INSERT INTO Ticket_Usage_Logs (ticketID, tripID, boardedAtStationID) VALUES (1, 1, 1);

-- 10. News, Feedbacks, Notifications
INSERT INTO News (authorID, title, slug, content, category) VALUES
(1, N'Mở tuyến xe buýt mới đến ĐH FPT', 'mo-tuyen-fpt', N'Tuyến 74 chính thức hoạt động phục vụ sinh viên...', 'NEWS');

INSERT INTO Feedbacks (customerID, tripID, rating, feedbackType, subject, message) VALUES
(7, 1, 5, 'DRIVER_ATTITUDE', N'Chuyến đi tốt', N'Bác tài lái xe an toàn.');

INSERT INTO Notifications (userID, title, message, notificationType) VALUES
(7, N'Vé tháng kích hoạt', N'Vé tháng của bạn đã sẵn sàng sử dụng.', 'SYSTEM');
GO