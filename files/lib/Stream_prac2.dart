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
