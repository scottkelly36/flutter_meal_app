import 'package:flutter/material.dart';

//screens
import 'package:flutter_meal_app/screens/meals.dart';

//widgets
import 'package:flutter_meal_app/widgets/category_grid_item.dart';

//models
import 'package:flutter_meal_app/models/category.dart';
import 'package:flutter_meal_app/models/meal.dart';

//data
import 'package:flutter_meal_app/data/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key, required this.onToggleFavorite,
    });

  final void Function(Meal meal) onToggleFavorite;
  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) =>
            MealsScreen(
              title: category.title,
              meals: filteredMeals,
              onToggleFavorite: onToggleFavorite,
              )
            )
          );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: availableCategories.length,
        itemBuilder: (BuildContext context, int index) {
          final category = availableCategories[index];
          return CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              });
        });
  }
}
