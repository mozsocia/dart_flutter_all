
https://www.filledstacks.com/post/complete-beginners-guide-to-futures/

Creating a Futures ....


```dart 

Future<String> myTypedFuture() async {
  await Future.delayed(Duration(seconds: 3));
  return Future.value("This is future value");
}
```


if we return a value in async function it will automatically return a Future....
```dart 

Future<String> myTypedFuture() async {
  await Future.delayed(Duration(seconds: 3));
  return "This is future value";
}
```

call a futures
```dart
ElevatedButton(
    child: Text('Run Future'),
    onPressed: () async {
        debugPrint("start");
        var value = await myTypedFuture();
        debugPrint(value);
    },
)

```

### Error Handle 

```dart
Future<String> myTypedFuture() async {
  await Future.delayed(Duration(seconds: 3));
  return Future.error('Error from return');
}
```
2nd way to throw
```dart
Future<bool> myTypedFuture() async {
    await Future.delayed(Duration(seconds: 1));
    throw Exception('Error from Exception');
  }

```

### Function to call future
```dart
void runMyFuture() {
  myTypedFuture().then((value) {
    // Run extra code here
  }, onError: (error) {
    print(error);
  });
}
```
2nd way

```dart
void runMyFuture() {
  myTypedFuture()
  .then((value) {
    // Run extra code here
  })
  .catchError((error) {
    print(error);
  }).whenComplete(() {
    print("all finised");
  });
}
```

without wrapping it in try/catch.
```dart
Future runMyFuture() async {
    var value = await myTypedFuture()
    .catchError((error) {
      print(error);
    });
  }
```




----------------------------------
----------------------------------

## Managing multiple Futures at once

```dart
// ui to call futures
FlatButton(
  child: Text('Run Future'),
  onPressed: () async {
    await runMultipleFutures();
  },
)

// Future to run
Future<bool> myTypedFuture(int id, int duration) async {
  await Future.delayed(Duration(seconds: duration));
  print('Delay complete for Future $id');
  return true;
}


// Running multiple futures
Future runMultipleFutures() async {
  // Create list of multiple futures
  var futures = List<Future>();
  for(int i = 0; i < 10; i++) {
    futures.add(myTypedFuture(i, Random(i).nextInt(10)));
  }
  // Waif for all futures to complete
  await Future.wait(futures);

  // We're done with all futures execution
  print('All the futures has completed');
}
```



---------------------------------
---------------------------------------
------------------------------------
------------------------------------
FutureBuilder for flutter to show text conditionally
```dart
  FutureBuilder(
    future: myTypedFuture(),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text("There was an Error");
      } else if (snapshot.hasData) {
        return Text("${snapshot.data}");
      } else {
        return Text("No Value Yet");
      }
    },
  )
```