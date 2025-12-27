# 🛍️ Clothing Shop - Website Bán Quần Áo Thời Trang

> **Dự án cuối kỳ - Web Java Servlet/JSP**
> 
> Website thương mại điện tử bán quần áo với đầy đủ tính năng cho khách hàng và quản trị viên.

---

## 📋 Mục Lục

- [Tổng Quan](#-tổng-quan)
- [Công Nghệ Sử Dụng](#-công-nghệ-sử-dụng)
- [Cấu Trúc Dự Án](#-cấu-trúc-dự-án)
- [Tính Năng](#-tính-năng)
- [Phân Quyền Người Dùng](#-phân-quyền-người-dùng)
- [Hướng Dẫn Cài Đặt](#-hướng-dẫn-cài-đặt)
- [Cấu Trúc Database](#-cấu-trúc-database)
- [API Endpoints](#-api-endpoints)
- [Giao Diện](#-giao-diện)
- [Tiến Độ Phát Triển](#-tiến-độ-phát-triển)

---

## 🎯 Tổng Quan

**Clothing Shop** là website thương mại điện tử chuyên bán quần áo thời trang với các tính năng:

- Hiển thị và tìm kiếm sản phẩm theo danh mục, thương hiệu
- Giỏ hàng và thanh toán trực tuyến
- Hệ thống mã giảm giá (voucher)
- Quản lý tài khoản và địa chỉ giao hàng
- Danh sách yêu thích (wishlist)
- Đánh giá sản phẩm
- Trang quản trị Admin với dashboard đầy đủ

---

## 🔧 Công Nghệ Sử Dụng

### Backend
| Công nghệ | Phiên bản | Mô tả |
|-----------|-----------|-------|
| Java | 11 | Ngôn ngữ lập trình |
| Jakarta EE | 10.0.0 | Enterprise Edition |
| Hibernate ORM | 6.4.4 | Object-Relational Mapping |
| MySQL | 8.x | Cơ sở dữ liệu |
| Jakarta Mail | 2.0.2 | Gửi email |

### Frontend
| Công nghệ | Phiên bản | Mô tả |
|-----------|-----------|-------|
| JSP/JSTL | 3.0 | Server-side rendering |
| Bootstrap | 5.3.2 | CSS Framework |
| Bootstrap Icons | 1.11.1 | Icon library |
| JavaScript | ES6+ | Client-side scripting |

### Server & Build
| Công nghệ | Phiên bản | Mô tả |
|-----------|-----------|-------|
| Apache Tomcat | 10.x | Application Server |
| Maven | 3.x | Build automation |

---

## 📁 Cấu Trúc Dự Án

```
src/main/
├── java/mypackage/shop/
│   ├── controller/          # 30 Servlets
│   │   ├── HomeServlet.java
│   │   ├── ProductListServlet.java
│   │   ├── ProductDetailServlet.java
│   │   ├── LoginServlet.java
│   │   ├── RegisterServlet.java
│   │   ├── AddToCartServlet.java
│   │   ├── ViewCartServlet.java
│   │   ├── CheckoutServlet.java
│   │   ├── DashboardServlet.java
│   │   ├── ManageProductServlet.java
│   │   └── ... (20 servlets khác)
│   ├── dao/                  # 12 Data Access Objects
│   │   ├── ProductDAO.java
│   │   ├── UserDAO.java
│   │   ├── CartDAO.java
│   │   ├── OrderDAO.java
│   │   └── ... (8 DAOs khác)
│   ├── model/                # 17 Entity Classes
│   │   ├── User.java
│   │   ├── Product.java
│   │   ├── Category.java
│   │   ├── Brand.java
│   │   ├── Cart.java
│   │   ├── Order.java
│   │   └── ... (11 models khác)
│   ├── filter/               # Security Filters
│   │   └── SecurityFilter.java
│   └── utils/                # Utility Classes
│       ├── HibernateUtil.java
│       ├── EmailUtils.java
│       ├── PasswordUtils.java
│       └── UploadUtils.java
└── webapp/
    ├── index.jsp             # Trang chủ
    ├── products.jsp          # Danh sách sản phẩm
    ├── product-detail.jsp    # Chi tiết sản phẩm
    ├── cart.jsp              # Giỏ hàng
    ├── checkout.jsp          # Thanh toán
    ├── login.jsp             # Đăng nhập
    ├── register.jsp          # Đăng ký
    ├── profile.jsp           # Tài khoản
    ├── wishlist.jsp          # Yêu thích
    ├── order-history.jsp     # Lịch sử đơn hàng
    ├── admin/                # Trang quản trị
    │   ├── dashboard.jsp
    │   ├── products.jsp
    │   ├── categories.jsp
    │   ├── brands.jsp
    │   ├── orders.jsp
    │   └── users.jsp
    └── assets/
        ├── css/
        └── js/
```

---

## ✨ Tính Năng

### 🛒 Khách Hàng (Customer)

| STT | Tính năng | Mô tả | Trạng thái |
|-----|-----------|-------|------------|
| 1 | Xem sản phẩm | Duyệt và lọc sản phẩm theo danh mục, thương hiệu, giá | ✅ Hoàn thành |
| 2 | Tìm kiếm | Tìm sản phẩm theo tên, mô tả | ✅ Hoàn thành |
| 3 | Chi tiết sản phẩm | Xem thông tin chi tiết, chọn size, màu | ✅ Hoàn thành |
| 4 | Đăng ký/Đăng nhập | Tạo tài khoản và xác thực | ✅ Hoàn thành |
| 5 | Giỏ hàng | Thêm, xóa, cập nhật số lượng | ✅ Hoàn thành |
| 6 | Wishlist | Lưu sản phẩm yêu thích | ✅ Hoàn thành |
| 7 | Mã giảm giá | Áp dụng voucher khi thanh toán | ✅ Hoàn thành |
| 8 | Thanh toán | Đặt hàng với nhiều phương thức | ✅ Hoàn thành |
| 9 | Quản lý địa chỉ | Thêm/sửa/xóa địa chỉ giao hàng | ✅ Hoàn thành |
| 10 | Lịch sử đơn hàng | Xem trạng thái đơn hàng | ✅ Hoàn thành |
| 11 | Đánh giá sản phẩm | Viết review và rating | ✅ Hoàn thành |
| 12 | Quên mật khẩu | Reset password qua email | ✅ Hoàn thành |

### 🔧 Quản Trị (Admin)

| STT | Tính năng | Mô tả | Trạng thái |
|-----|-----------|-------|------------|
| 1 | Dashboard | Thống kê tổng quan | ✅ Hoàn thành |
| 2 | Quản lý sản phẩm | CRUD sản phẩm + upload ảnh | ✅ Hoàn thành |
| 3 | Quản lý danh mục | CRUD categories | ✅ Hoàn thành |
| 4 | Quản lý thương hiệu | CRUD brands | ✅ Hoàn thành |
| 5 | Quản lý đơn hàng | Xem và cập nhật trạng thái | ✅ Hoàn thành |
| 6 | Quản lý người dùng | Xem, khóa/mở, đổi role | ✅ Hoàn thành |

### 👨‍💼 Nhân Viên (Staff)

| STT | Tính năng | Mô tả | Trạng thái |
|-----|-----------|-------|------------|
| 1 | Dashboard | Xem thống kê | ✅ Hoàn thành |
| 2 | Quản lý đơn hàng | Xem và xử lý đơn | ✅ Hoàn thành |

---

## 🔐 Phân Quyền Người Dùng

```
┌─────────────────────────────────────────────────────────────┐
│                     PHÂN QUYỀN HỆ THỐNG                     │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ADMIN (Toàn quyền)                                        │
│  ├── Dashboard                                              │
│  ├── Quản lý Sản phẩm (CRUD)                               │
│  ├── Quản lý Danh mục (CRUD)                               │
│  ├── Quản lý Thương hiệu (CRUD)                            │
│  ├── Quản lý Đơn hàng                                       │
│  └── Quản lý Người dùng (khóa/mở, đổi role)                │
│                                                             │
│  STAFF (Hạn chế)                                           │
│  ├── Dashboard (chỉ xem)                                    │
│  └── Quản lý Đơn hàng (xem, cập nhật trạng thái)           │
│                                                             │
│  CUSTOMER (Khách hàng)                                      │
│  ├── Xem sản phẩm                                          │
│  ├── Giỏ hàng + Thanh toán                                 │
│  ├── Quản lý tài khoản                                      │
│  └── Xem lịch sử đơn hàng                                  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 🚀 Hướng Dẫn Cài Đặt

### Yêu Cầu Hệ Thống
- JDK 11+
- Apache Tomcat 10+
- MySQL 8.0+
- Maven 3.6+

### Các Bước Cài Đặt

1. **Clone repository**
   ```bash
   git clone <repository-url>
   cd CuoiKi_Web_Java_Clothes
   ```

2. **Cấu hình Database**
   - Tạo database MySQL
   - Cập nhật thông tin kết nối trong `persistence.xml`

3. **Chạy script SQL mẫu**
   ```bash
   mysql -u username -p database_name < database/sample_products.sql
   ```

4. **Build và Deploy**
   ```bash
   mvn clean package
   # Copy file WAR vào Tomcat webapps/
   ```

5. **Truy cập ứng dụng**
   ```
   http://localhost:8080/ProjectCuoiKi_Clothes/
   ```

---

## 🗄️ Cấu Trúc Database

### Entity Relationship

```
User ─────┬──── Cart ────── CartItem ──── Product
          │                                  │
          │                                  ├── ProductImage
          │                                  │
          ├──── Order ──── OrderDetail ──────┘
          │                                  │
          ├──── Address                      ├── Category
          │                                  │
          ├──── Review ─────────────────────┘
          │                                  │
          └──── Wishlist ───────────────────┴── Brand
                                             │
Voucher ─────────────────────────────────────┘
```

### Các Bảng Chính

| Bảng | Mô tả | Số cột |
|------|-------|--------|
| User | Thông tin người dùng | 10 |
| Product | Sản phẩm | 12 |
| ProductImage | Ảnh sản phẩm | 4 |
| Category | Danh mục | 3 |
| Brand | Thương hiệu | 3 |
| Cart | Giỏ hàng | 4 |
| CartItem | Chi tiết giỏ hàng | 5 |
| Order | Đơn hàng | 12 |
| OrderDetail | Chi tiết đơn hàng | 5 |
| Address | Địa chỉ giao hàng | 8 |
| Review | Đánh giá | 6 |
| Wishlist | Yêu thích | 4 |
| Voucher | Mã giảm giá | 9 |

---

## 🔗 API Endpoints

### Public URLs
| Method | URL | Mô tả |
|--------|-----|-------|
| GET | `/home` | Trang chủ |
| GET | `/products` | Danh sách sản phẩm |
| GET | `/product?id={id}` | Chi tiết sản phẩm |
| GET | `/search?keyword={keyword}` | Tìm kiếm |
| GET | `/about` | Giới thiệu |
| GET | `/contact` | Liên hệ |

### Authentication
| Method | URL | Mô tả |
|--------|-----|-------|
| GET/POST | `/login` | Đăng nhập |
| GET/POST | `/register` | Đăng ký |
| GET | `/logout` | Đăng xuất |
| GET/POST | `/forgot-password` | Quên mật khẩu |

### Protected URLs (Yêu cầu đăng nhập)
| Method | URL | Mô tả |
|--------|-----|-------|
| GET | `/cart` | Xem giỏ hàng |
| POST | `/cart/add` | Thêm vào giỏ |
| POST | `/cart/update` | Cập nhật giỏ |
| POST | `/cart/remove` | Xóa khỏi giỏ |
| GET/POST | `/checkout` | Thanh toán |
| GET | `/profile` | Tài khoản |
| GET | `/orders` | Lịch sử đơn hàng |
| GET | `/wishlist` | Yêu thích |
| GET/POST | `/address` | Địa chỉ |

### Admin URLs (Chỉ ADMIN)
| Method | URL | Mô tả |
|--------|-----|-------|
| GET | `/dashboard` | Dashboard |
| GET/POST | `/manage/products` | Quản lý sản phẩm |
| GET/POST | `/manage/categories` | Quản lý danh mục |
| GET/POST | `/manage/brands` | Quản lý thương hiệu |
| GET/POST | `/manage/users` | Quản lý người dùng |

### Staff URLs (ADMIN + STAFF)
| Method | URL | Mô tả |
|--------|-----|-------|
| GET/POST | `/manage/orders` | Quản lý đơn hàng |

---

## 🎨 Giao Diện

### Trang Khách Hàng
- **Trang chủ**: Hero banner, sản phẩm nổi bật, danh mục
- **Sản phẩm**: Grid layout, filter, pagination
- **Chi tiết**: Gallery ảnh, chọn size/màu, review
- **Giỏ hàng**: Cập nhật số lượng, voucher
- **Thanh toán**: Form địa chỉ, chọn payment

### Trang Admin
- **Dashboard**: Thống kê cards, quick actions
- **Products**: Table với search, CRUD modal
- **Orders**: Table với status badges
- **Users**: Quản lý role, toggle status

### Design System
- **Theme**: Dark mode với gradient background
- **Colors**: Primary blue (#3b82f6), Gold accent (#c9a050)
- **Font**: Inter (Google Fonts)
- **Effects**: Glassmorphism, hover animations

---

## 📊 Tiến Độ Phát Triển

### ✅ Đã Hoàn Thành
- [x] Thiết kế giao diện responsive
- [x] Hệ thống xác thực và phân quyền
- [x] CRUD sản phẩm, danh mục, thương hiệu
- [x] Giỏ hàng và thanh toán
- [x] Mã giảm giá (voucher)
- [x] Quản lý đơn hàng
- [x] Dashboard admin
- [x] Upload ảnh sản phẩm
- [x] Wishlist và Review
- [x] Email notifications

### 🔄 Đang Phát Triển
- [ ] Tích hợp thanh toán online (VNPay/Momo)
- [ ] Báo cáo doanh thu chi tiết
- [ ] Export Excel đơn hàng

### 📋 Kế Hoạch
- [ ] Chat support
- [ ] Push notifications
- [ ] Mobile responsive improvements

---

## 👥 Thành Viên Nhóm

| STT | Họ Tên | MSSV | Vai Trò |
|-----|--------|------|---------|
| 1 | [Tên thành viên 1] | [MSSV] | Team Lead / Backend |
| 2 | [Tên thành viên 2] | [MSSV] | Frontend / UI Design |
| 3 | [Tên thành viên 3] | [MSSV] | Database / Backend |
| 4 | [Tên thành viên 4] | [MSSV] | Testing / Documentation |

---

## 📝 License

Dự án được phát triển cho mục đích học tập.

---

> **Cập nhật lần cuối**: 28/12/2024
