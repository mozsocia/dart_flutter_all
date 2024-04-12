### In flutter how to make light and dark theme using themedata


Sure, here's the complete `main.dart` file with the implementation of the light and dark theme:

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(lightTheme),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          title: 'My App',
          theme: themeNotifier.currentTheme,
          home: HomePage(),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              context.read<ThemeNotifier>().switchTheme();
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Hello, Flutter!'),
      ),
    );
  }
}

// Light Theme
final lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.light,
  textTheme: TextTheme(
    bodyText2: TextStyle(color: Colors.black),
  ),
);

// Dark Theme
final darkTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.dark,
  textTheme: TextTheme(
    bodyText2: TextStyle(color: Colors.white),
  ),
);

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme;

  ThemeNotifier(this._currentTheme);

  ThemeData get currentTheme => _currentTheme;

  void switchTheme() {
    _currentTheme = _currentTheme == lightTheme ? darkTheme : lightTheme;
    notifyListeners();
  }
}
```

This code sets up the light and dark themes, creates a `ThemeNotifier` class to manage the current theme, and uses the `ChangeNotifierProvider` to make the `ThemeNotifier` available to the entire app.

The `MyApp` widget uses the `Consumer<ThemeNotifier>` to access the current theme and apply it to the `MaterialApp`. The `HomePage` widget includes an icon button that calls the `switchTheme()` method on the `ThemeNotifier` to toggle between the light and dark themes.

When the user taps the icon button, the `ThemeNotifier` updates the current theme and notifies the UI, causing the app to rebuild with the new theme.
