```dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final numberStateProvider = StateProvider<int>((ref) {
  return 30;
});

// state can be changed
class HomeTwo extends ConsumerWidget {
  const HomeTwo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final number = ref.watch(numberStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("RiverPod Tutorial"),
      ),
      body: Center(
        child: Text(
          "title $number",
          style: TextStyle(fontSize: 30),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(numberStateProvider.notifier).state++;
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

```
