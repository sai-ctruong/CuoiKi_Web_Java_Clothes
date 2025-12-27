-- Script thêm sản phẩm mẫu với ảnh LOCAL
-- Chạy script này trong MySQL Workbench hoặc terminal
-- QUAN TRỌNG: Đặt ảnh vào thư mục uploads/products/ trước khi chạy script

-- Thêm Categories nếu chưa có
INSERT IGNORE INTO Category (id, name, description) VALUES
(1, 'Áo Thun', 'Các loại áo thun nam nữ'),
(2, 'Quần Jean', 'Các loại quần jean thời trang'),
(3, 'Áo Khoác', 'Áo khoác mùa đông'),
(4, 'Váy Đầm', 'Váy đầm nữ các loại');

-- Thêm Brands nếu chưa có
INSERT IGNORE INTO Brand (id, name, description) VALUES
(1, 'Uniqlo', 'Thương hiệu Nhật Bản'),
(2, 'H&M', 'Thương hiệu Thụy Điển'),
(3, 'Zara', 'Thương hiệu Tây Ban Nha'),
(4, 'Local Brand', 'Thương hiệu Việt Nam');

-- =====================================================
-- DANH MỤC 1: ÁO THUN (10 sản phẩm)
-- Thư mục ảnh: uploads/products/ao-thun/
-- Tên file: 01.jpg, 02.jpg, ... 10.jpg
-- =====================================================
INSERT INTO Product (name, description, price, stock, category_id, brand_id, size, color, created_at) VALUES
('Áo Thun Basic Trắng', 'Áo thun cotton 100% cao cấp, form regular fit thoải mái. Chất vải mềm mịn, thấm hút mồ hôi tốt.', 249000, 100, 1, 1, 'M', 'Trắng', NOW()),
('Áo Thun Oversize Đen', 'Áo thun oversize phong cách streetwear, chất cotton co giãn 4 chiều.', 299000, 80, 1, 4, 'L', 'Đen', NOW()),
('Áo Thun Polo Classic', 'Áo polo truyền thống với cổ bẻ thanh lịch, phù hợp đi làm và dạo phố.', 399000, 60, 1, 2, 'M', 'Xanh Navy', NOW()),
('Áo Thun Graphic Print', 'Áo thun in hình độc đáo, phong cách trẻ trung năng động.', 279000, 120, 1, 4, 'L', 'Đen', NOW()),
('Áo Thun Cổ V', 'Áo thun cổ chữ V sang trọng, chất liệu cotton premium.', 329000, 90, 1, 3, 'M', 'Xám', NOW()),
('Áo Thun Crop Top Nữ', 'Áo croptop nữ tính, phong cách Hàn Quốc hot trend 2024.', 199000, 150, 1, 2, 'S', 'Hồng', NOW()),
('Áo Thun Dài Tay', 'Áo thun dài tay basic, phù hợp mùa thu đông.', 349000, 70, 1, 1, 'L', 'Đen', NOW()),
('Áo Thun Sọc Ngang', 'Áo thun sọc ngang phong cách Địa Trung Hải, trẻ trung và năng động.', 269000, 85, 1, 2, 'M', 'Trắng/Xanh', NOW()),
('Áo Thun Cotton Organic', 'Áo thun cotton hữu cơ thân thiện môi trường, mềm mại với làn da.', 449000, 50, 1, 1, 'M', 'Kem', NOW()),
('Áo Thun Raglan', 'Áo thun raglan hai màu cá tính, phong cách thể thao.', 289000, 95, 1, 4, 'L', 'Trắng/Đỏ', NOW());

