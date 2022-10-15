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
