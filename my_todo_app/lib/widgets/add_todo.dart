import 'package:my_todo_app/models/todo.dart';
import 'package:flutter/material.dart';

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
              var newTodo = Todo(title: titleController.text);
              debugPrint(newTodo.title);
            },
            child: Text(
              'Add',
              style: TextStyle(fontSize: 20),
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     TextButton(
          //       onPressed: () {
          //         Navigator.pop(context);
          //       },
          //       child: Text("Cancel"),
          //     ),
          //     ElevatedButton(
          //       onPressed: () {
          //         var newTodo = Todo(title: titleController.text);
          //       },
          //       child: Text('Add'),
          //     ),
          //   ],
          // ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
