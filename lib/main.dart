import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCSjX2JKcrGGanU81nJM3OKyxghK9JSHCY",
      appId: "110841988983:android:f379ff99d0a753261a4372",
      messagingSenderId: "110841988983",
      projectId: "flutter-app-test-99490",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Todo App',
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _todoController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;

  void _addTodo() {
    if (_todoController.text.isNotEmpty) {
      _firestore.collection('todos').add({
        'title': _todoController.text,
        'completed': false,
        'createdAt': Timestamp.now(),
      });
      _todoController.clear();
    }
  }

  void _deleteTodo(String id) {
    _firestore.collection('todos').doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Todo App'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _todoController,
            decoration: InputDecoration(
              hintText: 'Enter a new todo',
              suffixIcon: IconButton(
                icon: Icon(Icons.add),
                onPressed: _addTodo,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('todos').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final todos = snapshot.data?.docs;

                return ListView.builder(
                  itemCount: todos?.length,
                  itemBuilder: (context, index) {
                    final todo = todos?[index];
                    return ListTile(
                      title: Text(todo?['title']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: todo?['completed'],
                            onChanged: (value) {
                              _firestore
                                  .collection('todos')
                                  .doc(todo?.id)
                                  .update({
                                'completed': value,
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteTodo(todo!.id),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
