# Expense Note

Expense Note is a Flutter app for recording daily expenses and tracking the total amount spent. It uses a dark Material 3 interface, local SQLite storage, Riverpod state management, and GoRouter navigation.

## Features

- Add expenses with title, amount, subtitle, and created date.
- View all saved expenses in a scrollable list.
- See the total expense amount at the top of the home screen.
- Edit or delete an expense with slide actions.
- Store expense data locally with SQLite.
- Navigate between Expenses and Expense Types tabs.
- Show Lottie empty-state and coming-soon animations.

## Tech Stack

- Flutter and Dart
- Material 3
- Riverpod for state management
- GoRouter for routing
- sqflite and path for local database storage
- intl for date and currency formatting
- flutter_slidable for list actions
- lottie for animations

## Project Structure

```text
lib/
  core/
    database/      SQLite database setup
    services/      Formatting and route helper services
    utils/         App constants, colors, routes, and theme
    widgets/       Shared expense form and bottom sheet widgets
  features/
    home/
      data/        Expense models, local datasource, and repository implementation
      domain/      Repository contract, use cases, and providers
      screens/     Home UI, state, providers, and expense tile widgets
    expense_type/  Expense type tab, currently marked as coming soon
    root.dart      App shell with bottom navigation and add button
```

## Requirements

- Flutter SDK compatible with Dart `^3.10.7`
- Android Studio, Xcode, or another Flutter-supported toolchain for your target platform

## Getting Started

Clone the project and install dependencies:

```bash
flutter pub get
```

Run the app:

```bash
flutter run
```

Run static analysis:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```

Build an Android APK:

```bash
flutter build apk
```

## Local Database

The app creates a local database named `expnese_note.db` with these tables:

- `expenseTable`: stores expense title, subtitle, amount, and date.
- `expneseTypeTable`: reserved for future expense type data.

Expense data is saved on the device, so it remains available after the app restarts.

## Platform Notes

The repository includes Flutter platform folders for Android, iOS, web, Windows, macOS, and Linux. Because the current persistence layer uses `sqflite`, Android, iOS, and macOS are the safest targets out of the box. Web, Windows, and Linux may need an additional database adapter before local storage works there.

## Status

Expense tracking is implemented. Expense type management is planned and currently shown as a coming-soon screen.
