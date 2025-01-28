class Todo {
  String title;
  String description;
  DateTime? dueDate;
  String priority;
  bool isCompleted;
  String? locationId;

  Todo(
    this.title,
    this.description, {
    this.dueDate,
    this.priority = 'Low',
    this.isCompleted = true,
    this.locationId,
  });
}
