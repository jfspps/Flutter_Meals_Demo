import 'package:flutter/material.dart';
import 'package:meals/nonscreenwidgets/main_drawer.dart';
import 'package:meals/screenwidgets/tabs.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeSet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      // gives the user the chance to navigate to the meal categories page
      drawer: MainDrawer(
        onSelectScreen: (identifier) {
          Navigator.of(context).pop();

          if (identifier == 'meals_categories') {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const TabsScreen(),
              ),
            );
          }
        },
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: _glutenFreeSet,
            // SwitchListTile expects a boolean
            onChanged: (isChecked) {
              setState(() {
                _glutenFreeSet = isChecked;
              });
            },
            title: Text(
              'Gluten-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'List Gluten free meals only',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          )
        ],
      ),
    );
  }
}