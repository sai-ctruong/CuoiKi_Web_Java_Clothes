<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${product.name}"/> - Clothing Shop</title>
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    
    <!-- AOS Animation -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #34495e;
            --accent-color: #c9a962;
            --accent-dark: #b8975a;
            --accent-light: #d4b76a;
            --success-color: #27ae60;
            --danger-color: #e74c3c;
            --warning-color: #f39c12;
            --info-color: #3498db;
            --light-bg: #f8f9fa;
            --white: #ffffff;
            --text-dark: #2c3e50;
            --text-body: #495057;
            --text-muted: #6c757d;
            --border-color: #dee2e6;
            --shadow-sm: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            --shadow-md: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            --shadow-lg: 0 1rem 3rem rgba(0, 0, 0, 0.175);
            --radius: 0.5rem;
            --radius-lg: 1rem;
            --radius-xl: 1.5rem;
            --transition: all 0.3s ease;
        }
        
        body {
            padding-top: 70px;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            font-family: 'Inter', sans-serif;
            color: var(--text-dark);
            min-height: 100vh;
        }
        
        /* Breadcrumb */
        .breadcrumb-section {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            padding: 1.5rem 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: var(--shadow-sm);
        }
        
        .breadcrumb {
            background: none;
            padding: 0;
            margin: 0;
            font-size: 0.95rem;
        }
        
        .breadcrumb-item a {
            color: var(--text-body);
            text-decoration: none;
            font-weight: 500;
            transition: var(--transition);
        }
        
        .breadcrumb-item a:hover {
            color: var(--accent-color);
        }
        
        .breadcrumb-item.active {
            color: var(--accent-dark);
            font-weight: 600;
        }
        
        /* Main Section */
        .product-detail-section {
            padding: 2rem 0 3rem;
        }
        
        /* Product Card */
        .product-card {
            background: var(--white);
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-lg);
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        /* Sticky Gallery Column */
        @media (min-width: 992px) {
            .col-lg-6:first-child .product-card {
                position: sticky;
                top: 90px;
            }
        }
        
        /* Product Gallery */
        .product-gallery {
            position: relative;
            background: var(--light-bg);
            padding: 2rem;
        }
        
        .main-image-container {
            position: relative;
            background: var(--white);
            border-radius: var(--radius-xl);
            overflow: hidden;
            aspect-ratio: 1;
            margin-bottom: 1.5rem;
            box-shadow: var(--shadow-md);
        }
        
        .main-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        
        .main-image-container:hover .main-image {
            transform: scale(1.08);
        }
        
        .product-badges {
            position: absolute;
            top: 1.5rem;
            left: 1.5rem;
            z-index: 3;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }
        
        .badge-new {
            background: linear-gradient(135deg, var(--accent-color), var(--accent-light));
            color: var(--white);
            padding: 0.5rem 1.2rem;
            border-radius: 25px;
            font-size: 0.8rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: var(--shadow-md);
        }
        
        .badge-sale {
            background: linear-gradient(135deg, var(--danger-color), #ff6b6b);
            color: var(--white);
            padding: 0.5rem 1.2rem;
            border-radius: 25px;
            font-size: 0.8rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: var(--shadow-md);
        }
        
        .wishlist-btn {
            position: absolute;
            top: 1.5rem;
            right: 1.5rem;
            width: 50px;
            height: 50px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border: none;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
            color: var(--text-muted);
            cursor: pointer;
            transition: var(--transition);
            box-shadow: var(--shadow-md);
            z-index: 3;
        }
        
        .wishlist-btn:hover,
        .wishlist-btn.active {
            color: var(--danger-color);
            transform: scale(1.1);
            background: var(--white);
        }
        
        /* Thumbnails */
        .thumbnails-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1rem;
        }
        
        .thumbnail-item {
            aspect-ratio: 1;
            border-radius: var(--radius-lg);
            overflow: hidden;
            cursor: pointer;
            border: 3px solid transparent;
            transition: var(--transition);
            background: var(--white);
            box-shadow: var(--shadow-sm);
        }
        
        .thumbnail-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: var(--transition);
        }
        
        .thumbnail-item:hover {
            border-color: rgba(201, 169, 98, 0.5);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }
        
        .thumbnail-item.active {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 2px rgba(201, 169, 98, 0.3);
        }
        
        /* Product Info */
        .product-info {
            padding: 1.5rem 2rem;
            background: var(--white);
        }
        
        .product-header {
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--light-bg);
        }
        
        .product-category {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: linear-gradient(135deg, rgba(201, 169, 98, 0.1), rgba(201, 169, 98, 0.05));
            color: var(--accent-dark);
            padding: 0.5rem 1.2rem;
            border-radius: 25px;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 1rem;
            border: 1px solid rgba(201, 169, 98, 0.2);
        }
        
        .product-title {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--text-dark);
            line-height: 1.2;
            margin: 0 0 1rem 0;
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .product-subtitle {
            color: var(--text-body);
            font-size: 1.1rem;
            font-weight: 400;
            margin: 0;
        }
        
        /* Rating */
        .product-rating {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
            padding: 1rem;
            background: var(--light-bg);
            border-radius: var(--radius-lg);
            border-left: 4px solid var(--accent-color);
        }
        
        .stars-container {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .stars {
            display: flex;
            gap: 2px;
            color: #ffc107;
            font-size: 1.2rem;
        }
        
        .rating-info {
            color: var(--text-body);
            font-size: 1rem;
            font-weight: 500;
        }
        
        .rating-divider {
            color: var(--border-color);
            margin: 0 0.5rem;
        }
        
        /* Price */
        .price-section {
            margin-bottom: 1rem;
            padding: 1rem 1.5rem;
            background: linear-gradient(135deg, rgba(201, 169, 98, 0.05), rgba(201, 169, 98, 0.02));
            border-radius: var(--radius-lg);
            border: 1px solid rgba(201, 169, 98, 0.1);
        }
        
        .price-label {
            color: var(--text-body);
            font-size: 1rem;
            font-weight: 500;
            margin-bottom: 0.5rem;
            display: block;
        }
        
        .price-value {
            font-size: 2.5rem;
            font-weight: 800;
            color: var(--accent-dark);
            font-family: 'Inter', sans-serif;
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .price-original {
            font-size: 1.5rem;
            color: var(--text-muted);
            text-decoration: line-through;
            margin-left: 1rem;
            font-weight: 500;
        }
        
        .price-save {
            display: block;
            color: var(--success-color);
            font-size: 1rem;
            font-weight: 600;
            margin-top: 0.5rem;
        }
        
        /* Description */
        .product-description {
            margin-bottom: 1rem;
            padding: 1rem;
            background: rgba(255, 255, 255, 0.7);
            border-radius: var(--radius-lg);
            border-left: 4px solid var(--info-color);
        }
        
        .description-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .description-text {
            color: var(--text-body);
            line-height: 1.7;
            margin: 0;
            font-size: 1rem;
        }
        
        /* Options */
        .options-section {
            margin-bottom: 2.5rem;
        }
        
        .option-group {
            margin-bottom: 1rem;
            padding: 1rem;
            background: var(--light-bg);
            border-radius: var(--radius-lg);
        }
        
        .option-label {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 1rem;
            font-size: 1.1rem;
        }
        
        /* Color Options */
        .color-options {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }
        
        .color-item {
            position: relative;
            cursor: pointer;
        }
        
        .color-item input {
            position: absolute;
            opacity: 0;
            pointer-events: none;
        }
        
        .color-circle {
            display: block;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            transition: var(--transition);
            box-shadow: var(--shadow-md);
            border: 3px solid transparent;
        }
        
        .color-item input:checked + .color-circle {
            border-color: var(--accent-color);
            transform: scale(1.15);
            box-shadow: 0 0 0 3px rgba(201, 169, 98, 0.3);
        }
        
        .color-item:hover .color-circle {
            transform: scale(1.1);
        }
        
        /* Size Options */
        .size-options {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }
        
        .size-item {
            position: relative;
            cursor: pointer;
        }
        
        .size-item input {
            position: absolute;
            opacity: 0;
            pointer-events: none;
        }
        
        .size-item span {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 60px;
            height: 60px;
            border: 2px solid var(--border-color);
            border-radius: var(--radius);
            font-weight: 700;
            font-size: 1.1rem;
            color: var(--text-body);
            background: var(--white);
            transition: var(--transition);
            box-shadow: var(--shadow-sm);
        }
        
        .size-item input:checked + span {
            border-color: var(--accent-color);
            background: var(--accent-color);
            color: var(--white);
            transform: scale(1.05);
            box-shadow: var(--shadow-md);
        }
        
        .size-item:hover span {
            border-color: var(--accent-color);
            transform: translateY(-2px);
        }
        
        /* Quantity */
        .quantity-container {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .qty-selector {
            display: flex;
            align-items: center;
            border: 2px solid var(--border-color);
            border-radius: var(--radius-lg);
            overflow: hidden;
            background: var(--white);
            box-shadow: var(--shadow-sm);
        }
        
        .qty-btn {
            width: 50px;
            height: 50px;
            border: none;
            background: var(--white);
            color: var(--text-body);
            font-size: 1.3rem;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
        }
        
        .qty-btn:hover {
            background: var(--accent-color);
            color: var(--white);
        }
        
        .qty-input {
            width: 80px;
            height: 50px;
            border: none;
            border-left: 2px solid var(--border-color);
            border-right: 2px solid var(--border-color);
            text-align: center;
            font-weight: 700;
            font-size: 1.2rem;
            background: var(--light-bg);
            color: var(--text-dark);
        }
        
        /* Action Buttons */
        .action-buttons {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }
        
        .btn-action {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
            padding: 1.25rem 2rem;
            border: none;
            border-radius: var(--radius-lg);
            font-weight: 700;
            font-size: 1.1rem;
            cursor: pointer;
            transition: var(--transition);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            position: relative;
            overflow: hidden;
        }
        
        .btn-action::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }
        
        .btn-action:hover::before {
            left: 100%;
        }
        
        .btn-cart {
            background: linear-gradient(135deg, var(--accent-color), var(--accent-light));
            color: var(--white);
            box-shadow: 0 6px 20px rgba(201, 169, 98, 0.4);
        }
        
        .btn-cart:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(201, 169, 98, 0.5);
        }
        
        .btn-buy {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--white);
            box-shadow: 0 6px 20px rgba(44, 62, 80, 0.3);
        }
        
        .btn-buy:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(44, 62, 80, 0.4);
        }
        
        /* Features */
        .product-features {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
            padding: 1rem;
            background: linear-gradient(135deg, var(--light-bg), rgba(248, 249, 250, 0.5));
            border-radius: var(--radius-lg);
            border: 1px solid rgba(0,0,0,0.05);
        }
        
        .feature-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            color: var(--text-body);
            font-size: 1rem;
            font-weight: 500;
        }
        
        .feature-icon {
            width: 45px;
            height: 45px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, var(--accent-color), var(--accent-light));
            color: var(--white);
            border-radius: var(--radius);
            font-size: 1.2rem;
            box-shadow: var(--shadow-sm);
        }
        
        /* Reviews Section */
        .reviews-section {
            background: var(--white);
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-lg);
            overflow: hidden;
            margin-top: 3rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .reviews-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--white);
            padding: 2rem;
            position: relative;
        }
        
        .reviews-header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 20px;
            background: var(--white);
            border-radius: 50% 50% 0 0 / 100% 100% 0 0;
        }
        
        .section-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            font-weight: 700;
            margin: 0;
            position: relative;
            z-index: 2;
        }
        
        .review-count {
            font-size: 1rem;
            font-weight: 400;
            opacity: 0.9;
            margin-left: 0.5rem;
        }
        
        .reviews-body {
            padding: 2.5rem;
        }
        
        /* Review Summary */
        .review-summary {
            margin-bottom: 3rem;
            padding: 2rem;
            background: var(--light-bg);
            border-radius: var(--radius-lg);
        }
        
        .avg-rating-display {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .big-rating {
            font-size: 4rem;
            font-weight: 800;
            color: var(--accent-dark);
            line-height: 1;
        }
        
        .out-of {
            font-size: 2rem;
            color: var(--text-muted);
            font-weight: 500;
        }
        
        .stars-display {
            font-size: 1.5rem;
            margin: 1rem 0;
        }
        
        /* Write Review */
        .write-review-box {
            background: rgba(255, 255, 255, 0.7);
            padding: 2rem;
            border-radius: var(--radius-lg);
            border: 1px solid rgba(0,0,0,0.05);
        }
        
        .write-review-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        /* Star Rating Input */
        .star-rating-input {
            display: flex;
            flex-direction: row-reverse;
            justify-content: flex-end;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }
        
        .star-rating-input input {
            display: none;
        }
        
        .star-rating-input label {
            cursor: pointer;
            font-size: 2rem;
            color: #ddd;
            transition: var(--transition);
        }
        
        .star-rating-input label:hover,
        .star-rating-input label:hover ~ label,
        .star-rating-input input:checked ~ label {
            color: #ffc107;
            transform: scale(1.1);
        }
        
        .btn-submit-review {
            background: linear-gradient(135deg, var(--accent-color), var(--accent-light));
            border: none;
            color: var(--white);
            padding: 0.75rem 2rem;
            font-weight: 600;
            border-radius: var(--radius);
            transition: var(--transition);
        }
        
        .btn-submit-review:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }
        
        /* Review Items */
        .reviews-list {
            margin-top: 2rem;
        }
        
        .review-item {
            padding: 2rem;
            border-bottom: 1px solid var(--border-color);
            transition: var(--transition);
        }
        
        .review-item:hover {
            background: rgba(248, 249, 250, 0.5);
        }
        
        .review-item:last-child {
            border-bottom: none;
        }
        
        .reviewer-info {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }
        
        .reviewer-avatar {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--accent-color), var(--accent-light));
            color: var(--white);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 1.2rem;
            box-shadow: var(--shadow-sm);
        }
        
        .reviewer-details h6 {
            margin: 0;
            font-weight: 600;
            color: var(--text-dark);
        }
        
        .review-meta {
            display: flex;
            align-items: center;
            gap: 1rem;
            font-size: 0.9rem;
            color: var(--text-muted);
            margin-top: 0.25rem;
        }
        
        .review-stars {
            font-size: 1rem;
        }
        
        .review-content {
            color: var(--text-body);
            line-height: 1.7;
            margin: 0;
            font-size: 1rem;
        }
        
        /* Alerts */
        .alert {
            border-radius: var(--radius-lg);
            border: none;
            padding: 1rem 1.5rem;
            font-weight: 500;
            margin-bottom: 2rem;
        }
        
        .alert-success {
            background: rgba(39, 174, 96, 0.1);
            color: var(--success-color);
            border-left: 4px solid var(--success-color);
        }
        
        .alert-danger {
            background: rgba(231, 76, 60, 0.1);
            color: var(--danger-color);
            border-left: 4px solid var(--danger-color);
        }
        
        .alert-info {
            background: rgba(52, 152, 219, 0.1);
            color: var(--info-color);
            border-left: 4px solid var(--info-color);
        }
        
        /* Form Controls */
        .form-control {
            border-radius: var(--radius);
            border: 2px solid var(--border-color);
            padding: 0.75rem 1rem;
            transition: var(--transition);
            font-size: 1rem;
        }
        
        .form-control:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 0.2rem rgba(201, 169, 98, 0.25);
        }
        
        .form-label {
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 0.5rem;
        }
        
        /* Responsive Design */
        @media (max-width: 991.98px) {
            .product-title {
                font-size: 2rem;
            }
            
            .price-value {
                font-size: 2rem;
            }
            
            .action-buttons {
                grid-template-columns: 1fr;
            }
            
            .product-features {
                grid-template-columns: 1fr;
            }
        }
        
        @media (max-width: 767.98px) {
            .product-detail-section {
                padding: 2rem 0;
            }
            
            .product-info {
                padding: 2rem;
            }
            
            .product-title {
                font-size: 1.75rem;
            }
            
            .thumbnails-grid {
                grid-template-columns: repeat(4, 1fr);
                gap: 0.75rem;
            }
            
            .color-options,
            .size-options {
                justify-content: center;
            }
            
            .big-rating {
                font-size: 3rem;
            }
            
            .reviews-body {
                padding: 1.5rem;
            }
        }
        
        /* Loading Animation */
        .loading {
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.5; }
            100% { opacity: 1; }
        }
        
        /* Smooth Animations - only for interactive elements */
        .btn, .btn-action, .thumbnail-item, .size-item span, .color-circle, .wishlist-btn, a {
            transition: color 0.2s ease, background-color 0.2s ease, border-color 0.2s ease, transform 0.2s ease;
        }
    </style>
