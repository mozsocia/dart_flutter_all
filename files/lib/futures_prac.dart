import 'package:flutter/material.dart';

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
          ],
        ),
      ),
    );
  }
}

Future<String> myTypedFuture() async {
  await Future.delayed(Duration(seconds: 4));
  return Future.value('value from return');
}
