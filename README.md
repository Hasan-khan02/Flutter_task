# Flutter Course App – Offline Support & State Management

## Branch Name
```
feature/offline-cache-and-state-manangement
```

---

## Tools & Packages Used

| Package | Version | Purpose |
|---|---|---|
| `hive` | ^2.2.3 | Local database for offline storage |
| `hive_flutter` | ^1.1.0 | Hive Flutter integration |
| `hive_generator` | ^2.0.1 | Auto-generate Hive adapters |
| `build_runner` | ^2.4.6 | Code generation tool |
| `provider` | ^6.1.1 | State management |
| `http` | ^1.1.0 | API HTTP requests |
| `connectivity_plus` | ^5.0.2 | Check internet connectivity |
| `path_provider` | ^2.1.1 | File system paths for Hive |

---

## Architecture Explanation

This project follows **Clean Architecture** with a **Repository Pattern**.

```
UI Layer
   └── Screens & Widgets
         │
         ▼
State Management Layer (Provider)
   └── CourseProvider
         │
         ▼
Repository Layer
   └── CourseRepository
      (decides: API or Local?)
         │
        / \
       /   \
      ▼     ▼
API Service  Local Database
(HTTP only)  (Hive)
```

### Layer Responsibilities

**UI Layer**
- Only displays data
- Calls Provider methods
- No business logic

**Provider (State Management)**
- Manages loading / success / error / empty states
- Calls Repository
- Notifies UI on change

**Repository**
- Checks internet connectivity
- If online → fetch from API → save to Hive → return data
- If offline → load from Hive → return cached data

**API Service**
- Only handles HTTP requests (GET, POST, PUT, DELETE)
- No storage logic

**Local Database (Hive)**
- Stores Course data locally
- Works completely offline

---

## Offline & State Management Approach

### Offline Support (Hive)
- When app loads and **internet is available**, data is fetched from the API and immediately saved to Hive local storage
- When app loads and **internet is NOT available**, data is loaded directly from Hive cache
- This ensures the app works seamlessly in both online and offline modes
- Data automatically syncs when internet connection is restored (pull-to-refresh)

### State Management (Provider)
- Replaced all `setState()` calls with **Provider**
- `CourseProvider` manages 4 states:
  - `loading` → shows loading spinner
  - `success` → shows course list
  - `error` → shows error message with retry button
  - `empty` → shows empty state UI
- UI and business logic are fully separated

### Optimistic UI Updates
- On **delete**: course is removed from UI immediately, API call happens in background
- On **update**: UI reflects changes instantly, rolls back if API fails
- Keeps the app feeling fast and responsive

---

## Features Implemented

- [x] Offline data persistence with Hive
- [x] Online/offline detection with connectivity_plus
- [x] Auto-sync when internet is restored
- [x] Provider state management (loading, success, error, empty)
- [x] Repository pattern (clean architecture)
- [x] Optimistic UI updates with rollback
- [x] Pull-to-refresh functionality
- [x] Search / filter courses
- [x] Empty state UI
- [x] Improved loading indicators

---

## Project Structure

```
lib/
├── models/
│   ├── course_model.dart        # Hive model
│   └── course_model.g.dart      # Auto-generated adapter
├── services/
│   └── api_service.dart         # HTTP requests only
├── local/
│   └── hive_service.dart        # Hive read/write operations
├── repository/
│   └── course_repository.dart   # Decides API vs local
├── providers/
│   └── course_provider.dart     # State management
└── screens/
    ├── course_list_screen.dart   # Main list UI
    └── course_form_screen.dart   # Add / Edit UI
```

---

## Screenshots

> *(Add screenshots here after running the app)*

| Course List | Offline Mode | Add Course |
|---|---|---|
| ![list]() | ![offline]() | ![add]() |

---

## How to Run

```bash
# Install dependencies
flutter pub get

# Generate Hive adapters
flutter pub run build_runner build

# Run the app
flutter run
```