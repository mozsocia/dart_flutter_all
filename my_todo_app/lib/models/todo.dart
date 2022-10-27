class Todo {
  final String title;
  final bool? isDone;
  final bool? isDeleted;
  Todo({
    required this.title,
    this.isDone = false,
    this.isDeleted = false,
  });

  Todo copyWith({
    String? title,
    bool? isDone,
    bool? isDeleted,
  }) {
    return Todo(
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
