import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/shared/nutritionProvider.dart';
import 'package:untitled/widgets/nutrition_widget.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NutritionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipes"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (letter) => provider.changeSearchLetter(letter),
            itemBuilder: (context) => List.generate(
              26,
              (index) => PopupMenuItem(
                value: String.fromCharCode(97 + index), // 'a' to 'z'
                child: Text(String.fromCharCode(97 + index).toUpperCase()),
              ),
            ),
          ),
        ],
      ),
      body: Consumer<NutritionProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.recipes.isEmpty) {
            return Center(
              child: Text(
                "No recipes found for '${provider.currentSearchLetter.toUpperCase()}'",
              ),
            );
          }

          return ListView.builder(
            itemCount: provider.recipes.length,
            itemBuilder: (context, index) {
              final recipe = provider.recipes[index];
              return NutritionWidget(recipe: recipe);
            },
          );
        },
      ),
    );
  }
}