-- =====================================================
-- DANH MỤC 2: QUẦN JEAN (10 sản phẩm)
-- Thư mục ảnh: uploads/products/quan-jean/
-- Tên file: 01.jpg, 02.jpg, ... 10.jpg
-- =====================================================
INSERT INTO Product (name, description, price, stock, category_id, brand_id, size, color, created_at) VALUES
('Quần Jean Skinny Fit', 'Quần jean ôm dáng, co giãn tốt, tôn dáng hiệu quả.', 599000, 80, 2, 3, '30', 'Xanh Đậm', NOW()),
('Quần Jean Slim Fit', 'Quần jean ôm vừa phải, không quá chật, thoải mái di chuyển.', 549000, 90, 2, 2, '31', 'Xanh Wash', NOW()),
('Quần Jean Boyfriend', 'Quần jean rộng rãi phong cách boyfriend, thời trang và cá tính.', 649000, 70, 2, 3, '29', 'Xanh Nhạt', NOW()),
('Quần Jean Rách Gối', 'Quần jean rách gối phong cách street style, cá tính nổi bật.', 579000, 65, 2, 4, '30', 'Xanh Trung', NOW()),
('Quần Jean Ống Suông', 'Quần jean ống suông retro, phong cách vintage đầy cuốn hút.', 629000, 55, 2, 1, '32', 'Xanh Đậm', NOW()),
('Quần Jean High Waist', 'Quần jean cạp cao tôn dáng, visual cao ráo hơn.', 699000, 85, 2, 3, '28', 'Đen', NOW()),
('Quần Jean Mom Jeans', 'Quần mom jeans dáng rộng, thoải mái và trendy.', 589000, 75, 2, 2, '29', 'Xanh Trung', NOW()),
('Quần Jean Straight', 'Quần jean ống đứng cổ điển, phù hợp mọi dáng người.', 529000, 100, 2, 1, '31', 'Xanh Wash', NOW()),
('Quần Jean Cropped', 'Quần jean lửng 7/8, phong cách mùa hè năng động.', 479000, 60, 2, 4, '30', 'Xanh Nhạt', NOW()),
('Quần Jean Đen Trơn', 'Quần jean đen basic, dễ phối đồ cho mọi occasion.', 549000, 95, 2, 2, '32', 'Đen', NOW());

-- =====================================================
-- DANH MỤC 3: ÁO KHOÁC (10 sản phẩm)
-- Thư mục ảnh: uploads/products/ao-khoac/
-- Tên file: 01.jpg, 02.jpg, ... 10.jpg
-- =====================================================
INSERT INTO Product (name, description, price, stock, category_id, brand_id, size, color, created_at) VALUES
('Áo Khoác Bomber', 'Áo khoác bomber phong cách phi công, ấm áp và thời trang.', 899000, 40, 3, 3, 'L', 'Xanh Rêu', NOW()),
('Áo Khoác Denim', 'Áo khoác jeans cổ điển, item must-have mọi tủ đồ.', 749000, 55, 3, 2, 'M', 'Xanh Wash', NOW()),
('Áo Khoác Hoodie', 'Áo hoodie nỉ bông ấm áp, có mũ trùm thời trang.', 599000, 80, 3, 4, 'L', 'Xám', NOW()),
('Áo Khoác Blazer', 'Áo blazer công sở thanh lịch, phù hợp đi làm và sự kiện.', 1290000, 35, 3, 3, 'M', 'Đen', NOW()),
('Áo Khoác Parka', 'Áo khoác parka dày dặn, chống gió và giữ ấm tuyệt vời.', 1590000, 25, 3, 1, 'XL', 'Xanh Navy', NOW()),
('Áo Khoác Cardigan', 'Áo cardigan len mỏng, phong cách Hàn Quốc nhẹ nhàng.', 549000, 70, 3, 2, 'M', 'Be', NOW()),
('Áo Khoác Varsity', 'Áo khoác varsity phong cách thể thao Mỹ, trẻ trung năng động.', 799000, 45, 3, 4, 'L', 'Đen/Trắng', NOW()),
('Áo Khoác Track Jacket', 'Áo khoác thể thao kéo khóa, chất liệu polyester cao cấp.', 699000, 60, 3, 1, 'M', 'Đen', NOW()),
('Áo Khoác Windbreaker', 'Áo khoác gió siêu nhẹ, chống nước nhẹ, gấp gọn tiện lợi.', 849000, 50, 3, 1, 'L', 'Xanh', NOW()),
('Áo Khoác Leather', 'Áo khoác da nhân tạo cao cấp, phong cách rock chất ngầu.', 1190000, 30, 3, 3, 'M', 'Đen', NOW());

