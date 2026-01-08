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
- Sắp xếp sản phẩm theo giá, tên, mới nhất
- Giỏ hàng và thanh toán trực tuyến
- Hệ thống mã giảm giá (voucher)
- Quản lý tài khoản và địa chỉ giao hàng
- Danh sách yêu thích (wishlist)
- Đánh giá sản phẩm
- **Live Chat hỗ trợ khách hàng (Chatbot FAQ)**
- **Chế độ Dark/Light Mode**
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
| Bootstrap | 5.3.3 | CSS Framework |
| Bootstrap Icons | 1.11.3 | Icon library |
| JavaScript | ES6+ | Client-side scripting |
| Google Fonts | Inter, Playfair Display | Typography |

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
│   ├── controller/          # 35+ Servlets
│   │   ├── HomeServlet.java
│   │   ├── ProductListServlet.java
│   │   ├── ProductDetailServlet.java
│   │   ├── LoginServlet.java
│   │   ├── RegisterServlet.java
│   │   ├── AddToCartServlet.java
│   │   ├── ViewCartServlet.java
│   │   ├── CheckoutServlet.java
│   │   ├── ChatServlet.java          # NEW: Live Chat API
│   │   ├── DashboardServlet.java
│   │   ├── ManageProductServlet.java
│   │   └── ... (25+ servlets khác)
│   ├── dao/                  # 14 Data Access Objects
│   │   ├── ProductDAO.java
│   │   ├── UserDAO.java
│   │   ├── CartDAO.java
│   │   ├── OrderDAO.java
│   │   ├── ChatDAO.java              # NEW: Chat message storage
│   │   └── ... (9 DAOs khác)
│   ├── model/                # 19 Entity Classes
│   │   ├── User.java
│   │   ├── Product.java
│   │   ├── Category.java
│   │   ├── Brand.java
│   │   ├── Cart.java
│   │   ├── Order.java
│   │   ├── ChatMessage.java          # NEW
│   │   ├── ChatSession.java          # NEW
│   │   └── ... (11 models khác)
│   ├── filter/               # Security & Performance Filters
│   │   ├── SecurityFilter.java
│   │   └── CacheControlFilter.java   # NEW: Static file caching
│   └── utils/                # Utility Classes
│       ├── HibernateUtil.java
│       ├── EmailUtils.java
│       ├── PasswordUtils.java
│       ├── UploadUtils.java
│       └── ChatbotService.java       # NEW: FAQ chatbot logic
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
    ├── search.jsp            # Tìm kiếm
    ├── about.jsp             # Giới thiệu
    ├── contact.jsp           # Liên hệ
    ├── includes/
    │   ├── header.jsp
    │   ├── footer.jsp
    │   └── chat-widget.jsp   # NEW: Live chat widget
    ├── admin/                # Trang quản trị
    │   ├── dashboard.jsp
    │   ├── products.jsp
    │   ├── categories.jsp
    │   ├── brands.jsp
    │   ├── orders.jsp
    │   └── users.jsp
    └── assets/
        ├── css/
        │   ├── main.css
        │   ├── header.css
        │   ├── theme.css         # NEW: Dark/Light theme
        │   ├── chat.css          # NEW: Chat widget styles
        │   ├── toast.css         # NEW: Toast notifications
        │   └── gallery.css       # NEW: Product gallery
        └── js/
            ├── main.js
            ├── cart.js
            ├── theme.js          # NEW: Theme switcher
            ├── chat.js           # NEW: Chat functionality
            ├── toast.js          # NEW: Toast notifications
            ├── gallery.js        # NEW: Image gallery
            └── lazy-load.js      # NEW: Image lazy loading
