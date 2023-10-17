import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals/model/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    // make Container tappable; alternative to GestureDetector (which does not support feedback)
    return InkWell(
      onTap: () {},
      // applies only to the tapped (held down) state; the original widget is not altered
      borderRadius: BorderRadius.circular(16),
      // colour rendered when tapped
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // rendered when not tapped
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                // starting colour
                category.color.withOpacity(0.55),
                // target colour
                category.color.withOpacity(0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
