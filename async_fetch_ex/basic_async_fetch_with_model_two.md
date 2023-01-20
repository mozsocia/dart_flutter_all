```dart
import 'dart:convert';

class Todo {
  Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  int userId;
  int id;
  String title;
  bool completed;

  factory Todo.fromRawJson(String str) => Todo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
      };
}


```

```dart
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/todo.dart';

class TodoService {
  static Future<List<Todo>> getTodos() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);

      return jsonResponse.map((e) => Todo.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }
}

void main() {
  runApp(const MyApp1());
}

class MyApp1 extends StatelessWidget {
  const MyApp1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    TodoService.getTodos().then((todos) {
      setState(() {
        _todos = todos;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Text(_todos[index].title),
              SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
```
