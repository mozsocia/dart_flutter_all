todo.dart
```dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

List<Todo> todoFromJson(String str) =>
    List<Todo>.from(json.decode(str).map((x) => Todo.fromJson(x)));

String todoToJson(List<Todo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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

class TodoEvent {}

class TodoState {
  List<Todo> todos = [];
  TodoState({required this.todos});
}

class FetchTodosEvent extends TodoEvent {
  var url = Uri.parse('https://jsonplaceholder.typicode.com/todos');
}

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState(todos: [])) {
    on<FetchTodosEvent>((event, emit) async {
      final response = await http.get(event.url);
      if (response.statusCode == 200) {
        final List<Todo> todos = todoFromJson(response.body);
        emit(TodoState(todos: todos));
      } else {
        throw Exception('Failed to load todos');
      }
    });
  }
}

```


main.dart
```dart
import 'package:flutter/material.dart';
import 'package:myapp/todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      create: (context) => TodoBloc(),
      child: TodoPage(),
    );
  }
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  void initState() {
    super.initState();
    // BlocProvider.of<TodoBloc>(context).add(FetchTodosEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("This is bloc fetch example"),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state.todos.isEmpty) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  BlocProvider.of<TodoBloc>(context).add(FetchTodosEvent());
                },
                child: Text("Fetch Todos"),
              ),
            );
          }
          return ListView.builder(
            itemCount: state.todos.length,
            itemBuilder: (BuildContext context, int index) {
              return Text(state.todos[index].title);
            },
          );
        },
      ),
    );
  }
}

```