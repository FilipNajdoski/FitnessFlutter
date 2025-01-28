import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/screens/create_todo_screen.dart';
import 'package:untitled/screens/edit_todo_screen.dart';
import 'package:untitled/screens/view_todo_screen.dart';
import '../models/todo.dart';
import '../shared/todosProvider.dart';
import '../shared/favoriteProvider.dart';
import '../widgets/todo_list.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  String _searchQuery = '';

  void _onSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _createNewTodo() async {
    final newTodo = await Navigator.push<Todo?>(
      context,
      MaterialPageRoute(builder: (context) => const CreateTodoScreen()),
    );

    if (newTodo != null) {
      context.read<TodosProvider>().addTodo(newTodo);
    }
  }

  void _editTodoItem(Todo todo, int index) async {
    final editedTodo = await Navigator.push<Todo?>(
      context,
      MaterialPageRoute(builder: (context) => EditTodoScreen(todo: todo)),
    );

    if (editedTodo != null) {
      context.read<TodosProvider>().editTodo(editedTodo, index);
    }
  }

  void _deleteTodoItem(int index) {
    final todoToDelete = context.read<TodosProvider>().todos[index];
    context.read<TodosProvider>().deleteTodoAt(index);
    context.read<FavoritesProvider>().toggleFavorite(todoToDelete);
  }

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<TodosProvider>().todos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: _onSearch,
              decoration: const InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: TodoList(
              todos: todos
                  .where((todo) => todo.title
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase()))
                  .toList(),
              onDelete: _deleteTodoItem,
              onEdit: _editTodoItem,
              onTap: (todo) async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewTodoScreen(todo: todo),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewTodo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
