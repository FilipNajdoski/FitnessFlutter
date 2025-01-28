import 'package:flutter/material.dart';
import 'package:untitled/models/nutrition.dart';

class NutritionWidget extends StatefulWidget {
  final Nutrition recipe;

  const NutritionWidget({Key? key, required this.recipe}) : super(key: key);

  @override
  _NutritionWidgetState createState() => _NutritionWidgetState();
}

class _NutritionWidgetState extends State<NutritionWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.network(
                widget.recipe.mealThumb,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipe Name
                  Text(
                    widget.recipe.mealName,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  // Category and Area
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.recipe.category,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        widget.recipe.area,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Tags
                  if (widget.recipe.tags != null)
                    Wrap(
                      spacing: 8,
                      children: widget.recipe.tags!.split(',').map((tag) {
                        return Chip(
                          label: Text(tag),
                          backgroundColor: Colors.green,
                        );
                      }).toList(),
                    ),
                  const SizedBox(height: 8),
                  // Expandable content
                  if (_isExpanded)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Ingredients
                        Text(
                          'Ingredients:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        for (int i = 0;
                            i < widget.recipe.ingredients.length;
                            i++)
                          if (widget.recipe.ingredients[i].isNotEmpty)
                            Text(
                              '${widget.recipe.ingredients[i]} - ${widget.recipe.measures[i]}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                        const SizedBox(height: 16),
                        // Instructions
                        Text(
                          'Instructions:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.recipe.instructions,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
