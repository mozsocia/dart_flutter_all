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
