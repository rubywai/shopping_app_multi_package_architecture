# Shopping App - Multi-Package Architecture

A Flutter e-commerce application built with multi-package architecture using WooCommerce REST API.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Packages](#packages)
- [Getting Started](#getting-started)
- [API Documentation](#api-documentation)
- [Dependencies](#dependencies)

---

## Overview

This is a modern Flutter shopping application that demonstrates clean architecture principles with a multi-package approach. The app fetches product data from WooCommerce REST API and provides a smooth shopping experience with product browsing, search, filtering by categories, and detailed product views.

**Tech Stack:**
- Flutter
- Riverpod (State Management)
- GoRouter (Navigation)
- Dio (HTTP Client)
- GetIt (Dependency Injection)
- WooCommerce REST API

---

## Features

### Authentication & User Management
- ✅ User registration with email and password
- ✅ User login with JWT authentication
- ✅ Secure token storage (SharedPreferences)
- ✅ Auto-login on app restart
- ✅ User logout functionality
- ✅ Auth state persistence
- ✅ Guest browsing (browse products and add to cart without login)
- ✅ Auth required only for checkout and profile features
- ✅ Automatic redirect to login when accessing protected features

### Product Management
- ✅ Product list with grid view
- ✅ Product detail with image carousel
- ✅ Product search with real-time filtering
- ✅ Category listing and browsing
- ✅ Category-based product filtering
- ✅ Pagination support with load more
- ✅ Product variations support (size, color)
- ✅ Product attributes display

### Shopping Cart
- ✅ Add to cart with quantity selection (works for both guest and logged-in users)
- ✅ Cart item management (add, update, remove)
- ✅ Local cart storage (SQLite)
- ✅ Cart badge with item count
- ✅ Cart total calculation
- ✅ Persistent cart across sessions
- ✅ Guest cart support with local persistence
- ✅ Clear cart after successful order

### User Profile
- ✅ View customer profile information (requires login)
- ✅ Automatic redirect to login for guest users
- ✅ Edit customer information (name, phone, address)
- ✅ Edit billing address
- ✅ Customer data auto-load from WooCommerce
- ✅ Profile auto-fill in checkout

### Checkout & Orders
- ✅ Complete checkout flow (requires login)
- ✅ Automatic redirect to login for guest users at checkout
- ✅ Billing address form with validation
- ✅ Shipping address (same as billing or separate)
- ✅ Shipping method selection with costs
- ✅ Payment method selection (COD, Bank Transfer)
- ✅ Order notes (optional)
- ✅ Order summary with totals
- ✅ Create order via WooCommerce API
- ✅ Cart clearing after successful order

### Shipping
- ✅ Shipping zone support
- ✅ Multiple shipping methods (flat rate, free shipping)
- ✅ Dynamic shipping cost calculation
- ✅ Shipping method selector widget
- ✅ Zone-based method filtering

### UI/UX
- ✅ Image carousel with indicators
- ✅ Size and color selection for variable products
- ✅ Loading states and error handling
- ✅ Bottom navigation with 4 tabs (Products, Categories, Cart, Profile)
- ✅ Responsive design
- ✅ Pull-to-refresh
- ✅ Empty state handling
- ✅ Success/error snackbar messages

### Performance
- ✅ Optimized API calls with field filtering
- ✅ Image caching
- ✅ Debounced search
- ✅ Lazy loading with pagination
- ✅ Local database for cart persistence
- ✅ Efficient state management with Riverpod

---

## Architecture

This project follows a **feature-based multi-package architecture** to achieve modularity, reusability, and separation of concerns.

```
┌──────────────────────────────────────────────────────────────────┐
│                          Main App                                │
│                     (Shopping App Root)                          │
│              Routes | DI Setup | Bottom Navigation               │
└───────────────────────────┬──────────────────────────────────────┘
                            │
        ┌───────────────────┼───────────────────┬─────────────┐
        │                   │                   │             │
   ┌────▼────┐         ┌────▼────┐        ┌────▼────┐   ┌────▼────┐
   │ Common  │         │Products │        │  Auth   │   │  Cart   │
   │ Package │         │ Package │        │ Package │   │ Package │
   └────┬────┘         └────┬────┘        └────┬────┘   └────┬────┘
        │                   │                   │             │
        │         ┌─────────┼──────────┬────────┼─────────────┤
        │         │         │          │        │             │
   ┌────▼────┐   │    ┌────▼────┐ ┌───▼────┐   │        ┌────▼────┐
   │Shipping │   │    │ Profile │ │ Orders │   │        │         │
   │ Package │   │    │ Package │ │Package │   │        │         │
   └─────────┘   │    └─────────┘ └────────┘   │        │         │
                 │                              │        │         │
   ┌─────────────┴──────────────────────────────┴────────┴─────────┐
   │            Each Package Contains:                              │
   │   - UI (Pages, Widgets)                                        │
   │   - Providers (State Management - Riverpod)                    │
   │   - Models (Data Models)                                       │
   │   - Services (API Calls - Dio)                                 │
   │   - DI (Dependency Injection - GetIt)                          │
   └────────────────────────────────────────────────────────────────┘
```

### Key Principles

- **Modularity:** Each feature is a separate package
- **Reusability:** Common utilities shared across features
- **Separation of Concerns:** Clear boundaries between features
- **Scalability:** Easy to add new features as packages
- Planned: Deferred components (on-demand package loading) to load feature packages only when needed and reduce initial app size.

---

## Project Structure

```
shopping_app_multi_package_based_architecture/
├── lib/
│   ├── main.dart                    # App entry point
│   └── routes/
│       └── routes.dart              # GoRouter configuration
├── packages/
│   ├── common/                      # Shared utilities
│   │   ├── lib/
│   │   │   ├── src/
│   │   │   │   ├── const/          # Constants
│   │   │   │   ├── dependency/     # DI setup
│   │   │   │   └── widgets/        # Shared widgets
│   │   │   └── common.dart         # Package exports
│   │   └── pubspec.yaml
│   ├── products/                    # Products feature
│   │   ├── lib/
│   │   │   ├── src/
│   │   │   │   ├── data/
│   │   │   │   │   ├── models/     # Data models
│   │   │   │   │   └── services/   # API services
│   │   │   │   ├── providers/      # State management
│   │   │   │   └── ui/
│   │   │   │       ├── pages/      # Screens
│   │   │   │       └── widgets/    # UI components
│   │   │   └── products.dart       # Package exports
│   │   └── pubspec.yaml
│   └── shipping/                    # Shipping feature
│       ├── lib/
│       │   ├── src/
│       │   │   ├── data/
│       │   │   │   ├── models/     # Shipping models
│       │   │   │   └── services/   # Shipping API
│       │   │   ├── providers/      # Shipping state
│       │   │   └── ui/
│       │   │       ├── pages/      # Example page
│       │   │       └── widgets/    # Shipping selector
│       │   └── shipping.dart       # Package exports
│       └── pubspec.yaml
└── pubspec.yaml                     # Root dependencies
```

---

## Packages

### Common Package
Shared utilities, constants, widgets, and dependency injection setup used across all feature packages.

### Auth Package
User authentication and authorization with JWT token management and secure storage.

### Products Package
Product browsing, search, category filtering, and product detail display with variations support.

### Cart Package
Shopping cart with local SQLite persistence for add, update, remove, and checkout operations.

### Profile Package
Customer profile management with view and edit capabilities for personal information and billing address.

### Orders Package
Complete checkout flow with billing/shipping forms, payment selection, and order creation.

### Shipping Package
Shipping zone and method selection with dynamic cost calculation for checkout integration.

---

## Getting Started

### Prerequisites
- Flutter SDK: ^3.0.0
- Dart SDK: ^3.0.0

### Installation

1. Clone the repository
```bash
git clone <repository-url>
cd shopping_app_multi_package_based_architecture
```

2. Get dependencies
```bash
flutter pub get
cd packages/common && flutter pub get
cd ../products && flutter pub get
cd ../..
```

3. Run the app
```bash
flutter run
```

---

## API Documentation

### Base URLs

**Product/Category API:**
```
https://shopapi.rubylearner.com/api.php
```

**Auth API:**
```
https://shopapi.rubylearner.com/auth.php
```

### Authentication
- Product/Category APIs use a PHP proxy that handles WooCommerce authentication internally
- Auth APIs return JWT tokens for user authentication
- Customer/Order APIs require JWT token in headers (handled by app)

---

### 1. User Registration

**Endpoint:** `POST /auth.php?action=register`

**Request Body (Form Data):**
| Parameter    | Type   | Description           |
|--------------|--------|-----------------------|
| email        | string | User email address    |
| password     | string | User password         |
| display_name | string | User display name     |
| user_login   | string | Desired username      |

**Example Request:**
```
curl -X POST \
  https://shopapi.rubylearner.com/auth.php?action=register \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "email=user1@example.com&password=mypassword&display_name=User%20Name&user_login=user1"
```

**Response:**
```json
{
  "success": true,
  "message": "Registration successful!",
  "data": {
    "success": true,
    "id": "5",
    "message": "User was successfully created.",
    "user": {
      "ID": "5",
      "user_login": "user1",
      "user_email": "user1@example.com",
      "display_name": "User Name"
    },
    "roles": ["subscriber"]
  }
}
```

---

### 2. User Login

**Endpoint:** `POST /auth.php?action=login`

**Request Body (Form Data):**
| Parameter | Type   | Description        |
|-----------|--------|--------------------|
| email     | string | User email address |
| password  | string | User password      |

**Example Request:**
```
curl -X POST \
  https://shopapi.rubylearner.com/auth.php?action=login \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "email=user1@example.com&password=mypassword"
```

**Response:**
```json
{
  "success": true,
  "data": {
    "success": true,
    "data": {
      "jwt": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...",
      "iat": 1761884530,
      "exp": 1761888130,
      "email": "user1@example.com",
      "id": "5",
      "username": "user1"
    }
  }
}
```

---

### 3. Verify OTP

**Endpoint:** `POST /auth.php?action=verify`

**Request Body (Form Data):**
| Parameter | Type   | Description        |
|-----------|--------|--------------------|
| email     | string | User email address |
| otp       | string | OTP code received  |

**Example Request:**
```
curl -X POST \
  https://shopapi.rubylearner.com/auth.php?action=verify \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "email=user1@example.com&otp=123456"
```

**Response:**
```json
{
  "success": true,
  "message": "OTP verified successfully!",
  "data": {
    "success": true,
    "id": "5",
    "message": "OTP verified.",
    "user": {
      "ID": "5",
      "user_login": "user1",
      "user_nicename": "user1",
      "user_email": "user1@example.com",
      "user_url": "",
      "user_registered": "2026-02-20 12:00:00",
      "user_activation_key": "",
      "user_status": "0",
      "display_name": "User Name"
    },
    "roles": ["subscriber"]
  }
}
```

---

### 4. Reset Password

**Endpoint:** `POST /auth.php?action=reset`

**Request Body (Form Data):**
| Parameter | Type   | Description        |
|-----------|--------|--------------------|
| email     | string | User email address |

**Example Request:**
```
curl -X POST \
  https://shopapi.rubylearner.com/auth.php?action=reset \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "email=user1@example.com"
```

**Response:**
```json
{
  "success": true,
  "data": "Password reset link sent to your email."
}
```

---

### 5. Get Products

**Endpoint:** `GET /api.php?endpoint=products`

**Query Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| page | int | Page number (default: 1) |
| per_page | int | Items per page (default: 20) |
| search | string | Search query (optional) |
| category | int | Category ID filter (optional) |
| _fields | string | Comma-separated field list |

**Example Request:**
```
GET /api.php?endpoint=products&page=1&per_page=20&_fields=id,name,slug,price,regular_price,sale_price,on_sale,stock_status,manage_stock,stock_quantity,backorders,backorders_allowed,images,categories
```

**Response:**
```json
[
  {
    "id": 799,
    "name": "Dat Divi Engine Life Crop-top (3-Tone)",
    "slug": "dat-divi-engine-life-crop-top-3-tone",
    "price": "12.99",
    "regular_price": "",
    "sale_price": "",
    "on_sale": false,
    "stock_status": "instock",
    "manage_stock": true,
    "stock_quantity": 100,
    "backorders": "no",
    "backorders_allowed": false,
    "images": [
      {
        "id": 218,
        "src": "https://shopapi.rubylearner.com/wp-content/uploads/2025/10/Dat-Divi_Life.jpg",
        "thumbnail": "https://shopapi.rubylearner.com/wp-content/uploads/2025/10/Dat-Divi_Life-300x300.jpg"
      }
    ],
    "categories": [
      {
        "id": 41,
        "name": "Shirts",
        "slug": "shirts-women"
      }
    ]
  }
]
```

---

### 6. Get Single Product

**Endpoint:** `GET /api.php?endpoint=products/{id}`

**Query Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| _fields | string | Comma-separated field list |

**Example Request:**
```
GET /api.php?endpoint=products/799&_fields=id,name,slug,price,regular_price,sale_price,on_sale,stock_status,manage_stock,stock_quantity,backorders,backorders_allowed,description,short_description,images,categories,attributes,default_attributes,variations,average_rating,rating_count,reviews_allowed,sku,weight,dimensions,type,total_sales,tags,shipping_required,shipping_class
```

**Response:**
```json
{
  "id": 799,
  "name": "Dat Divi Engine Life Crop-top (3-Tone)",
  "slug": "dat-divi-engine-life-crop-top-3-tone",
  "price": "12.99",
  "regular_price": "",
  "sale_price": "",
  "on_sale": false,
  "stock_status": "instock",
  "manage_stock": true,
  "stock_quantity": 100,
  "backorders": "no",
  "backorders_allowed": false,
  "description": "",
  "short_description": "<p>This comfortable cotton crop-top features the Divi Engine logo on the front expressing how easy &#8220;data Divi Engine life&#8221; is. It is the perfect tee for any occasion.</p>\n",
  "images": [
    {
      "id": 218,
      "src": "https://shopapi.rubylearner.com/wp-content/uploads/2025/10/Dat-Divi_Life.jpg",
      "thumbnail": "https://shopapi.rubylearner.com/wp-content/uploads/2025/10/Dat-Divi_Life-300x300.jpg",
      "name": "Dat-Divi_Life.jpg",
      "alt": ""
    }
  ],
  "categories": [
    {
      "id": 41,
      "name": "Shirts",
      "slug": "shirts-women"
    },
    {
      "id": 39,
      "name": "Women",
      "slug": "women"
    }
  ],
  "attributes": [
    {
      "id": 1,
      "name": "Brand",
      "slug": "pa_brand",
      "position": 0,
      "visible": true,
      "variation": false,
      "options": ["Divi Engine"]
    },
    {
      "id": 3,
      "name": "Size",
      "slug": "pa_size",
      "position": 1,
      "visible": true,
      "variation": true,
      "options": ["Large", "Medium", "Small"]
    }
  ],
  "default_attributes": [
    {
      "id": 3,
      "name": "Size",
      "option": "large"
    }
  ],
  "variations": [800, 801, 802],
  "average_rating": "0.00",
  "rating_count": 0,
  "reviews_allowed": true,
  "sku": "",
  "weight": "",
  "dimensions": {
    "length": "",
    "width": "",
    "height": ""
  },
  "type": "variable",
  "total_sales": 0,
  "tags": [],
  "shipping_required": true,
  "shipping_class": ""
}
```

**Stock Management Fields:**

| Field | Type | Description |
|-------|------|-------------|
| stock_status | string | Stock availability status: `instock`, `outofstock`, `onbackorder` |
| manage_stock | boolean | Whether stock is managed at product level |
| stock_quantity | int/null | Available quantity if manage_stock is true, null otherwise |
| backorders | string | Backorder status: `no`, `notify`, `yes` |
| backorders_allowed | boolean | Whether backorders are permitted |

**Stock Status Logic:**
- When `manage_stock` is `true`: Stock is tracked, use `stock_quantity` to determine availability
- When `manage_stock` is `false`: Stock is not tracked, rely on `stock_status` field
- `stock_quantity` of `0` or less means out of stock (unless backorders are allowed)
- Variable products inherit stock from their variations

---

### 7. Search Products

**Endpoint:** `GET /api.php?endpoint=products&search={query}`

**Example Request:**
```
GET /api.php?endpoint=products&search=shirt&page=1&per_page=20
```

**Response:** Same as Get Products

---

### 8. Get Categories

**Endpoint:** `GET /api.php?endpoint=products/categories`

**Query Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| page | int | Page number (default: 1) |
| per_page | int | Items per page (default: 100) |
| parent | int | Parent category ID (0 for top-level) |
| hide_empty | bool | Hide empty categories |
| _fields | string | Comma-separated field list |

**Example Request:**
```
GET /api.php?endpoint=products/categories&page=1&per_page=100&parent=0&hide_empty=true&_fields=id,name,slug,parent,description,display,image,menu_order,count
```

**Response:**
```json
[
  {
    "id": 41,
    "name": "Shirts",
    "slug": "shirts-women",
    "parent": 39,
    "description": "",
    "display": "default",
    "image": {
      "id": 215,
      "src": "https://shopapi.rubylearner.com/wp-content/uploads/2025/10/category-image.jpg",
      "name": "category-image.jpg",
      "alt": ""
    },
    "menu_order": 0,
    "count": 5
  }
]
```

---

### 9. Get Products by Category

**Endpoint:** `GET /api.php?endpoint=products&category={id}`

**Example Request:**
```
GET /api.php?endpoint=products&category=41&page=1&per_page=20
```

**Response:** Same as Get Products

---

### 10. Get Shipping Methods

**Endpoint:** `GET /api.php?endpoint=shipping/zones/{zoneId}/methods`

**Path Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| zoneId | int | Shipping zone ID (e.g., 1 for Myanmar) |

**Example Request:**
```
GET /api.php?endpoint=shipping/zones/1/methods
```

**Response:**
```json
[
  {
    "id": 4,
    "instance_id": 4,
    "title": "နယ်မြို့",
    "order": 1,
    "enabled": true,
    "method_id": "flat_rate",
    "method_title": "Flat rate",
    "method_description": "Flat rate shipping",
    "settings": {
      "cost": {
        "value": "20"
      }
    }
  },
  {
    "id": 5,
    "instance_id": 5,
    "title": "Free shipping",
    "order": 2,
    "enabled": true,
    "method_id": "free_shipping",
    "method_title": "Free shipping",
    "method_description": "",
    "settings": {}
  }
]
```

---

### 11. Get Customer

**Endpoint:** `GET /api.php?endpoint=customers/{id}`

**Path Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| id | string | Customer ID |

**Example Request:**
```
GET /api.php?endpoint=customers/5
```

**Response:**
```json
{
  "id": 5,
  "email": "user@example.com",
  "first_name": "John",
  "last_name": "Doe",
  "username": "johndoe",
  "billing": {
    "first_name": "John",
    "last_name": "Doe",
    "email": "user@example.com",
    "phone": "09123456789",
    "address_1": "123 Main St",
    "address_2": "Apt 4B",
    "city": "Yangon",
    "state": "Yangon",
    "postcode": "11111",
    "country": "MM"
  },
  "shipping": {
    "first_name": "John",
    "last_name": "Doe",
    "address_1": "123 Main St",
    "address_2": "Apt 4B",
    "city": "Yangon",
    "state": "Yangon",
    "postcode": "11111",
    "country": "MM"
  },
  "avatar_url": "https://secure.gravatar.com/avatar/..."
}
```

---

### 12. Update Customer

**Endpoint:** `PUT /api.php?endpoint=customers/{id}`

**Path Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| id | string | Customer ID |

**Request Body (JSON):**
```json
{
  "first_name": "John",
  "last_name": "Doe",
  "billing": {
    "first_name": "John",
    "last_name": "Doe",
    "email": "user@example.com",
    "phone": "09123456789",
    "address_1": "123 Main St",
    "address_2": "Apt 4B",
    "city": "Yangon",
    "state": "Yangon",
    "postcode": "11111",
    "country": "MM"
  }
}
```

**Response:** Same as Get Customer

---

### 13. Create Order

**Endpoint:** `POST /api.php?endpoint=orders`

**Request Body (JSON):**
```json
{
  "payment_method": "cod",
  "payment_method_title": "Cash on Delivery",
  "set_paid": false,
  "billing": {
    "first_name": "John",
    "last_name": "Doe",
    "email": "user@example.com",
    "phone": "09123456789",
    "address_1": "123 Main St",
    "address_2": "Apt 4B",
    "city": "Yangon",
    "state": "Yangon",
    "postcode": "11111",
    "country": "MM"
  },
  "shipping": {
    "first_name": "John",
    "last_name": "Doe",
    "address_1": "123 Main St",
    "address_2": "Apt 4B",
    "city": "Yangon",
    "state": "Yangon",
    "postcode": "11111",
    "country": "MM"
  },
  "line_items": [
    {
      "product_id": 799,
      "quantity": 2,
      "variation_id": 800
    }
  ],
  "shipping_lines": [
    {
      "method_id": "flat_rate",
      "method_title": "နယ်မြို့",
      "total": "20"
    }
  ],
  "customer_note": "Please deliver in the evening"
}
```

**Response:**
```json
{
  "id": 860,
  "order_key": "wc_order_TqAqBvJUZiwKt",
  "status": "checkout-draft",
  "currency": "MMK",
  "total": "365",
  "subtotal": "345",
  "shipping_total": "20",
  "payment_method": "cod",
  "payment_method_title": "Cash on Delivery",
  "billing": {},
  "shipping": {},
  "line_items": [],
  "shipping_lines": [],
  "date_created": "2025-10-31T11:45:20",
  "payment_url": "https://shopapi.rubylearner.com/checkout/order-pay/860/..."
}
```

---


## Dependencies

### Main Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.6.1
  go_router: ^14.6.2
  dio: ^5.7.0
  get_it: ^8.0.2
  pretty_dio_logger: ^1.4.0
```

### Dev Dependencies
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0
```

---

## License

This project is licensed under the MIT License.

---

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---

## Contact

For questions or support, please open an issue in the repository.
