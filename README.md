# Shopping App - Multi-Package Architecture

A modern Flutter e-commerce application built with **feature-based multi-package architecture** and powered by **WooCommerce REST APIs**.

---

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Features](#features)
- [Getting Started](#getting-started)
- [Package Details](#package-details)
- [API Integration](#api-integration)
- [Development Workflow](#development-workflow)
- [Best Practices](#best-practices)
- [Contributing](#contributing)

---

## Overview

This shopping app demonstrates a **scalable, maintainable, and testable** Flutter architecture using **multi-package organization**. Each feature is isolated into its own package, promoting:

- **Separation of Concerns** – Each package has a single responsibility
- **Reusability** – Shared code in `common` package
- **Testability** – Unit test each package independently
- **Team Scalability** – Multiple developers can work on different features without conflicts
- **Build Performance** – Flutter only rebuilds changed packages

---

## Architecture

### Multi-Package Feature-Based Architecture

```
shopping_app_multi_package_based_architecture
├── lib/                          # Main app entry point
│   └── main.dart
├── packages/                     # Feature packages
│   ├── common/                   # Shared utilities, models, services
│   │   ├── lib/
│   │   │   ├── common.dart
│   │   │   └── src/
│   │   │       ├── config/
│   │   │       ├── models/
│   │   │       ├── services/
│   │   │       ├── utils/
│   │   │       └── widgets/
│   │   └── pubspec.yaml
│   │
│   ├── products/                 # Product listing & details feature
│   │   ├── lib/
│   │   │   ├── products.dart
│   │   │   └── src/
│   │   │       ├── data/
│   │   │       │   ├── models/
│   │   │       │   ├── repositories/
│   │   │       │   └── services/
│   │   │       ├── domain/
│   │   │       │   ├── entities/
│   │   │       │   └── use_cases/
│   │   │       └── presentation/
│   │   │           ├── pages/
│   │   │           ├── widgets/
│   │   │           └── providers/
│   │   └── pubspec.yaml
│   │
│   ├── cart/                     # Shopping cart feature (planned)
│   ├── auth/                     # Authentication feature (planned)
│   └── checkout/                 # Checkout & payment feature (planned)
│
├── pubspec.yaml                  # Root app dependencies
└── README.md
```

### Architecture Layers (per feature package)

```
┌─────────────────────────────────────────┐
│         Presentation Layer              │
│  (UI, Pages, Widgets, State Management) │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│          Domain Layer                   │
│     (Entities, Use Cases, Interfaces)   │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│           Data Layer                    │
│ (Models, Repositories, API Services)    │
└─────────────────────────────────────────┘
```

---

## Project Structure

### Root App (`lib/main.dart`)
- Composes all feature packages
- Handles routing and app-level configuration
- Minimal logic, mostly orchestration

### Common Package (`packages/common`)
Shared resources used across all features:
- **Config**: API configuration, environment variables
- **Models**: Shared data models
- **Services**: HTTP client, logging, analytics
- **Utils**: Helper functions, extensions, constants
- **Widgets**: Reusable UI components

### Feature Packages (`packages/products`, `packages/cart`, etc.)
Each feature package follows **Clean Architecture**:
- **Data Layer**: API services, repositories, DTOs
- **Domain Layer**: Business entities, use cases
- **Presentation Layer**: UI screens, widgets, state management

---

## Features

### Current Features
- **Product Listing** – Browse products from WooCommerce store
- **Product Search** – Search and filter products
- **Product Details** – View detailed product information
- **Image Gallery** – Product image carousel

### Planned Features
- **Shopping Cart** – Add/remove items, update quantities
- **Authentication** – User login/registration
- **Checkout** – Order placement and payment
- **Order History** – View past orders
- **Reviews & Ratings** – Product reviews
- **User Profile** – Manage account settings

---

## Getting Started

### Prerequisites

- **Flutter SDK**: `>=3.5.4`
- **Dart SDK**: `^3.5.4`
- **IDE**: Android Studio, VS Code, or IntelliJ IDEA
- **WooCommerce Store**: API credentials (Consumer Key & Secret)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd shopping_app_multi_package_based_architecture
   ```

2. **Get dependencies for all packages**
   ```bash
   # Get dependencies for common package
   cd packages/common
   flutter pub get
   cd ../..

   # Get dependencies for products package
   cd packages/products
   flutter pub get
   cd ../..

   # Get dependencies for root app
   flutter pub get
   ```

3. **Configure API credentials**
   
   Edit `packages/common/lib/src/config/api_config.dart`:
   ```dart
   class ApiConfig {
     static const String baseUrl = 'https://shopapi.rubylearner.com';
     static const String consumerKey = 'YOUR_CONSUMER_KEY';
     static const String consumerSecret = 'YOUR_CONSUMER_SECRET';
   }
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

---

## Package Details

### `common` Package

**Dependencies:**
- `dio` – HTTP client for API calls
- `get_it` – Service locator for dependency injection
- `pretty_dio_logger` – Beautiful HTTP request/response logs

**Key Components:**
- `ApiClient` – Configured Dio instance with interceptors
- `ApiConfig` – API base URL and credentials
- `ServiceLocator` – Dependency injection setup
- Common models and utilities

**Usage in other packages:**
```yaml
# packages/products/pubspec.yaml
dependencies:
  common:
    path: ../common
```

### `products` Package

**Features:**
- Product listing with pagination
- Product search and filtering
- Product details page
- Category-based browsing

**Clean Architecture Layers:**
- **Data**: `ProductService`, `ProductRepository`, `ProductModel`
- **Domain**: `Product` entity, `GetProducts` use case
- **Presentation**: `ProductListPage`, `ProductDetailPage`, state management

---

## API Integration

This app uses **WooCommerce REST API v3** from:
- **API Documentation**: [https://shopapi.rubylearner.com/api-documentations/](https://shopapi.rubylearner.com/api-documentations/)
- **Base URL**: `https://shopapi.rubylearner.com`

### Main Endpoints Used

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/wp-json/wc/v3/products` | GET | Get all products |
| `/wp-json/wc/v3/products/{id}` | GET | Get single product |
| `/wp-json/wc/v3/products/categories` | GET | Get product categories |
| `/wp-json/wc/v3/orders` | POST | Create new order |
| `/wp-json/wc/v3/customers` | POST | Create customer |

### Authentication
- **Type**: HTTP Basic Authentication
- **Headers**:
  ```
  Authorization: Basic base64(consumerKey:consumerSecret)
  ```

---

## Development Workflow

### Adding a New Feature Package

1. **Create the package**
   ```bash
   flutter create --template=package --project-name feature_name packages/feature_name
   ```

2. **Add dependency to common**
   ```yaml
   # packages/feature_name/pubspec.yaml
   dependencies:
     flutter:
       sdk: flutter
     common:
       path: ../common
   ```

3. **Structure the package**
   ```
   packages/feature_name/lib/
   ├── feature_name.dart          # Public API
   └── src/
       ├── data/
       ├── domain/
       └── presentation/
   ```

4. **Add to main app**
   ```yaml
   # pubspec.yaml (root)
   dependencies:
     feature_name:
       path: packages/feature_name
   ```

### Running Tests

```bash
# Test a specific package
cd packages/common
flutter test

# Test all packages (manual approach)
cd packages/common && flutter test && cd ../..
cd packages/products && flutter test && cd ../..
```

### Code Analysis

```bash
# Analyze a specific package
cd packages/common
flutter analyze

# Analyze root app
flutter analyze
```

---

## Best Practices

### Package Organization
- Keep packages **focused and small**
- Use `common` for **truly shared** code only
- Features should be **independent** (minimal cross-feature dependencies)
- Export only **public APIs** in the main library file

### Dependency Management
- Use `path` dependencies for local packages during development
- Pin versions in `common` package
- Run `flutter pub get` after adding dependencies

### Clean Architecture
- **Data layer** knows about domain layer
- **Domain layer** is independent (pure Dart)
- **Presentation layer** depends on domain layer
- Use **dependency injection** for repositories and services

### Testing
- Write **unit tests** for use cases and repositories
- Write **widget tests** for UI components
- Mock external dependencies (API, database)
- Aim for **>80% code coverage**

---

## Contributing

Contributions are welcome! Please follow these guidelines:

1. **Fork** the repository
2. **Create a feature branch**: `git checkout -b feature/amazing-feature`
3. **Make your changes** and add tests
4. **Ensure tests pass**: `flutter test`
5. **Commit your changes**: `git commit -m 'Add amazing feature'`
6. **Push to branch**: `git push origin feature/amazing-feature`
7. **Open a Pull Request**

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Contact

For questions or support, please contact:
- **Email**: your.email@example.com
- **GitHub**: [@yourusername](https://github.com/yourusername)

---

## Acknowledgments

- [WooCommerce REST API](https://woocommerce.github.io/woocommerce-rest-api-docs/)
- [Flutter Documentation](https://docs.flutter.dev/)
- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

---

**Built with Flutter and WooCommerce**
