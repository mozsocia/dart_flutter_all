```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/about': (context) => AboutPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        automaticallyImplyLeading: false, // by setting it if leading is not defined it will not show
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the About page
            Navigator.pushNamed(context, '/about');
          },
          child: Text('Go to About'),
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        automaticallyImplyLeading: false, // by setting it if leading is not defined it will not show
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new), // You can use any icon you want
          onPressed: () {
            Navigator.pop(context); // Going back to the previous screen
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is the About page'),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Home page
                Navigator.pushNamed(context, '/');
              },
              child: Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
```
