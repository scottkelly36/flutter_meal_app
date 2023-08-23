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

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealsScreen(
        title: category.title,
        meals: filteredMeals,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView.builder(
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
          }),
      builder: (context, child) => Padding(
          padding: EdgeInsets.only(top:100 - _animationController.value * 100),
          child: child),
    );
  }
}
