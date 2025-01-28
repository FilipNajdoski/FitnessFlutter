import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo.dart';
import '../shared/favoriteProvider.dart';
import '../shared/todosProvider.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final void Function(Todo todo, int index) onEdit;
  final void Function(int index) onDelete;
  final void Function(Todo todo)? onTap;

  const TodoList({
    super.key,
    required this.todos,
    required this.onEdit,
    required this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>().favorites;

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        final isFavorite = favorites.contains(todo);

        return Dismissible(
          key: Key(todo.title),
          background: Container(
            color: isFavorite ? Colors.red : Colors.yellow,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              color: Colors.white,
            ),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          direction: DismissDirection.horizontal,
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              // Swipe right to toggle favorite
              context.read<FavoritesProvider>().toggleFavorite(todo);
              final snackBar = SnackBar(
                content: Text(isFavorite
                    ? 'Removed from favorites list'
                    : 'Added to favorites list'),
                duration: Duration(seconds: 2),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              return false;
            } else if (direction == DismissDirection.endToStart) {
              // Swipe left to delete
              onDelete(index);
              return true;
            }
            return false;
          },
          child: ListTile(
            title: Text(todo.title),
            subtitle: Text(todo.description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    !todo.isCompleted
                        ? Icons.check_box_outline_blank
                        : Icons.done,
                  ),
                  onPressed: () {
                    context.read<TodosProvider>().toggleCompletion(index);
                    final snackBar = SnackBar(
                      content: Text(!todo.isCompleted
                          ? 'Marked as incomplete'
                          : 'Marked as complete'),
                      duration: Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => onEdit(todo, index),
                ),
              ],
            ),
            onTap: onTap != null ? () => onTap!(todo) : null,
          ),
        );
      },
    );
  }
}
