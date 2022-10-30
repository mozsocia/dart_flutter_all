```dart


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

// The state of our StateNotifier should be immutable.
// We could also use packages like Freezed to help with the implementation.
@immutable
class Todo {
  // All properties should be `final` on our class.
  final String id;
  final String description;
  final bool completed;

  Todo({
    required this.description,
    this.completed = false,
  }) : id = uuid.v4();

  // Since Todo is immutable, we implement a method that allows cloning the
  // Todo with slightly different content.
  Todo copyWith({
    String? description,
    bool? completed,
  }) {
    return Todo(
      description: description ?? this.description,
      completed: completed ?? this.completed,
    );
  }
}

```

```dart
// The StateNotifier class that will be passed to our StateNotifierProvider.
// This class should not expose state outside of its "state" property, which means
// no public getters/properties!
// The public methods on this class will be what allow the UI to modify the state.
class TodosNotifier extends StateNotifier<List<Todo>> {
  // We initialize the list of todos to an empty list
  TodosNotifier()
      : super([
          Todo(description: "This is one Description"),
          Todo(description: "This is two Description"),
          Todo(description: "This is three Description"),
        ]);

  // Let's allow the UI to add todos.
  void addTodo(Todo todo) {
    // Since our state is immutable, we are not allowed to do `state.add(todo)`.
    // Instead, we should create a new list of todos which contains the previous
    // items and the new one.
    // Using Dart's spread operator here is helpful!
    state = [...state, todo];
    // No need to call "notifyListeners" or anything similar. Calling "state ="
    // will automatically rebuild the UI when necessary.
  }

  // Let's allow removing todos
  void removeTodo(String todoId) {
    // Again, our state is immutable. So we're making a new list instead of
    // changing the existing list.
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }

  // Let's mark a todo as completed
  void toggle(String todoId) {
    state = [
      for (final todo in state)
        // we're marking only the matching todo as completed
        if (todo.id == todoId)
          // Once more, since our state is immutable, we need to make a copy
          // of the todo. We're using our `copyWith` method implemented before
          // to help with that.
          todo.copyWith(completed: !todo.completed)
        else
          // other todos are not modified
          todo,
    ];
  }
}

```

```dart
// Finally, we are using StateNotifierProvider to allow the UI to interact with
// our TodosNotifier class.
final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
  return TodosNotifier();
});


```

```dart
class TodoListView extends ConsumerWidget {
  const TodoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // rebuild the widget when the todo list changes
    List<Todo> todos = ref.watch(todosProvider);

    // Let's render the todos in a scrollable list view
    return Expanded(
      child: ListView(
        padding: EdgeInsets.all(10),
        children: [
          for (final todo in todos)
            CheckboxListTile(
              value: todo.completed,
              // When tapping on the todo, change its completed status
              onChanged: (value) =>
                  ref.read(todosProvider.notifier).toggle(todo.id),
              title: Text(todo.description),
              subtitle: Text(todo.id),
            ),
        ],
      ),
    );
  }
}

```