```

---

## ✨ Tính Năng

### 🛒 Khách Hàng (Customer)

| STT | Tính năng | Mô tả | Trạng thái |
|-----|-----------|-------|------------|
| 1 | Xem sản phẩm | Duyệt và lọc sản phẩm theo danh mục, thương hiệu, giá | ✅ Hoàn thành |
| 2 | Sắp xếp sản phẩm | Sắp xếp theo giá, tên A-Z/Z-A, mới nhất | ✅ Hoàn thành |
| 3 | Tìm kiếm | Tìm sản phẩm theo tên, mô tả | ✅ Hoàn thành |
| 4 | Chi tiết sản phẩm | Xem thông tin chi tiết, chọn size, màu | ✅ Hoàn thành |
| 5 | **Gallery ảnh nâng cao** | Lightbox, zoom, navigation arrows | ✅ Hoàn thành |
| 6 | Đăng ký/Đăng nhập | Tạo tài khoản và xác thực | ✅ Hoàn thành |
| 7 | Giỏ hàng | Thêm, xóa, cập nhật số lượng + animation | ✅ Hoàn thành |
| 8 | **Toast Notifications** | Thông báo đẹp khi thêm giỏ hàng/wishlist | ✅ Hoàn thành |
| 9 | Wishlist | Lưu sản phẩm yêu thích | ✅ Hoàn thành |
| 10 | Mã giảm giá | Áp dụng voucher khi thanh toán | ✅ Hoàn thành |
| 11 | Ví Voucher | Xem voucher cá nhân | ✅ Hoàn thành |
| 12 | Thanh toán | Đặt hàng với nhiều phương thức | ✅ Hoàn thành |
| 13 | Quản lý địa chỉ | Thêm/sửa/xóa địa chỉ giao hàng | ✅ Hoàn thành |
| 14 | Lịch sử đơn hàng | Xem trạng thái đơn hàng | ✅ Hoàn thành |
| 15 | Đánh giá sản phẩm | Viết review và rating | ✅ Hoàn thành |
| 16 | Quên mật khẩu | Reset password qua email | ✅ Hoàn thành |
| 17 | **Live Chat (Chatbot)** | Hỏi đáp FAQ tự động | ✅ Hoàn thành |
| 18 | **Dark/Light Mode** | Chuyển đổi giao diện sáng/tối | ✅ Hoàn thành |

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

### ⚡ Hiệu Năng & UX

| STT | Tính năng | Mô tả | Trạng thái |
|-----|-----------|-------|------------|
| 1 | **Lazy Loading Images** | Chỉ tải ảnh khi scroll đến | ✅ Hoàn thành |
| 2 | **Cache Control** | Browser cache cho static files | ✅ Hoàn thành |
| 3 | **Fly-to-Cart Animation** | Animation khi thêm giỏ hàng | ✅ Hoàn thành |

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
│  ├── Live Chat hỗ trợ                                      │
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
   git clone https://github.com/sai-ctruong/CuoiKi_Web_Java_Clothes.git
   cd CuoiKi_Web_Java_Clothes
   ```

2. **Cấu hình Database**
   - Tạo database MySQL: `clothing_shop`
   - Cập nhật thông tin kết nối trong `src/main/resources/META-INF/persistence.xml`
   ```xml
   <property name="jakarta.persistence.jdbc.url" value="jdbc:mysql://localhost:3306/clothing_shop"/>
   <property name="jakarta.persistence.jdbc.user" value="your_username"/>
   <property name="jakarta.persistence.jdbc.password" value="your_password"/>
   ```

3. **Build dự án**
   ```bash
   mvn clean package
   ```

4. **Deploy lên Tomcat**
   - Copy file `target/ProjectCuoiKi_Clothes.war` vào thư mục `<TOMCAT_HOME>/webapps/`
   - Hoặc sử dụng IDE (NetBeans, IntelliJ) để deploy

5. **Truy cập ứng dụng**
   ```
   http://localhost:8080/ProjectCuoiKi_Clothes/
   ```

### Tài Khoản Test
| Role | Email | Password |
|------|-------|----------|
| Admin | admin@example.com | admin123 |
| Staff | staff@example.com | staff123 |
| Customer | user@example.com | user123 |

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
          ├──── Wishlist ───────────────────┴── Brand
          │                                  │
          ├──── UserVoucher ─────────────────── Voucher
          │
          └──── ChatSession ──── ChatMessage