-- =====================================================
-- DANH MỤC 4: VÁY ĐẦM (10 sản phẩm)
-- Thư mục ảnh: uploads/products/vay-dam/
-- Tên file: 01.jpg, 02.jpg, ... 10.jpg
-- =====================================================
INSERT INTO Product (name, description, price, stock, category_id, brand_id, size, color, created_at) VALUES
('Váy Midi Hoa Nhí', 'Váy midi hoa nhí nữ tính, chất liệu voan mềm mại bay bổng.', 599000, 60, 4, 3, 'S', 'Trắng/Hoa', NOW()),
('Đầm Suông Công Sở', 'Đầm suông thanh lịch cho nàng công sở, dễ mặc dễ đẹp.', 749000, 45, 4, 2, 'M', 'Đen', NOW()),
('Váy Xòe Vintage', 'Váy xòe phong cách vintage 50s, nữ tính và duyên dáng.', 649000, 55, 4, 3, 'S', 'Đỏ', NOW()),
('Đầm Maxi Bãi Biển', 'Váy maxi dài bay bổng, hoàn hảo cho kỳ nghỉ biển.', 549000, 70, 4, 4, 'M', 'Xanh Pastel', NOW()),
('Váy Mini A-line', 'Váy mini dáng chữ A trẻ trung, năng động và quyến rũ.', 449000, 80, 4, 2, 'S', 'Hồng', NOW()),
('Đầm Bodycon', 'Đầm ôm body tôn dáng, phù hợp party và tiệc tối.', 699000, 40, 4, 3, 'S', 'Đen', NOW()),
('Váy Babydoll', 'Váy babydoll dáng xòe, che khuyết điểm hiệu quả.', 499000, 65, 4, 4, 'M', 'Trắng', NOW()),
('Đầm Sơ Mi', 'Đầm sơ mi thanh lịch, có thể mặc đi làm hoặc dạo phố.', 629000, 50, 4, 1, 'M', 'Xanh Nhạt', NOW()),
('Váy Jean Denim', 'Váy jean ngắn phong cách Âu Mỹ, cá tính và khỏe khoắn.', 549000, 55, 4, 2, 'S', 'Xanh Wash', NOW()),
('Đầm Dạ Hội', 'Đầm dạ hội quyến rũ với chi tiết sequin lấp lánh.', 1890000, 20, 4, 3, 'S', 'Đỏ', NOW());

-- =====================================================
-- THÊM ẢNH SẢN PHẨM (đường dẫn local)
-- =====================================================

-- Tạo bảng tạm để lưu product ID bắt đầu
SET @start_ao_thun = (SELECT MIN(id) FROM Product WHERE category_id = 1);
SET @start_quan_jean = (SELECT MIN(id) FROM Product WHERE category_id = 2);
SET @start_ao_khoac = (SELECT MIN(id) FROM Product WHERE category_id = 3);
SET @start_vay_dam = (SELECT MIN(id) FROM Product WHERE category_id = 4);

-- Xóa ảnh cũ nếu có
DELETE FROM ProductImage WHERE product_id IN (SELECT id FROM Product);

-- Áo Thun (10 ảnh)
INSERT INTO ProductImage (product_id, image_url, is_thumbnail) VALUES
(@start_ao_thun + 0, '/uploads/products/ao-thun/01.jpg', TRUE),
(@start_ao_thun + 1, '/uploads/products/ao-thun/02.jpg', TRUE),
(@start_ao_thun + 2, '/uploads/products/ao-thun/03.jpg', TRUE),
(@start_ao_thun + 3, '/uploads/products/ao-thun/04.jpg', TRUE),
(@start_ao_thun + 4, '/uploads/products/ao-thun/05.jpg', TRUE),
(@start_ao_thun + 5, '/uploads/products/ao-thun/06.jpg', TRUE),
(@start_ao_thun + 6, '/uploads/products/ao-thun/07.jpg', TRUE),
(@start_ao_thun + 7, '/uploads/products/ao-thun/08.jpg', TRUE),
(@start_ao_thun + 8, '/uploads/products/ao-thun/09.jpg', TRUE),
(@start_ao_thun + 9, '/uploads/products/ao-thun/10.jpg', TRUE);

