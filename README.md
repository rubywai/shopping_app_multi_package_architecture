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
- [State Management](#state-management)
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

### Product Management
- ✅ Product list with grid view
- ✅ Product detail with image carousel
- ✅ Product search with real-time filtering
- ✅ Category-based filtering
- ✅ Pagination support

### UI/UX
- ✅ Image carousel with indicators
- ✅ Size selection for variable products
- ✅ Loading states and error handling
- ✅ Bottom navigation
- ✅ Responsive design

### Performance
- ✅ Optimized API calls with field filtering
- ✅ Image caching
- ✅ Debounced search
- ✅ Lazy loading with pagination

---

## Architecture

This project follows a **feature-based multi-package architecture** to achieve modularity, reusability, and separation of concerns.

```
┌─────────────────────────────────────────────────────────────┐
│                         Main App                            │
│                    (Shopping App Root)                      │
└──────────────────────┬──────────────────────────────────────┘
                       │
           ┌───────────┴───────────┐
           │                       │
    ┌──────▼──────┐         ┌─────▼─────┐
    │   Common    │         │  Products │
    │   Package   │         │  Package  │
    └─────────────┘         └───────────┘
           │                       │
    ┌──────▼──────────────┬────────▼─────────────┐
    │   - Widgets         │   - UI (Pages)       │
    │   - Constants       │   - Providers        │
    │   - Dependencies    │   - Models           │
    │   - Utils           │   - Services         │
    └─────────────────────┴──────────────────────┘
```

### Architecture Layers

#### 1. **Presentation Layer**
- UI components (Pages, Widgets)
- State management (Riverpod Notifiers)
- Navigation (GoRouter)

#### 2. **Domain Layer** (Implicit)
- Business logic in state notifiers
- Data models

#### 3. **Data Layer**
- API services (Dio)
- Models (JSON serialization)
- Dependency injection (GetIt)

### Package Organization

**Common Package** (`packages/common/`)
- Shared widgets (ErrorRetryWidget, AppScaffold)
- Constants (URL, App Config)
- Dependency injection setup

**Products Package** (`packages/products/`)
- Product listing and detail pages
- Search functionality
- Category browsing
- Product state management

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
│   └── products/                    # Products feature
│       ├── lib/
│       │   ├── src/
│       │   │   ├── data/
│       │   │   │   ├── models/     # Data models
│       │   │   │   └── services/   # API services
│       │   │   ├── providers/      # State management
│       │   │   └── ui/
│       │   │       ├── pages/      # Screens
│       │   │       └── widgets/    # UI components
│       │   └── products.dart       # Package exports
│       └── pubspec.yaml
└── pubspec.yaml                     # Root dependencies
```

---

## Packages

### Common Package
Provides shared functionality across features.

**Exports:**
- `UrlConst` - API base URL configuration
- `ErrorRetryWidget` - Reusable error display with retry
- `AppScaffold` - Bottom navigation scaffold
- `setUpCommonDependency()` - Dio and GetIt setup

### Products Package
Handles all product-related features.

**Pages:**
- `ProductListPage` - Grid view of products
- `ProductDetailPage` - Detailed product information
- `ProductSearchPage` - Search with real-time results
- `CategoryPage` - Category listing
- `CategoryProductsPage` - Products filtered by category

**Models:**
- `ProductListModel` - Lightweight model for listings
- `ProductDetailModel` - Complete model for details
- `CategoryModel` - Category information

**Services:**
- `ProductService` - Product API calls
- `CategoryService` - Category API calls

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

### Base URL
```
https://shopapi.rubylearner.com/api.php
```

### Authentication
The API uses a PHP proxy that handles WooCommerce authentication internally.

---

### 1. Get Products

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
GET /api.php?endpoint=products&page=1&per_page=20&_fields=id,name,slug,price,regular_price,sale_price,on_sale,stock_status,images,categories
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

### 2. Get Single Product

**Endpoint:** `GET /api.php?endpoint=products/{id}`

**Query Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| _fields | string | Comma-separated field list |

**Example Request:**
```
GET /api.php?endpoint=products/799&_fields=id,name,slug,price,regular_price,sale_price,on_sale,stock_status,description,short_description,images,categories,attributes,default_attributes,variations,average_rating,rating_count,reviews_allowed,sku,weight,dimensions,type,total_sales,tags,shipping_required,shipping_class
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

---

### 3. Search Products

**Endpoint:** `GET /api.php?endpoint=products&search={query}`

**Example Request:**
```
GET /api.php?endpoint=products&search=shirt&page=1&per_page=20
```

**Response:** Same as Get Products

---

### 4. Get Categories

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

### 5. Get Products by Category

**Endpoint:** `GET /api.php?endpoint=products&category={id}`

**Example Request:**
```
GET /api.php?endpoint=products&category=41&page=1&per_page=20
```

**Response:** Same as Get Products

---

## State Management

The app uses **Riverpod** for state management with the following notifiers:

### ProductStateNotifier
Manages product listing state with pagination.

**Methods:**
- `fetchProducts()` - Load initial products
- `loadMore()` - Load next page
- `searchProducts(String query)` - Search products
- `fetchProductsByCategory(int categoryId)` - Filter by category

### ProductDetailNotifier
Manages single product detail state.

**Methods:**
- `fetchProductDetail(int productId)` - Load product details

### CategoryStateNotifier
Manages category listing state.

**Methods:**
- `fetchCategories()` - Load all categories

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