```

### Các Bảng Chính

| Bảng | Mô tả | Ghi chú |
|------|-------|---------|
| User | Thông tin người dùng | |
| Product | Sản phẩm | |
| ProductImage | Ảnh sản phẩm | |
| Category | Danh mục | |
| Brand | Thương hiệu | |
| Cart | Giỏ hàng | |
| CartItem | Chi tiết giỏ hàng | |
| Order | Đơn hàng | |
| OrderDetail | Chi tiết đơn hàng | |
| Address | Địa chỉ giao hàng | |
| Review | Đánh giá | |
| Wishlist | Yêu thích | |
| Voucher | Mã giảm giá | |
| UserVoucher | Voucher cá nhân | |
| ChatSession | Phiên chat | **NEW** |
| ChatMessage | Tin nhắn chat | **NEW** |

---

## 🔗 API Endpoints

### Public URLs
| Method | URL | Mô tả |
|--------|-----|-------|
| GET | `/home` | Trang chủ |
| GET | `/products` | Danh sách sản phẩm |
| GET | `/products?sort=newest` | Sắp xếp sản phẩm |
| GET | `/product?id={id}` | Chi tiết sản phẩm |
| GET | `/search?q={keyword}` | Tìm kiếm |
| GET | `/about` | Giới thiệu |
| GET | `/contact` | Liên hệ |

### Authentication
| Method | URL | Mô tả |
|--------|-----|-------|
| GET/POST | `/login` | Đăng nhập |
| GET/POST | `/register` | Đăng ký |
| GET | `/logout` | Đăng xuất |
| GET/POST | `/forgot-password` | Quên mật khẩu |
| GET/POST | `/reset-password` | Đặt lại mật khẩu |

### Protected URLs (Yêu cầu đăng nhập)
| Method | URL | Mô tả |
|--------|-----|-------|
| GET | `/cart` | Xem giỏ hàng |
| GET | `/cart/add?id={id}` | Thêm vào giỏ |
| POST | `/cart/update` | Cập nhật giỏ |
| POST | `/cart/remove` | Xóa khỏi giỏ |
| GET/POST | `/checkout` | Thanh toán |
| GET | `/profile` | Tài khoản |
| GET | `/orders` | Lịch sử đơn hàng |
| GET | `/wishlist` | Yêu thích |
| GET/POST | `/address` | Địa chỉ |
| GET | `/voucher-wallet` | Ví voucher |

### Chat API
| Method | URL | Mô tả |
|--------|-----|-------|
| POST | `/chat` | Gửi tin nhắn chat |

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
- **Sản phẩm**: Grid layout, filter, sort dropdown, pagination
- **Chi tiết**: Gallery ảnh với lightbox, chọn size/màu, review
- **Giỏ hàng**: Cập nhật số lượng, voucher, fly-to-cart animation
- **Thanh toán**: Form địa chỉ, chọn payment

### Trang Admin
- **Dashboard**: Thống kê cards, quick actions
- **Products**: Table với search, CRUD modal
- **Orders**: Table với status badges
- **Users**: Quản lý role, toggle status

### Design System
- **Theme**: Dark/Light mode toggle
- **Colors**: Primary blue (#3b82f6), Gold accent (#c9a962)
- **Font**: Inter, Playfair Display (Google Fonts)
- **Effects**: Glassmorphism, hover animations, toast notifications

### UI Components (NEW)
- **Toast Notifications**: 5 loại (success, error, warning, info, cart)
- **Live Chat Widget**: Floating button với chatbot
- **Image Gallery**: Lightbox, zoom, keyboard navigation
- **Theme Toggle**: Nút chuyển đổi sáng/tối trên header

---

## 📊 Tiến Độ Phát Triển

### ✅ Đã Hoàn Thành
- [x] Thiết kế giao diện responsive
- [x] Hệ thống xác thực và phân quyền
- [x] CRUD sản phẩm, danh mục, thương hiệu
- [x] Giỏ hàng và thanh toán
- [x] Mã giảm giá (voucher) + Ví voucher cá nhân
- [x] Quản lý đơn hàng
- [x] Dashboard admin
- [x] Upload ảnh sản phẩm
- [x] Wishlist và Review
- [x] Email notifications
- [x] Sắp xếp sản phẩm (giá, tên, mới nhất)
- [x] **Live Chat Chatbot** (08/01/2026)
- [x] **Dark/Light Mode** (08/01/2026)
- [x] **Toast Notifications** (08/01/2026)
- [x] **Product Gallery nâng cao** (08/01/2026)
- [x] **Performance: Lazy Loading + Caching** (08/01/2026)

### 🔄 Có Thể Mở Rộng
- [ ] Tích hợp thanh toán online (VNPay/Momo)
- [ ] Báo cáo doanh thu chi tiết
- [ ] Export Excel đơn hàng
- [ ] Real-time chat với WebSocket
- [ ] Push notifications
- [ ] Social Login (Google, Facebook)

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

> **Cập nhật lần cuối**: 08/01/2026