</head>
<body>
    <jsp:include page="/includes/header.jsp" />
    
    <!-- Breadcrumb -->
    <div class="breadcrumb-section" data-aos="fade-down">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/home">
                            <i class="bi bi-house me-2"></i>Trang Chủ
                        </a>
                    </li>
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/products">Sản Phẩm</a>
                    </li>
                    <li class="breadcrumb-item active">
                        <c:out value="${product.name}"/>
                    </li>
                </ol>
            </nav>
        </div>
    </div>
    
    <!-- Product Detail Main -->
    <section class="product-detail-section">
        <div class="container">
            <!-- Messages -->
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert" data-aos="shake">
                    <i class="bi bi-check-circle me-2"></i><c:out value="${sessionScope.successMessage}"/>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="successMessage" scope="session"/>
            </c:if>
            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert" data-aos="shake">
                    <i class="bi bi-exclamation-circle me-2"></i><c:out value="${sessionScope.errorMessage}"/>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="errorMessage" scope="session"/>
            </c:if>
            
            <div class="row g-4">
                <!-- Product Gallery - Left -->
                <div class="col-lg-6">
                    <div class="product-card" data-aos="fade-right">
                        <div class="product-gallery">
                            <!-- Main Image -->
                            <div class="main-image-container">
                                <div class="product-badges">
                                    <span class="badge-new">Mới</span>
                                    <span class="badge-sale">-20%</span>
                                </div>
                                <button class="wishlist-btn" onclick="toggleWishlist(${product.id}, this)">
                                    <i class="bi bi-heart"></i>
                                </button>
                                <img id="mainImage" 
                                     src="${pageContext.request.contextPath}${product.thumbnailUrl != null ? product.thumbnailUrl : '/assets/images/placeholder.jpg'}" 
                                     alt="<c:out value='${product.name}'/>" 
                                     class="main-image">
                            </div>
                            
                            <!-- Thumbnails -->
                            <div class="thumbnails-grid">
                                <div class="thumbnail-item active" onclick="changeMainImage(this)">
                                    <img src="${pageContext.request.contextPath}${product.thumbnailUrl != null ? product.thumbnailUrl : '/assets/images/placeholder.jpg'}" alt="Hình chính">
                                </div>
                                <div class="thumbnail-item" onclick="changeMainImage(this)">
                                    <img src="https://images.unsplash.com/photo-1434389677669-e08b4cac3105?w=400&q=80" alt="Chi tiết 1">
                                </div>
                                <div class="thumbnail-item" onclick="changeMainImage(this)">
                                    <img src="https://images.unsplash.com/photo-1485968579580-b6d095142e6e?w=400&q=80" alt="Chi tiết 2">
                                </div>
                                <div class="thumbnail-item" onclick="changeMainImage(this)">
                                    <img src="https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=400&q=80" alt="Chi tiết 3">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Product Info - Right -->
                <div class="col-lg-6">
                    <div class="product-card" data-aos="fade-left">
                        <div class="product-info">
                            <!-- Product Header -->
                            <div class="product-header">
                                <span class="product-category">
                                    <i class="bi bi-tag me-2"></i>Thời Trang
                                </span>
                                <h1 class="product-title"><c:out value="${product.name}"/></h1>
                                <p class="product-subtitle">Chất lượng cao, thiết kế hiện đại</p>
                            </div>
                            
                            <!-- Rating -->
                            <div class="product-rating">
                                <div class="stars-container">
                                    <div class="stars">
                                        <c:forEach begin="1" end="5" var="i">
                                            <c:choose>
                                                <c:when test="${i <= avgRating}">
                                                    <i class="bi bi-star-fill"></i>
                                                </c:when>
                                                <c:when test="${i - 0.5 <= avgRating}">
                                                    <i class="bi bi-star-half"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="bi bi-star"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </div>
                                    <span class="rating-info">
                                        <fmt:formatNumber value="${avgRating}" maxFractionDigits="1"/> 
                                        <span class="rating-divider">|</span> 
                                        ${reviewCount} Đánh giá
                                    </span>
                                </div>
                            </div>
                            
                            <!-- Price -->
                            <div class="price-section">
                                <span class="price-label">
                                    <i class="bi bi-tag-fill me-2"></i>Giá bán:
                                </span>
                                <div class="d-flex align-items-center">
                                    <span class="price-value">
                                        <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" maxFractionDigits="0"/>₫
                                    </span>
                                    <span class="price-original">
                                        <fmt:formatNumber value="${product.price * 1.25}" type="number" groupingUsed="true" maxFractionDigits="0"/>₫
                                    </span>
                                </div>
                                <span class="price-save">
                                    <i class="bi bi-piggy-bank me-1"></i>
                                    Tiết kiệm: <fmt:formatNumber value="${product.price * 0.25}" type="number" groupingUsed="true" maxFractionDigits="0"/>₫
                                </span>
                            </div>
                            
                            <!-- Description -->
                            <div class="product-description">
                                <h6 class="description-title">
                                    <i class="bi bi-info-circle"></i>Mô tả sản phẩm
                                </h6>
                                <p class="description-text"><c:out value="${product.description}"/></p>
                            </div>
                            
                            <!-- Options Form -->
                            <form action="${pageContext.request.contextPath}/cart/add" method="POST" class="product-form" id="productForm">
                                <input type="hidden" name="productId" value="${product.id}">
                                
                                <div class="options-section">
                                    <!-- Color -->
                                    <div class="option-group">
                                        <label class="option-label">
                                            <i class="bi bi-palette"></i>Màu sắc:
                                        </label>
                                        <div class="color-options">
                                            <label class="color-item" title="Đen">
                                                <input type="radio" name="color" value="black" checked>
                                                <span class="color-circle" style="background: #1a1a1a;"></span>
                                            </label>
                                            <label class="color-item" title="Trắng">
                                                <input type="radio" name="color" value="white">
                                                <span class="color-circle" style="background: #ffffff; border: 2px solid #ddd;"></span>
                                            </label>
                                            <label class="color-item" title="Navy">
                                                <input type="radio" name="color" value="navy">
                                                <span class="color-circle" style="background: #1e3a5f;"></span>
                                            </label>
                                            <label class="color-item" title="Nâu">
                                                <input type="radio" name="color" value="brown">
                                                <span class="color-circle" style="background: #8b5a2b;"></span>
                                            </label>
                                            <label class="color-item" title="Be">
                                                <input type="radio" name="color" value="beige">
                                                <span class="color-circle" style="background: #d4c4a8;"></span>
                                            </label>
                                        </div>
                                    </div>
                                    
                                    <!-- Size -->
                                    <div class="option-group">
                                        <label class="option-label">
                                            <i class="bi bi-rulers"></i>Kích thước:
                                        </label>
                                        <div class="size-options">
                                            <label class="size-item">
                                                <input type="radio" name="size" value="S" required>
                                                <span>S</span>
                                            </label>
                                            <label class="size-item">
                                                <input type="radio" name="size" value="M" checked required>
                                                <span>M</span>
                                            </label>
                                            <label class="size-item">
                                                <input type="radio" name="size" value="L" required>
                                                <span>L</span>
                                            </label>
                                            <label class="size-item">
                                                <input type="radio" name="size" value="XL" required>
                                                <span>XL</span>
                                            </label>
                                        </div>
                                    </div>
                                    
                                    <!-- Quantity -->
                                    <div class="option-group">
                                        <label class="option-label">
                                            <i class="bi bi-123"></i>Số lượng:
                                        </label>
                                        <div class="quantity-container">
                                            <div class="qty-selector">
                                                <button type="button" class="qty-btn" onclick="changeQty(-1)">
                                                    <i class="bi bi-dash"></i>
                                                </button>
                                                <input type="number" name="quantity" id="qtyInput" value="1" min="1" max="99" class="qty-input" readonly>
                                                <button type="button" class="qty-btn" onclick="changeQty(1)">
                                                    <i class="bi bi-plus"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Action Buttons -->
                                <div class="action-buttons">
                                    <button type="submit" class="btn-action btn-cart">
                                        <i class="bi bi-bag-plus"></i>
                                        Thêm vào giỏ
                                    </button>
                                    <button type="button" class="btn-action btn-buy" onclick="buyNow()">
                                        <i class="bi bi-lightning-fill"></i>
                                        Mua ngay
                                    </button>
                                </div>
                            </form>
                            
                            <!-- Features -->
                            <div class="product-features">
                                <div class="feature-item">
                                    <div class="feature-icon">
                                        <i class="bi bi-truck"></i>
                                    </div>
                                    <span>Miễn phí giao hàng</span>
                                </div>
                                <div class="feature-item">
                                    <div class="feature-icon">
                                        <i class="bi bi-arrow-repeat"></i>
                                    </div>
                                    <span>Đổi trả 7 ngày</span>
                                </div>
                                <div class="feature-item">
                                    <div class="feature-icon">
                                        <i class="bi bi-shield-check"></i>
                                    </div>
                                    <span>Bảo hành chính hãng</span>
                                </div>
                                <div class="feature-item">
                                    <div class="feature-icon">
                                        <i class="bi bi-headset"></i>
                                    </div>
                                    <span>Hỗ trợ 24/7</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Reviews Section -->
            <div class="reviews-section" data-aos="fade-up" data-aos-delay="200">
                <div class="reviews-header">
                    <h3 class="section-title">
                        <i class="bi bi-chat-quote me-3"></i>Đánh Giá Sản Phẩm
                        <span class="review-count">(${reviewCount} đánh giá)</span>
                    </h3>
                </div>
                
                <div class="reviews-body">
                    <!-- Review Summary -->
                    <div class="review-summary">
                        <div class="row align-items-center">
                            <div class="col-md-4">
                                <div class="avg-rating-display">
                                    <span class="big-rating"><fmt:formatNumber value="${avgRating}" maxFractionDigits="1"/></span>
                                    <span class="out-of">/5</span>
                                </div>
                                <div class="stars-display text-center">
                                    <c:forEach begin="1" end="5" var="i">
                                        <c:choose>
                                            <c:when test="${i <= avgRating}">
                                                <i class="bi bi-star-fill text-warning"></i>
                                            </c:when>
                                            <c:when test="${i - 0.5 <= avgRating}">
                                                <i class="bi bi-star-half text-warning"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="bi bi-star text-warning"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                                <p class="text-muted text-center mt-2">${reviewCount} đánh giá</p>
                            </div>
                            <div class="col-md-8">
                                <!-- Write Review Form -->
                                <c:choose>
                                    <c:when test="${empty sessionScope.user}">
                                        <div class="alert alert-info">
                                            <i class="bi bi-info-circle me-2"></i>
                                            <a href="${pageContext.request.contextPath}/login" class="text-decoration-none fw-bold">Đăng nhập</a> để đánh giá sản phẩm này.
                                        </div>
                                    </c:when>
                                    <c:when test="${hasReviewed}">
                                        <div class="alert alert-success">
                                            <i class="bi bi-check-circle me-2"></i>
                                            Bạn đã đánh giá sản phẩm này. Cảm ơn bạn!
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="write-review-box">
                                            <h5 class="write-review-title">
                                                <i class="bi bi-pencil-square"></i>Viết Đánh Giá
                                            </h5>
                                            <form action="${pageContext.request.contextPath}/review" method="POST" id="reviewForm">
                                                <input type="hidden" name="productId" value="${product.id}">
                                                
                                                <div class="mb-3">
                                                    <label class="form-label">Đánh giá của bạn:</label>
                                                    <div class="star-rating-input">
                                                        <input type="radio" name="rating" value="5" id="star5" required>
                                                        <label for="star5" title="5 sao"><i class="bi bi-star-fill"></i></label>
                                                        <input type="radio" name="rating" value="4" id="star4">
                                                        <label for="star4" title="4 sao"><i class="bi bi-star-fill"></i></label>
                                                        <input type="radio" name="rating" value="3" id="star3">
                                                        <label for="star3" title="3 sao"><i class="bi bi-star-fill"></i></label>
                                                        <input type="radio" name="rating" value="2" id="star2">
                                                        <label for="star2" title="2 sao"><i class="bi bi-star-fill"></i></label>
                                                        <input type="radio" name="rating" value="1" id="star1">
                                                        <label for="star1" title="1 sao"><i class="bi bi-star-fill"></i></label>
                                                    </div>
                                                </div>
                                                
                                                <div class="mb-3">
                                                    <label for="comment" class="form-label">Nhận xét:</label>
                                                    <textarea class="form-control" name="comment" id="comment" rows="4" 
                                                        placeholder="Chia sẻ trải nghiệm của bạn về sản phẩm này..."></textarea>
                                                </div>
                                                
                                                <button type="submit" class="btn-submit-review">
                                                    <i class="bi bi-send me-2"></i>Gửi Đánh Giá
                                                </button>
                                            </form>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Reviews List -->
                    <div class="reviews-list">
                        <c:choose>
                            <c:when test="${empty reviews}">
                                <div class="text-center py-5">
                                    <i class="bi bi-chat-dots display-4 text-muted"></i>
                                    <p class="text-muted mt-3 fs-5">Chưa có đánh giá nào. Hãy là người đầu tiên đánh giá sản phẩm này!</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="review" items="${reviews}">
                                    <div class="review-item">
                                        <div class="reviewer-info">
                                            <div class="reviewer-avatar">
                                                ${review.user.fullName.charAt(0)}
                                            </div>
                                            <div class="reviewer-details">
                                                <h6 class="mb-0">${review.user.fullName}</h6>
                                                <div class="review-meta">
                                                    <span class="review-stars">
                                                        <c:forEach begin="1" end="5" var="i">
                                                            <i class="bi bi-star${i <= review.rating ? '-fill' : ''} text-warning"></i>
                                                        </c:forEach>
                                                    </span>
                                                    <span class="text-muted">
                                                        <i class="bi bi-calendar3 me-1"></i>
                                                        <fmt:formatDate value="${review.createdAt}" pattern="dd/MM/yyyy"/>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="review-content mt-3">
                                            <p><c:out value="${review.comment}"/></p>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <jsp:include page="/includes/footer.jsp" />
    
    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- AOS Animation -->
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    
    <script>
        // Initialize AOS
        AOS.init({
            duration: 800,
            once: true,
            offset: 100
        });
        
        // ISOLATED MANUAL DROPDOWN TOGGLE
        document.addEventListener('DOMContentLoaded', function() {
            // Tìm nút user menu
            const userBtn = document.querySelector('.user-menu .dropdown-toggle');
            if (userBtn) {
                // Remove bootstrap trigger để tránh xung đột
                userBtn.removeAttribute('data-bs-toggle');
                
                // Add sự kiện click thủ công
                userBtn.addEventListener('click', function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    
                    const menu = this.nextElementSibling;
                    const isShown = menu.classList.contains('show');
                    
                    // Đóng tất cả menu đang mở
                    document.querySelectorAll('.dropdown-menu.show').forEach(m => {
                        m.classList.remove('show');
                        m.style.display = 'none';
                    });
                    
                    // Toggle menu hiện tại
                    if (!isShown) {
                        menu.classList.add('show');
                        menu.style.display = 'block';
                        // Đảm bảo z-index cao nhất
                        menu.style.zIndex = '99999';
                    }
                });
            }
            
            // Đóng khi click ra ngoài
            document.addEventListener('click', function(e) {
                if (!e.target.closest('.user-menu')) {
                    document.querySelectorAll('.user-menu .dropdown-menu.show').forEach(m => {
                        m.classList.remove('show');
                        m.style.display = 'none';
                    });
                }
            });
        });
        
        // Header scroll effect
        window.addEventListener('scroll', function() {
            const header = document.querySelector('.main-header');
            if (header) {
                header.classList.toggle('scrolled', window.scrollY > 50);
            }
        });
        
        // Change main image
        function changeMainImage(el) {
            const img = el.querySelector('img');
            const mainImg = document.getElementById('mainImage');
            if (img && mainImg) {
                mainImg.src = img.src.replace('w=400', 'w=800');
                
                // Update active thumbnail
                document.querySelectorAll('.thumbnail-item').forEach(t => t.classList.remove('active'));
                el.classList.add('active');
                
                // Add animation
                mainImg.style.opacity = '0.7';
                setTimeout(() => {
                    mainImg.style.opacity = '1';
                }, 200);
            }
        }
        
        // Quantity controls
        function changeQty(delta) {
            const input = document.getElementById('qtyInput');
            if (input) {
                let val = parseInt(input.value) + delta;
                if (val >= 1 && val <= 99) {
                    input.value = val;
                    
                    // Add animation
                    input.style.transform = 'scale(1.1)';
                    setTimeout(() => {
                        input.style.transform = 'scale(1)';
                    }, 200);
                }
            }
        }
        
        // Buy now function
        function buyNow() {
            const form = document.getElementById('productForm');
            if (form) {
                // Add loading state
                const buyBtn = document.querySelector('.btn-buy');
                if (buyBtn) {
                    const originalText = buyBtn.innerHTML;
                    buyBtn.innerHTML = '<i class="bi bi-arrow-repeat me-2 loading"></i>Đang xử lý...';
                    buyBtn.disabled = true;
                    
                    // Change form action and submit
                    form.action = '${pageContext.request.contextPath}/checkout';
                    form.submit();
                }
            }
        }
        
        // Wishlist toggle
        function toggleWishlist(id, btn) {
            const icon = btn.querySelector('i');
            if (icon) {
                btn.classList.toggle('active');
                icon.classList.toggle('bi-heart');
                icon.classList.toggle('bi-heart-fill');
                
                // Add animation
                btn.style.transform = 'scale(1.2)';
                setTimeout(() => {
                    btn.style.transform = 'scale(1)';
                }, 200);
                
                // Show feedback
                const isActive = btn.classList.contains('active');
                showToast(isActive ? 'Đã thêm vào yêu thích!' : 'Đã xóa khỏi yêu thích!');
            }
        }
        
        // Form submission with loading state
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('productForm');
            if (form) {
                form.addEventListener('submit', function(e) {
                    const cartBtn = this.querySelector('.btn-cart');
                    if (cartBtn) {
                        const originalText = cartBtn.innerHTML;
                        cartBtn.innerHTML = '<i class="bi bi-arrow-repeat me-2 loading"></i>Đang thêm...';
                        cartBtn.disabled = true;
                        
                        // Re-enable after 3 seconds (in case of error)
                        setTimeout(() => {
                            cartBtn.innerHTML = originalText;
                            cartBtn.disabled = false;
                        }, 3000);
                    }
                });
            }
            
            // Review form submission
            const reviewForm = document.getElementById('reviewForm');
            if (reviewForm) {
                reviewForm.addEventListener('submit', function(e) {
                    const submitBtn = this.querySelector('.btn-submit-review');
                    if (submitBtn) {
                        const originalText = submitBtn.innerHTML;
                        submitBtn.innerHTML = '<i class="bi bi-arrow-repeat me-2 loading"></i>Đang gửi...';
                        submitBtn.disabled = true;
                        
                        // Re-enable after 3 seconds (in case of error)
                        setTimeout(() => {
                            submitBtn.innerHTML = originalText;
                            submitBtn.disabled = false;
                        }, 3000);
                    }
                });
            }
        });
        
        // Toast notification function
        function showToast(message) {
            // Create toast element
            const toast = document.createElement('div');
            toast.className = 'toast-notification';
            toast.innerHTML = '<div class="toast-content"><i class="bi bi-check-circle me-2"></i>' + message + '</div>';
            
            // Add styles
            toast.style.cssText = 'position: fixed; top: 100px; right: 20px; background: linear-gradient(135deg, var(--success-color), #2ecc71); color: white; padding: 1rem 1.5rem; border-radius: 10px; box-shadow: 0 4px 20px rgba(0,0,0,0.2); z-index: 10000; transform: translateX(100%); transition: transform 0.3s ease; font-weight: 500;';
            
            document.body.appendChild(toast);
            
            // Show toast
            setTimeout(() => {
                toast.style.transform = 'translateX(0)';
            }, 100);
            
            // Hide and remove toast
            setTimeout(() => {
                toast.style.transform = 'translateX(100%)';
                setTimeout(() => {
                    if (document.body.contains(toast)) {
                        document.body.removeChild(toast);
                    }
                }, 300);
            }, 3000);
        }
        
        // Image zoom on hover
        document.addEventListener('DOMContentLoaded', function() {
            const mainImage = document.getElementById('mainImage');
            if (mainImage) {
                mainImage.addEventListener('mouseenter', function() {
                    this.style.cursor = 'zoom-in';
                });
                
                mainImage.addEventListener('click', function() {
                    // Simple image zoom modal could be added here
                    showToast('Tính năng zoom ảnh sẽ được cập nhật!');
                });
            }
        });
    </script>
</body>
</html>