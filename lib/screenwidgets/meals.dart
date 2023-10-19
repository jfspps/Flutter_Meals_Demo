import 'package:flutter/material.dart';
import 'package:meals/nonscreenwidgets/meal_item.dart';
import 'package:meals/screenwidgets/meal_details.dart';

import '../model/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  // allow other parent widgets to handle the title
  final String? title;
  final List<Meal> meals;

  void navigateToMealDetail(BuildContext context, Meal meal) {
    // calling push() without pop() means this MealsScreen is recorded as the last
    // page and the back button would lead the user to MealsScreen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget pageContent = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) => MealItem(
        meal: meals[index],
        onSelectMeal: (context, meal) {
          navigateToMealDetail(context, meal);
        },
      ),
    );

    if (meals.isEmpty) {
      pageContent = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Nothing here...',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Select a different category',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            )
          ],
        ),
      );
    }

    // deduce Widget returned based on title
    if (title == null){
      return pageContent;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: pageContent,
    );
  }
}
