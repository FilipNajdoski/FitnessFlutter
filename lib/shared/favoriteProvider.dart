import 'package:flutter/material.dart';
import '../models/todo.dart';

class FavoritesProvider extends ChangeNotifier {
  List<Todo> _favorites = [];

  List<Todo> get favorites => _favorites;

  void toggleFavorite(Todo todo) {
    if (_favorites.contains(todo)) {
      _favorites.remove(todo);
    } else {
      _favorites.add(todo);
    }
    notifyListeners();
  }

  void removeFromFavorites(Todo todo) {
    _favorites.remove(todo);
    notifyListeners();
  }
}
