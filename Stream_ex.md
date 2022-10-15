

https://www.filledstacks.com/post/a-complete-guide-to-flutter-streams/


basic stream in dart

```dart

import 'dart:async';

void main() async {
  int counter = 10;
  StreamController controller = StreamController();

  var stream = controller.stream;

  stream.listen((event) {
    print("listen $event");
  });

  startTimer(counter, controller);
}

void startTimer(int counter, StreamController controller) async {
  // Timer Method that runs every second

  Timer.periodic(Duration(seconds: 1), (timer) {
    counter--;

    // add event/data to stream controller using sink
    // controller.sink.add(counter);  or below code will work the same
    controller.add(counter);

    // will stop Count Down Timer when _counter value is 0
    if (counter <= 0) {
      timer.cancel();
      controller.close();
    }
  });

  print("done");
}
```
-----------------------------------------
https://www.youtube.com/watch?v=nQBpOIHE4eE
from above video
```dart 
import 'dart:async';

class NumeberCreator {
  var _count = 1;

  final _controller = StreamController();

  Stream get stream {
    return _controller.stream;
  }

  NumeberCreator() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      _controller.sink.add(_count);
      _count++;

      if (_count > 10) {
        timer.cancel();
        _controller.close();
      }
    });
  }
}

void main(List<String> args) {
  var myStream =
      NumeberCreator().stream.where((i) => i % 2 == 0).map((i) => i * 2);

  var subscription = myStream.listen(
      (data) {
        print(data);
      },
      onError: (err) {
        print("Errror");
      },
      cancelOnError: true, // default true
      onDone: () {
        print("Done");
      });
}
```
---------------------------------------------------

```dart 
StreamBuilder(
    stream: NumeberCreator().stream.map((i) => "$i"),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Text("No Data Yet");
      } else if (snapshot.connectionState == ConnectionState.done) {
        return Text("Done");
      } else if (snapshot.hasError) {
        return Text("Error");
      } else {
        return Text(snapshot.data ?? "");
      }
    },
  )
```
