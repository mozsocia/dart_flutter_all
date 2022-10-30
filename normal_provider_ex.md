```dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final numberProvider = Provider<int>((ref) {
  return 44;
});
// it can to be changed state

class HomeOne extends StatelessWidget {
  const HomeOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RiverPod Tutorial"),
      ),
      body: Center(
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, __) {
            final number = ref.watch(numberProvider);
            return Text("title $number");
          },
        ),
      ),
    );
  }
}

```
