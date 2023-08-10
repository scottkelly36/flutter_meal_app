import 'package:flutter/material.dart';
import 'package:flutter_meal_app/widgets/category_grid_item.dart';

import 'package:flutter_meal_app/data/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: const Text('Pick a Category'),
      ),
      body: GridView.builder(
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
          return CategoryGridItem(category: category);
        }
      ),
    );
  }
}