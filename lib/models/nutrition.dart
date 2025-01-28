class Nutrition {
  final String idMeal;
  final String mealName;
  final String? drinkAlternate;
  final String category;
  final String area;
  final String instructions;
  final String mealThumb;
  final String? tags;
  final String? youtube;
  final List<String> ingredients;
  final List<String> measures;
  final String? source;
  final String? imageSource;
  final bool? creativeCommonsConfirmed;
  final DateTime? dateModified;

  Nutrition({
    required this.idMeal,
    required this.mealName,
    this.drinkAlternate,
    required this.category,
    required this.area,
    required this.instructions,
    required this.mealThumb,
    this.tags,
    this.youtube,
    required this.ingredients,
    required this.measures,
    this.source,
    this.imageSource,
    this.creativeCommonsConfirmed,
    this.dateModified,
  });

  // Factory constructor for JSON deserialization
  factory Nutrition.fromJson(Map<String, dynamic> json) {
    return Nutrition(
      idMeal: json['idMeal'] as String,
      mealName: json['strMeal'] as String,
      drinkAlternate: json['strDrinkAlternate'] as String?,
      category: json['strCategory'] as String,
      area: json['strArea'] as String,
      instructions: json['strInstructions'] as String,
      mealThumb: json['strMealThumb'] as String,
      tags: json['strTags'] as String?,
      youtube: json['strYoutube'] as String?,
      ingredients: List<String>.generate(
        20,
        (index) => json['strIngredient${index + 1}'] as String? ?? '',
      ).where((ingredient) => ingredient.isNotEmpty).toList(),
      measures: List<String>.generate(
        20,
        (index) => json['strMeasure${index + 1}'] as String? ?? '',
      ).where((measure) => measure.isNotEmpty).toList(),
      source: json['strSource'] as String?,
      imageSource: json['strImageSource'] as String?,
      creativeCommonsConfirmed: json['strCreativeCommonsConfirmed'] == null
          ? null
          : json['strCreativeCommonsConfirmed'] == 'Yes',
      dateModified: json['dateModified'] == null
          ? null
          : DateTime.parse(json['dateModified'] as String),
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'idMeal': idMeal,
      'strMeal': mealName,
      'strDrinkAlternate': drinkAlternate,
      'strCategory': category,
      'strArea': area,
      'strInstructions': instructions,
      'strMealThumb': mealThumb,
      'strTags': tags,
      'strYoutube': youtube,
      'strIngredients': ingredients,
      'strMeasures': measures,
      'strSource': source,
      'strImageSource': imageSource,
      'strCreativeCommonsConfirmed':
          creativeCommonsConfirmed == true ? 'Yes' : 'No',
      'dateModified': dateModified?.toIso8601String(),
    };
  }
}
