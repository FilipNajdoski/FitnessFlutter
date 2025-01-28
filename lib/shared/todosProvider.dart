import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodosProvider extends ChangeNotifier {
  final List<Todo> todos = List.generate(
    5,
    (i) => Todo('Todo $i', 'A description of what needs to be done for Todo $i',
        isCompleted: false),
  );

  void addTodo(Todo todo) {
    todos.add(todo);
    notifyListeners();
  }

  void deleteTodoAt(int index) {
    todos.removeAt(index);
    notifyListeners();
  }

  void editTodo(Todo updatedTodo, int index) {
    todos[index] = updatedTodo;
    notifyListeners();
  }

  void toggleCompletion(int index) {
    todos[index].isCompleted = !todos[index].isCompleted;
    notifyListeners();
  }
}
