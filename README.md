# Prime Counter

A Flutter application that searches for prime numbers and displays them with elapsed time tracking.

## Features

- Automatic prime number search every 10 seconds
- Real-time clock display with calendar week
- Prime number validation and display
- Time tracking between prime number discoveries
- Clean architecture using BLoC pattern

## Architecture

The application follows clean architecture principles and uses the BLoC (Business Logic Component) pattern for state management:

- **UI Layer**: Presentation components and widgets
- **BLoC Layer**: Business logic and state management
- **Repository Layer**: Data handling and API communication
- **Utility Layer**: Helper classes and extensions

## Dependencies

- `flutter_bloc`: State management
- `bloc`: Business logic components
- `dartz`: Functional programming features
- `shared_preferences`: Local storage
- `intl`: Date formatting

## Getting Started

1. Ensure you have Flutter installed on your machine
2. Clone the repository
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Testing

The project includes unit tests for the BLoC, Repository, and Utility classes. Run tests using:

```bash
flutter test
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