-- Quần Jean (10 ảnh)
INSERT INTO ProductImage (product_id, image_url, is_thumbnail) VALUES
(@start_quan_jean + 0, '/uploads/products/quan-jean/01.jpg', TRUE),
(@start_quan_jean + 1, '/uploads/products/quan-jean/02.jpg', TRUE),
(@start_quan_jean + 2, '/uploads/products/quan-jean/03.jpg', TRUE),
(@start_quan_jean + 3, '/uploads/products/quan-jean/04.jpg', TRUE),
(@start_quan_jean + 4, '/uploads/products/quan-jean/05.jpg', TRUE),
(@start_quan_jean + 5, '/uploads/products/quan-jean/06.jpg', TRUE),
(@start_quan_jean + 6, '/uploads/products/quan-jean/07.jpg', TRUE),
(@start_quan_jean + 7, '/uploads/products/quan-jean/08.jpg', TRUE),
(@start_quan_jean + 8, '/uploads/products/quan-jean/09.jpg', TRUE),
(@start_quan_jean + 9, '/uploads/products/quan-jean/10.jpg', TRUE);

-- Áo Khoác (10 ảnh)
INSERT INTO ProductImage (product_id, image_url, is_thumbnail) VALUES
(@start_ao_khoac + 0, '/uploads/products/ao-khoac/01.jpg', TRUE),
(@start_ao_khoac + 1, '/uploads/products/ao-khoac/02.jpg', TRUE),
(@start_ao_khoac + 2, '/uploads/products/ao-khoac/03.jpg', TRUE),
(@start_ao_khoac + 3, '/uploads/products/ao-khoac/04.jpg', TRUE),
(@start_ao_khoac + 4, '/uploads/products/ao-khoac/05.jpg', TRUE),
(@start_ao_khoac + 5, '/uploads/products/ao-khoac/06.jpg', TRUE),
(@start_ao_khoac + 6, '/uploads/products/ao-khoac/07.jpg', TRUE),
(@start_ao_khoac + 7, '/uploads/products/ao-khoac/08.jpg', TRUE),
(@start_ao_khoac + 8, '/uploads/products/ao-khoac/09.jpg', TRUE),
(@start_ao_khoac + 9, '/uploads/products/ao-khoac/10.jpg', TRUE);

-- Váy Đầm (10 ảnh)
INSERT INTO ProductImage (product_id, image_url, is_thumbnail) VALUES
(@start_vay_dam + 0, '/uploads/products/vay-dam/01.jpg', TRUE),
(@start_vay_dam + 1, '/uploads/products/vay-dam/02.jpg', TRUE),
(@start_vay_dam + 2, '/uploads/products/vay-dam/03.jpg', TRUE),
(@start_vay_dam + 3, '/uploads/products/vay-dam/04.jpg', TRUE),
(@start_vay_dam + 4, '/uploads/products/vay-dam/05.jpg', TRUE),
(@start_vay_dam + 5, '/uploads/products/vay-dam/06.jpg', TRUE),
(@start_vay_dam + 6, '/uploads/products/vay-dam/07.jpg', TRUE),
(@start_vay_dam + 7, '/uploads/products/vay-dam/08.jpg', TRUE),
(@start_vay_dam + 8, '/uploads/products/vay-dam/09.jpg', TRUE),
(@start_vay_dam + 9, '/uploads/products/vay-dam/10.jpg', TRUE);

-- Xác nhận
SELECT 'Đã thêm thành công!' AS message, 
       (SELECT COUNT(*) FROM Product) AS total_products,
       (SELECT COUNT(*) FROM ProductImage) AS total_images;
