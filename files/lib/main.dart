import 'package:flutter/material.dart';
import 'package:future_app/Stream_prac2.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(title: 'Flutter Demo Home Page'),
  ));
}

class HomePage extends StatelessWidget {
  final String title;
  const HomePage({super.key, required this.title});

  Future<String> myTypedFuture() async {
    await Future.delayed(Duration(seconds: 4));
    return Future.value('value from return');
    // return Future.error('value from return');
  }

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
            Text("This is Future Practice"),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              child: Text('Run Future'),
              onPressed: () async {
                myTypedFuture().then((value) {
                  // Run extra code here
                }).catchError((error) {
                  print(error);
                }).whenComplete(() {
                  print("all finised");
                });
              },
            ),
            SizedBox(
              height: 30,
            ),
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
            ),
            SizedBox(
              height: 30,
            ),
            StreamBuilder(
              stream: NumeberCreator().stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("No Data Yet");
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return Text("Done");
                } else if (snapshot.hasError) {
                  return Text("Error");
                } else {
                  return Text("${snapshot.data}");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
