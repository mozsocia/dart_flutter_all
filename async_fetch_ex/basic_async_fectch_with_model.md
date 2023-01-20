```dart 
class Todo {
  String? title;
  String? loc;

  Todo(this.title, this.loc);

  Todo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    loc = json['loc'];
  }
}
```




```dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:myapp/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> _todos = <Todo>[];

  apiCall() async {
    var response = await http.get(Uri.parse(
        "https://my-json-server.typicode.com/mozsocia/json_db/trips"));

    var todos = <Todo>[];

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var item in notesJson) {
        todos.add(Todo.fromJson(item));
      }
    }
    setState(() {
      _todos.addAll(todos);
    });
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
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(10),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: Colors.black12, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("${_todos[index].title}"),
                    Text("${_todos[index].loc}"),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
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

