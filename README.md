# 🚀 DealSphere – Investor Deal Management App

A Flutter application that allows corporates to post investment opportunities and investors to explore, filter, and express interest in deals.

---

# 🧠 Architecture Overview

The app follows a **feature-first Clean Architecture with BLoC pattern**, ensuring:

* Separation of concerns
* Scalability
* Maintainability
* Testability

---

# 📂 Project Structure

```id="folder_structure"
lib/
│
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_strings.dart
│   │   └── app_theme.dart
│   │
│   ├── utils/
│   │   ├── Deals.json
│   │   └── session_manager.dart
│   │
│   └── widgets/
│       ├── custom_button.dart
│       ├── deal_card.dart
│       ├── error_widget.dart
│       └── loading_widget.dart
│
├── data/
│   ├── models/
│   │   └── deal_model.dart
│   │
│   └── repositories/
│       └── deal_repository.dart
│
├── features/
│   ├── auth/
│   │   ├── bloc/
│   │   │   ├── auth_bloc.dart
│   │   │   ├── auth_event.dart
│   │   │   └── auth_state.dart
│   │   └── screens/
│   │       └── login_screen.dart
│   │
│   ├── deals/
│   │   ├── bloc/
│   │   │   ├── deal_bloc.dart
│   │   │   ├── deal_event.dart
│   │   │   └── deal_state.dart
│   │   └── screens/
│   │       ├── deal_list_screen.dart
│   │       └── deal_detail_screen.dart
│   │
│   └── interests/
│       ├── bloc/
│       │   ├── interest_bloc.dart
│       │   ├── interest_event.dart
│       │   └── interest_state.dart
│       └── screens/
│           └── my_interests_screen.dart
│
├── app.dart
└── main.dart
```

---

# 🧩 Architecture Layers

## 1️⃣ Presentation Layer (UI)

* Screens (`login_screen`, `deal_list_screen`, etc.)
* Reusable widgets (`deal_card`, `loading_widget`)
* Handles UI rendering only

---

## 2️⃣ Business Logic Layer (BLoC)

* Manages application state
* Handles events like:

  * `LoadDeals`
  * `FilterDeals`
  * `AddInterest`
* Emits states:

  * Loading
  * Loaded
  * Error

---

## 3️⃣ Data Layer

* Models (`Deal`, `RoiData`)
* Repository (`deal_repository.dart`)
* JSON-based mock data (`Deals.json`)

---

# ⚙️ State Management Flow

```id="bloc_flow"
UI → Event → Bloc → State → UI Update
```

### Example:

* User types in search
* `FilterDeals` event triggered
* Bloc filters data
* UI rebuilds automatically

---

# 🔍 Features

## 🔐 Authentication

* Mock login system
* Session persistence using `SessionManager`
* Auto-login support

---

## 📊 Deal Listing

* Displays all deals using `DealCard`
* Clean card-based UI
* Navigation to detail screen

---

## 🔎 Search & Filters

* Search by company name
* Filter by:

  * Risk Level
  * Industry
  * ROI Range (slider)
* Real-time filtering using BLoC

---

## ❤️ Interests Management

* Add/remove interest
* Dedicated "My Interests" screen
* Live count badge in AppBar

---

## 📈 Deal Details

* Company overview
* Financial highlights
* ROI projection
* Risk explanation

---

# 🎨 UI/UX Decisions

* Reusable UI components (DRY principle)
* Card-based design for clarity
* Consistent spacing and typography
* Visual indicators:

  * Risk badges
  * ROI highlights
* Dedicated states:

  * Loading
  * Error
  * Empty

---

# 🧠 Key Design Decisions

## ✅ 1. Feature-first architecture

Each feature (auth, deals, interests) is isolated
→ Improves modularity

---

## ✅ 2. BLoC for state management

* Clear separation of UI & logic
* Scalable for large apps
* Predictable state flow

---

## ✅ 3. Local JSON data

* Simplifies development
* No backend dependency
* Easy to replace with API later

---

## ✅ 4. Reusable widgets

* `DealCard` used across screens
* Reduces duplication
* Ensures consistent UI

---

## ✅ 5. Session handling

* Lightweight local storage
* Avoids unnecessary backend complexity

---

# ⚠️ Trade-offs

| Decision          | Trade-off                       |
| ----------------- | ------------------------------- |
| Mock data         | No real backend                 |
| Local filtering   | Not scalable for large datasets |
| Simple repository | Limited abstraction             |

---

# 🚀 Future Improvements

* API integration (REST/Firebase)
* Pagination & lazy loading
* Advanced filter UI (bottom sheet)
* Unit & widget testing
* Real charts (fl_chart)
* Dark/light theme toggle

---

# ▶️ Getting Started

```bash id="setup_cmds"
git clone <repo-url>
cd deal_sphere
flutter pub get
flutter run
```

---

# 🧪 Demo Credentials

```id="demo_creds"
Email: anuj@test.com
Password: 123456
```

---

# 🛠 Tech Stack

* Flutter
* Dart
* flutter_bloc
* Equatable

---

# 📌 Summary

This project demonstrates:

* Clean architecture implementation
* Scalable state management (BLoC)
* Modular feature-based structure
* Strong UI/UX practices

---

✨ Built for learning, scalability, and production-ready design.
