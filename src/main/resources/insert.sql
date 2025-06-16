USE `techstore`;

-- Insert categories first
INSERT INTO `category` (`name`, `description`) VALUES
('Laptop', 'Máy tính xách tay'),
('Điện thoại', 'Điện thoại thông minh'),
('Máy tính bảng', 'Máy tính bảng'),
('PC', 'Máy tính để bàn'),
('Tai nghe', 'Tai nghe và phụ kiện âm thanh'),
('Loa', 'Loa và thiết bị âm thanh'),
('Tivi', 'Tivi và màn hình');

-- Insert users
INSERT INTO `users` (`email`, `username`, `phone_numbers`, `full_name`, `password`, `dob`, `gender`, `role`, `access`, `verified`) 
VALUES
('phuoc@gmail.com', 'phuoc', '0986216717', 'Nguyễn Hữu Phước', '$2a$10$eTGx/4wZN/msl9YhNfx0ne2rY3I5UI3TI4KlmxBiPRsyNTcvI4WVW', '2003-02-17', 'nam', 'USER', 'ACTIVE', 1),
('admin@gmail.com', 'admin', '0986216717', 'admin', '$2a$10$eTGx/4wZN/msl9YhNfx0ne2rY3I5UI3TI4KlmxBiPRsyNTcvI4WVW', '2003-02-17', 'nam', 'ADMIN', 'ACTIVE', 1),
('luu@gmail.com', 'luu', '0866456543', 'Lưu', '$2a$10$eTGx/4wZN/msl9YhNfx0ne2rY3I5UI3TI4KlmxBiPRsyNTcvI4WVW', '2003-01-19', 'nam', 'USER', 'ACTIVE', 1);

-- Insert products
INSERT INTO `products` (`code`, `name`, `description`, `price`, `quantity`, `trademark`, `category_id`) VALUES
('PC001', 'PC PV Home Office I50168', 'CPU Intel Core i5 12400, Mainboard MSI PRO H610M-E DDR4, Ram 2 x 8GB DDR4-3200, SSD WD Green SN350 500GB M.2 2280, PCIE NVME Gen 3x4 (WDS500G2G0C), Power MIK SPOWER 500 (SP005841), Case MIK Phong Vu Office', 20000000, 999, 'Phong Vũ', 4),
('PC002', 'PC PV Gaming Hades H002', 'CPU Intel Core Ultra 9 285K Mainboard MSI MEG Z890 ACE RAM Teamgroup Xtreem ARGB Black 2x24GB DDR5-8000 SSD MSI SPATIUM M480 PCIe 4.0 NVMe M.2 1TB VGA MSI RTX 5080 16G GAMING TRIO OC 16GB GDDR7 PSU MSI MAG A1250GL PCIE5 Tản nhiệt nước MSI MAG CORELIQUID I360 Case MSI MEG PROSPECT 700R', 24000000, 999, 'Phong Vũ', 4),
('PHN001', 'TCL 60R 5G 4GB 128GB', 'TCL 60R 5G là lựa chọn lý tưởng cho những ai đang tìm kiếm một chiếc smartphone 5G hiện đại, có thiết kế nổi bật và hiệu năng ổn định trong tầm giá.', 24000000, 999, 'TCL', 2),
('PHN002', 'Xiaomi Poco M7 Pro 5G 8GB 256GB', 'POCO M7 Pro 5G không đơn thuần là một chiếc điện thoại, mà là một tổ hợp giải trí và làm việc di động, được tinh chỉnh kỹ lưỡng từ hiệu năng, pin, màn hình hiển thị cho đến camera và hệ thống âm thanh.', 24000000, 999, 'Xiaomi', 2),
('PHN003', 'iPhone 16 Pro Max 256GB', 'iPhone 16 series với 4 phiên bản: iPhone 16, iPhone 16 Plus, iPhone 16 Pro và iPhone 16 Pro Max đều có sự nâng cấp đáng kể.', 24000000, 999, 'Apple', 2),
('LAP001', 'Macbook Air 13 M4 2025', 'Về kiểu dáng, MacBook Air M4 vẫn giữ nguyên ngôn ngữ thiết kế tinh tế đặc trưng của Apple nhưng nổi bật hơn với độ mỏng chỉ 1,13 cm và trọng lượng khoảng 1,24 kg.', 24000000, 999, 'Apple', 1),
('LAP002', 'Laptop Lenovo IdeaPad Slim 3', 'Dòng Ideapad của Lenovo từ lâu đã khẳng định vị thế của mình trong lĩnh vực laptop văn phòng nhờ sự ổn định, độ bền cao và thiết kế tinh tế.', 24000000, 999, 'Lenovo', 1),
('LAP003', 'Laptop Asus Vivobook S14', 'Mảnh mai, thời trang và mạnh mẽ, Vivobook S14 là cộng sự đáng tin cậy cho giới văn phòng, học sinh/sinh viên và những người thường xuyên công tác xa nhà.', 24000000, 999, 'Asus', 1),
('TAB001', 'iPad A16 WiFi 128GB', 'iPad Gen 11 đánh dấu bước tiến lớn trong dòng iPad của Apple. Sản phẩm sở hữu sức mạnh vượt trội nhờ chip A16 Bionic.', 24000000, 999, 'Apple', 3),
('TAB002', 'Xiaomi Pad 7 WiFi 8GB 128GB', 'Xiaomi Pad 7 là sự kết hợp hoàn hảo giữa thiết kế tinh tế, hiệu suất mạnh mẽ và trải nghiệm người dùng thông minh.', 24000000, 999, 'Xiaomi', 3);

