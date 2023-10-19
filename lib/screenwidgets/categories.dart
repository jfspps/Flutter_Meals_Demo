import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/model/category.dart';
import 'package:meals/nonscreenwidgets/category_grid_item.dart';
import 'package:meals/screenwidgets/meals.dart';

import '../model/meal.dart';

class CategoriesScreen extends StatelessWidget {

  /// Composes a GridView widget of recipe categories
  const CategoriesScreen({super.key, required this.toggleFavourite});

  // daisy-chaining TabsScreen function to Meals to MealDetailsScreen;
  // this is not the preferred pattern for app-wide status and only used here for demo
  // purposes
  final void Function(Meal meal) toggleFavourite;

  /// Composes a Scaffold widget for the given category
  void _selectCategory(BuildContext context, Category category) {
    // build a list of meals based on the category id (the meal.categories is
    // effectively a list of category FKs)
    final filteredMealList = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMealList,
          toggleFavourite: toggleFavourite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              // pass _selectCategory as CategoryGridItem's onSelectCategory
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            ),
        ],
    );
  }
}
