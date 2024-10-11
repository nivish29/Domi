# Domi Assignment

This project is a Flutter application designed as a UI assignment for the Domi project. The app provides a user-friendly interface with a search implementation and includes an "Invite and Earn" functionality for neighbors. It also manages the bottom sheet at a specified height for optimal usability.

## Key Features

- **Search Implementation:** Implemented for improved performance and user experience.
- **Invite and Earn Functionality:** Neighbors can be invited with rewards integrated into the app.
- **Bottom Sheet Management:** Manages the bottom sheet with smooth animations at the specified height.
- **App Appearance Page:** A dedicated page where users can customize the app's theme and modify polygon colors and appearance.

## State Management

For state management, the application uses the **BLoC** pattern to ensure efficient handling of states and business logic.

## Dependency Injection

For dependency injection, the app uses **Get_it**, a lightweight service locator for managing dependencies throughout the app.

## Routing

For navigation and routing, the app uses **go_router** to handle routing efficiently with clean and declarative APIs.

## Folder Structure

The project follows a clean architecture pattern, and each feature has its own `data`, `domain`, and `presentation` layers. This ensures modularity, scalability, and organization.

```plaintext
lib/
│
├── feature/
│   ├── feature1/
│   │   ├── data/
│   │   │   ├── models/         # Data models for feature1
│   │   │   ├── repositories/   # Data repositories for feature1
│   │   │   └── sources/        # Data sources for feature1 (local or remote)
│   │   ├── domain/
│   │   │   ├── entities/       # Business entities for feature1
│   │   │   ├── repositories/   # Domain repositories for feature1
│   │   │   └── usecases/       # Use cases handling business logic for feature1
│   │   └── presentation/
│   │       ├── bloc/           # BLoC for feature1 state management
│   │       └── widgets/        # UI components and widgets for feature1
│   ├── feature2/
│   │   ├── data/               # Similar structure for other features
│   │   ├── domain/
│   │   └── presentation/
│   └── ...
│
└── |                           # Core utilities, shared services, etc.
    ├── themes/
    └── widgets/
```
## How to Run the project

Clone the repository:

  ```bash
   git clone -b master https://github.com/nivish29/Domi.git
```
```bash
 Move to the directory
```
Get Packages:
```bash
flutter pub get
```
Run App:
```bash
flutter run
```
