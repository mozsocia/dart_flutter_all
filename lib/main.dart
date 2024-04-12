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

  int _selectedIndex =
      0; // Index to keep track of selected bottom navigation bar item

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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

  void _deleteTodo(String id) async {
    final todoDoc = await _firestore.collection('todos').doc(id).get();
    final todoTitle = todoDoc.data()?['title'];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Are you sure you want to delete $todoTitle?"),
        action: SnackBarAction(
          label: 'Delete',
          onPressed: () {
            _firestore.collection('todos').doc(id).delete();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$todoTitle deleted successfully!'),
              ),
            );
          },
        ),
      ),
    );
  }

  void _addTodoDaily() {
    if (_todoController.text.isNotEmpty) {
      _firestore.collection('daily_target').add({
        'title': _todoController.text,
        'completed': false,
        'createdAt': Timestamp.now(),
      });
      _todoController.clear();
    }
  }

  void _deleteTodoDaily(String id) async {
    final todoDoc = await _firestore.collection('daily_target').doc(id).get();
    final todoTitle = todoDoc.data()?['title'];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Are you sure you want to delete $todoTitle?"),
        action: SnackBarAction(
          label: 'Delete',
          onPressed: () {
            _firestore.collection('daily_target').doc(id).delete();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$todoTitle deleted successfully!'),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mozdalif Todo App'),
      ),
      body: _selectedIndex == 0
          ? _buildTodayTodoList()
          : _selectedIndex == 1
              ? _buildOldTodoList()
              : _buildDailyTargetPage(), // Method to build old todo list
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: 'Today Todo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Old Todo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Daily Target', // New menu item
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildTodayTodoList() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
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
              stream: _firestore
                  .collection('todos')
                  .where('createdAt',
                      isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day)))
                  .where('createdAt',
                      isLessThan: Timestamp.fromDate(DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day)
                          .add(const Duration(days: 1))))
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
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

  Widget _buildOldTodoList() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('todos')
            .where('createdAt',
                isLessThan: Timestamp.fromDate(
                    DateTime.now().subtract(Duration(days: 1))))
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final todos = snapshot.data?.docs;

          // Variables to track the previous date
          DateTime? previousDate;
          bool showBadge = false;

          return ListView.builder(
            itemCount: todos?.length,
            itemBuilder: (context, index) {
              final todo = todos?[index];

              // Extract the createdAt timestamp from the todo document
              final createdAt = todo?['createdAt'] as Timestamp;
              final todoDate =
                  DateTime.fromMillisecondsSinceEpoch(createdAt.seconds * 1000);

              // Check if this todo belongs to a new date
              if (previousDate == null || todoDate.day != previousDate?.day) {
                // If a new date, update previousDate and set showBadge to true
                previousDate = todoDate;
                showBadge = true;
              } else {
                // If not a new date, set showBadge to false
                showBadge = false;
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showBadge) // Show the badge if it's a new date
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      margin: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '${todoDate.day}/${todoDate.month}/${todoDate.year}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ListTile(
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
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDailyTargetPage() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextField(
            controller: _todoController,
            decoration: InputDecoration(
              hintText: 'Enter a new daily target',
              suffixIcon: IconButton(
                icon: Icon(Icons.add),
                onPressed: _addTodoDaily,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('daily_target')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
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
                                  .collection('daily_target')
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
                            onPressed: () => _deleteTodoDaily(todo!.id),
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
