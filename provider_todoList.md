![image](https://user-images.githubusercontent.com/12442613/198364460-3779ed53-0ba4-4c0f-af52-add1b8cc0808.png)


```dart
import 'package:flutter/cupertino.dart';
import 'package:my_todo_app/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  var todoList = <Todo>[
    Todo(title: "title one"),
    Todo(title: "title two"),
    Todo(title: "title three"),
  ];

  void addTodo(item) {
    todoList.add(item);
    notifyListeners();
  }

  void deleteTodo(item) {
    todoList.remove(item);
    notifyListeners();
  }

  void updateTodo(item) {
    final int index = todoList.indexOf(item);
    todoList.remove(item);

    todoList.insert(index, item.copyWith(isDone: !item.isDone));

    notifyListeners();
  }
}
```


```dart


// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Todo {
  final String? id;
  final String title;
  final bool? isDone;

  Todo({
    required this.title,
    this.isDone = false,
  }) : id = uuid.v4();

  Todo copyWith({
    String? title,
    bool? isDone,
    bool? isDeleted,
  }) {
    return Todo(
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}
```
```dart

import 'package:my_todo_app/providers/todo_provider.dart';
import 'package:my_todo_app/screens/todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TodoProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoScreen(),
    );
  }
}


```
```dart
import 'package:my_todo_app/widgets/add_todo.dart';
import 'package:my_todo_app/widgets/todo_list.dart';
import 'package:flutter/material.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks App'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AddTodo(),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Chip(
              label: Text(
                'Tasks:',
              ),
            ),
          ),
          TodoList()
        ],
      ),
    );
  }
}
```
```dart

import 'package:my_todo_app/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:my_todo_app/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class AddTodo extends StatelessWidget {
  AddTodo({super.key});

  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'Add Task',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            autofocus: true,
            controller: titleController,
            decoration: InputDecoration(
              label: Text('Title'),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                var newTodo = Todo(title: titleController.text);
                debugPrint(newTodo.title);
                context.read<TodoProvider>().addTodo(newTodo);
                titleController.clear();
              }
            },
            child: Text(
              'Add',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

```
```dart
import 'package:my_todo_app/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:my_todo_app/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    var todoList = context.watch<TodoProvider>().todoList;
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          var task = todoList[index];
          return Card(
            child: ListTile(
              title: Text(task.title),
              leading: Checkbox(
                value: task.isDone,
                onChanged: (value) {
                  context.read<TodoProvider>().updateTodo(task);
                },
              ),
              trailing: OutlinedButton(
                onPressed: () {
                  context.read<TodoProvider>().deleteTodo(task);
                },
                child: Icon(
                  Icons.delete,
                  size: 24.0,
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
