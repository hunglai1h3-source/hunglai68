-- PHẦN I: TẠO CẤU TRÚC (DDL)
-- =============================================

-- 1. Tạo bảng Khách hàng
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY, -- SERIAL tự động tạo sequence tự tăng trong Postgres
    fullname VARCHAR(255) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    address VARCHAR(255)
);

-- 2. Tạo bảng Sản phẩm
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(18, 2) NOT NULL CHECK (price > 0),
    stock_quantity INT DEFAULT 0 CHECK (stock_quantity >= 0)
);

-- 3. Tạo bảng Đơn hàng
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE DEFAULT CURRENT_DATE, -- Cú pháp chuẩn Postgres cho ngày hiện tại
    customer_id INT,
    CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 4. Tạo bảng Đơn hàng chi tiết
CREATE TABLE order_details (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity > 0),
    PRIMARY KEY (order_id, product_id),
    CONSTRAINT fk_detail_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT fk_detail_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 5. Nhập dữ liệu mẫu (DML) - Cần sản phẩm ID 8 để phục vụ bài 4
INSERT INTO products (product_id, product_name, price, stock_quantity) 
VALUES (8, 'Nước suối Aquafina', 5000, 100);

-- BÀI 2: TẠO BẢNG NHÀ CUNG CẤP
CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY,
    supplier_name VARCHAR(255) NOT NULL,
    contact_phone VARCHAR(15) UNIQUE
);

-- =============================================
-- PHẦN II: THAO TÁC CẤU TRÚC VÀ DỮ LIỆU
-- =============================================

-- BÀI 3: CẬP NHẬT CẤU TRÚC (ALTER TABLE)
-- 1. Thêm cột email
ALTER TABLE suppliers ADD COLUMN email VARCHAR(100);

-- 2. Thêm cột supplier_id vào products và tạo FK
ALTER TABLE products ADD COLUMN supplier_id INT;
ALTER TABLE products ADD CONSTRAINT fk_product_supplier 
FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id);


-- BÀI 4: THAO TÁC DỮ LIỆU (INSERT, UPDATE, DELETE)
-- 1. Thêm 2 nhà cung cấp
INSERT INTO suppliers (supplier_name, contact_phone, email) 
VALUES 
('Công ty Sữa Việt Nam', '0987654321', 'contact@vinamilk.vn'),
('Công ty Thực phẩm Á Châu', '0912345678', 'contact@acecook.vn');

-- 2. Cập nhật số điện thoại sai
UPDATE suppliers 
SET contact_phone = '0911112222' 
WHERE supplier_name = 'Công ty Thực phẩm Á Châu';

-- 3. Xóa sản phẩm product_id = 8
DELETE FROM products WHERE product_id = 8;


-- BÀI 5: DROP COLUMN VÀ DROP TABLE
-- 1. Tạo bảng nháp
CREATE TABLE test_table (
    id INT
);

-- 2. Xóa cột contact_phone
ALTER TABLE suppliers DROP COLUMN contact_phone;

-- 3. Xóa bảng nháp
DROP TABLE test_table;

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_details;
SELECT * FROM suppliers;