-- Insert sample purchases
INSERT INTO `purchases` (`purchaseID`, `email`, `productID`, `quantity`, `total_price`, `price`, `status`, `purchase_date`, `order_date`, `shipping_address`, `payment_method`) VALUES
-- Pending orders (status = 0)
(1, 'phuoc@gmail.com', 1, 1, 20000000, 20000000, 0, '2024-03-15 10:30:00', '2024-03-15 10:30:00', '123 Đường ABC, Quận 1, TP.HCM', 'COD'),
(2, 'luu@gmail.com', 3, 2, 48000000, 24000000, 0, '2024-03-15 11:45:00', '2024-03-15 11:45:00', '456 Đường XYZ, Quận 2, TP.HCM', 'COD'),

-- Confirmed orders (status = 1)
(3, 'phuoc@gmail.com', 6, 1, 24000000, 24000000, 1, '2024-03-14 09:15:00', '2024-03-14 09:15:00', '789 Đường DEF, Quận 3, TP.HCM', 'BANKING'),
(4, 'luu@gmail.com', 9, 1, 24000000, 24000000, 1, '2024-03-14 14:20:00', '2024-03-14 14:20:00', '321 Đường GHI, Quận 4, TP.HCM', 'BANKING'),

-- Shipping orders (status = 2)
(5, 'phuoc@gmail.com', 4, 1, 24000000, 24000000, 2, '2024-03-13 16:40:00', '2024-03-13 16:40:00', '654 Đường JKL, Quận 5, TP.HCM', 'MOMO'),
(6, 'luu@gmail.com', 7, 1, 24000000, 24000000, 2, '2024-03-13 17:55:00', '2024-03-13 17:55:00', '987 Đường MNO, Quận 6, TP.HCM', 'MOMO'),

-- Completed orders (status = 3)
(7, 'phuoc@gmail.com', 2, 1, 24000000, 24000000, 3, '2024-03-12 08:30:00', '2024-03-12 08:30:00', '147 Đường PQR, Quận 7, TP.HCM', 'BANKING'),
(8, 'luu@gmail.com', 5, 1, 24000000, 24000000, 3, '2024-03-12 13:45:00', '2024-03-12 13:45:00', '258 Đường STU, Quận 8, TP.HCM', 'BANKING'),

-- Cancelled orders (status = 4)
(9, 'phuoc@gmail.com', 10, 1, 24000000, 24000000, 4, '2024-03-11 15:20:00', '2024-03-11 15:20:00', '369 Đường VWX, Quận 9, TP.HCM', 'COD'),
(10, 'luu@gmail.com', 8, 1, 24000000, 24000000, 4, '2024-03-11 16:35:00', '2024-03-11 16:35:00', '741 Đường YZ, Quận 10, TP.HCM', 'COD'); 