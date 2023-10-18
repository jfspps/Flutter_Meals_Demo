import 'package:flutter/material.dart';
import 'package:meals/nonscreenwidgets/meal_item_metadata.dart';
import 'package:transparent_image/transparent_image.dart';

import '../model/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
  });

  final Meal meal;

  // render the enum
  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      // shape is ignored by Stack widget by default so override with Card's clipBehaviour
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      // give a shadow, lifted effect
      elevation: 2,
      child: InkWell(
        onTap: () {},
        child: Stack(
          // the first widget will be placed at the lowest layer of the page, the next overlaps that
          // and the next overlaps that, and so on
          children: [
            // MemoryImage handles images to/from memory, and pass the transparent_image as
            // kTransparentImage; NetworkImage loads images from a network
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              // consistent image height and stretch horizontally
              width: double.infinity,
              height: 200,
            ),
            // controls where the Positioned widget's child widget is placed relative to the above;
            // since this is a stack, the Positioned widget's child widget is placed on top, i.e. overlaps the above
            Positioned(
              bottom: 0, // sits right on top (overlaps) of corresponding widget
              left:
                  0, // align with corresponding widget's left-hand border (>0 would set this widget within a border)
              right: 0, // align with corresponding widget's right-hand border
              child: Container(
                color: Colors.black38,
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 40,
                ),
                // use this for the meal title and meal metadata
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      // only applies if > 2 lines
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemMetadata(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemMetadata(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemMetadata(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
