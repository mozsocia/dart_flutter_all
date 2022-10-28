```dart
import 'package:get/get.dart';

class CounterController extends GetxController {
  var count = 0.obs;

  var counter = 10;

  void incrementCount() {
    count++;
  }

  void addCounter() {
    counter++;
    update();
  }
}

```

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_basic_app/counter_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

```

```dart

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final counterCon = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Getx Basic"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GetX<CounterController>(builder: (controller) {
              return Text(
                '${controller.count}', // can to use counter here
                style: TextStyle(fontSize: 30),
              );
            }),
            SizedBox(
              height: 30,
            ),
            Obx(() => Text(
                  "state ${counterCon.count}", // can to use counter here
                  style: TextStyle(fontSize: 30),
                )),
            SizedBox(
              height: 30,
            ),
            GetBuilder<CounterController>(
              builder: (contro) {
                return Text(
                  "state ${contro.counter}",
                  style: TextStyle(fontSize: 30),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterCon.incrementCount();
          counterCon.addCounter();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

