USE `techstore`;

INSERT INTO `users` (`email`, `phone_numbers`, `full_name`, `password`, `dob`, `gender`, `role`, `access`)VALUES
                                                                                                              ('phuoc@gmail.com', '0986216717', 'Nguyễn Hữu Phước', '123', '2003-02-17', 'nam', 'true', 'true'),
                                                                                                              ('admin@gmail.com', '0986216717', 'admin', 'admin', '2003-02-17', 'nam', 'true', 'true'),
                                                                                                              ('luu@gmail.com', '0866456543', 'Lưu', '111', '2003-01-19', 'nam', 'false', 'true');

INSERT INTO `category` (`categoryID`, `name`) VALUES
                                                  (1, 'Máy tính'),
                                                  (2, 'Điện thoại'),
                                                  (3, 'Máy tính bảng'),
                                                  (4, 'PC'),
                                                  (5, 'Tai nghe'),
                                                  (6, 'Loa'),
                                                  (7, 'Laptop');

INSERT INTO `products` (`productID`, `categoryID`, `quantity`, `date_added`, `price`, `sale`, `ordered_numbers`, `name`, `trademark`, `content`) VALUES
                                                                                                                                                     (1, 4, 999, '2023-02-17', 20000, 1000, 10, 'PC PV Home Office I50168 (Intel Core i5-12400/ 2 x 8GB/ 500GB SSD/ Free DOS)', 'Phong Vũ', 'CPU Intel Core i5 12400, Mainboard MSI PRO H610M-E DDR4, Ram 2 x 8GB DDR4-3200, SSD WD Green SN350 500GB M.2 2280, PCIE NVME Gen 3x4 (WDS500G2G0C), Power MIK SPOWER 500 (SP005841), Case MIK Phong Vu Office'),
                                                                                                                                                     (2, 4, 999, '2023-02-17', 24000, 1000, 20, 'PC PV Gaming Hades H002 (Intel Ultra 9 285K/ GeForce RTX 5080/ 2 x 24GB/ 1TB SSD/ Free DOS)', 'Phong Vũ', 'CPU Intel Core Ultra 9 285K Mainboard MSI MEG Z890 ACE RAM Teamgroup Xtreem ARGB Black 2x24GB DDR5-8000 SSD MSI SPATIUM M480 PCIe 4.0 NVMe M.2 1TB VGA MSI RTX 5080 16G GAMING TRIO OC 16GB GDDR7 PSU MSI MAG A1250GL PCIE5 Tản nhiệt nước MSI MAG CORELIQUID I360 Case MSI MEG PROSPECT 700R');