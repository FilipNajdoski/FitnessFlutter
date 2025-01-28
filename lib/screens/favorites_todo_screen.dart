import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../screens/view_todo_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Todo> favorites;
  final void Function(int index) onRemove;

  const FavoritesScreen({
    super.key,
    required this.favorites,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final todo = favorites[index];
          return Dismissible(
            key: ValueKey(todo.title),
            direction: DismissDirection.endToStart,
            onDismissed: (_) => onRemove(index),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.star, color: Colors.white),
            ),
            child: ListTile(
              title: Text(todo.title),
              subtitle: Text(todo.description),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewTodoScreen(todo: todo),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
