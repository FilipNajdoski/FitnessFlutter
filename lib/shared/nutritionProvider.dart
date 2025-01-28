import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/models/nutrition.dart';

class NutritionProvider extends ChangeNotifier {
  final String _baseUrl = "https://www.themealdb.com/api/json/v1/1/search.php";
  // final String _categoryUrl =
  //     "https://www.themealdb.com/api/json/v1/1/list.php?c=list";
  // final String _areaUrl =
  //     "https://www.themealdb.com/api/json/v1/1/list.php?a=list";
  // final String _ingredientUrl =
  //     "https://www.themealdb.com/api/json/v1/1/list.php?i=list";

  List<Nutrition> _recipes = [];
  String _currentSearchLetter = "a";
  bool isLoading = false;

  // Getters for the lists
  List<Nutrition> get recipes => _recipes;
  String get currentSearchLetter => _currentSearchLetter;

  NutritionProvider() {
    fetchRecipes(letter: _currentSearchLetter);
  }

  // Fetch recipes from API based on the search letter
  Future<void> fetchRecipes({String letter = "a"}) async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse("$_baseUrl?f=$letter");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['meals'] != null) {
          _recipes = (data['meals'] as List)
              .map((meal) => Nutrition.fromJson(meal))
              .toList();
        } else {
          _recipes = []; // No recipes found for the letter
        }
        _currentSearchLetter = letter;
      } else {
        throw Exception("Failed to fetch recipes");
      }
    } catch (error) {
      print("Error fetching recipes: $error");
      _recipes = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void changeSearchLetter(String letter) {
    fetchRecipes(letter: letter);
  }
}
