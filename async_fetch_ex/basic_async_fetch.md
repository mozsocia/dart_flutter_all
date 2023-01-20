```dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _stringRes = "";
  Map? mapResponse;
  List? listResponse;

  void apiCall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse = mapResponse!['data'];
        // debugPrint(listResponse.toString());
      });
    }
  }

  @override
  void initState() {
    apiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("api demo"),
        ),
        body: ListView.builder(
          itemCount: listResponse == null ? 0 : listResponse!.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Image.network(listResponse![index]['avatar']),
                Text(listResponse![index]['first_name']),
                SizedBox(
                  height: 40,
                )
              ],
            );
          },
        ));
  }
}



```


```dart 
import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
```








---------------------------------------

----------------------------------------


------------------------------------
<br>

### circular wait icon

```dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map mapResponse = {};
  List listResponse = [];

  void apiCall() async {
    var response =
        await http.get(Uri.parse("https://reqres.in/api/users?page=2"));

    if (response.statusCode == 200) {
      Timer(
          Duration(seconds: 5),
          () => {
                setState(() {
                  mapResponse = json.decode(response.body);
                  listResponse = mapResponse['data'];
                  // debugPrint(listResponse.toString());
                })
              });
    }
  }

  @override
  void initState() {
    apiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("api demo"),
        ),
        body: listResponse.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: listResponse.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Image.network(listResponse[index]['avatar']),
                      Text(listResponse[index]['first_name']),
                      SizedBox(
                        height: 40,
                      )
                    ],
                  );
                },
              ));
  }
}
```