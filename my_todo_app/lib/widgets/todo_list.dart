import 'package:my_todo_app/models/todo.dart';
import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    var todoList = <Todo>[
      Todo(title: "title one"),
      Todo(title: "title two"),
      Todo(title: "title three"),
    ];
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
                onChanged: (value) {},
              ),
              trailing: OutlinedButton(
                onPressed: () {},
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
