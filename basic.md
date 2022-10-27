folder structure --------  https://medium.com/flutter-community/scalable-folder-structure-for-flutter-applications-183746bdc320#:~:text=The%20different%20components%20in%20the,actual%20implementation%20of%20the%20repository

```dart
class Counter extends ChangeNotifier {
  var _count = 0;
  int get getCounter {
    return _count;
  }

  void increment() {
    _count += 1;
    notifyListeners();
  }

  void decreament() {
    _count -= 1;
    notifyListeners();
  }
}

```

```dart
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        // ChangeNotifierProvider(create: (_) => ShoppingCart()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(title: 'Flutter Demo Home Page'),
      ),
    ),
  );
}
```

```dart

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  // int _counter = 0;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Consumer<Counter>(
              builder: (context, state, child) {
                return Text(
                  'Total price: ${state.getCounter}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            Text(
              "${context.watch<Counter>().getCounter}",
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<Counter>().increment();
              },
              child: Text("plus"),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<Counter>(context, listen: false).decreament();
              },
              child: Text("Minus"),
            )
          ],
        ),
      ),
    );
  }
}
```






