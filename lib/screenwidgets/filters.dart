import 'package:flutter/material.dart';
import 'package:meals/nonscreenwidgets/main_drawer.dart';
import 'package:meals/screenwidgets/tabs.dart';

// available to anything that imports filters.dart e.g. tabs.dart
enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.savedFilters});

  final Map<Filter, bool> savedFilters;

  @override
  State<StatefulWidget> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFreeSet = false;
  bool _lactoseFreeSet = false;
  bool _vegetarianSet = false;
  bool _veganSet = false;

  @override
  void initState() {
    super.initState();
    // access Stateful variables via their State widget; initState runs before build()
    // so setState() is not required
    _glutenFreeSet = widget.savedFilters[Filter.glutenFree]!;
    _lactoseFreeSet = widget.savedFilters[Filter.lactoseFree]!;
    _vegetarianSet = widget.savedFilters[Filter.vegetarian]!;
    _veganSet = widget.savedFilters[Filter.vegan]!;
  }

  TextStyle _buildTitleTheme(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .titleLarge!
        .copyWith(color: Theme.of(context).colorScheme.onBackground);
  }

  TextStyle _buildSubtitleTheme() {
    return Theme.of(context)
        .textTheme
        .labelMedium!
        .copyWith(color: Theme.of(context).colorScheme.onBackground);
  }

  Color _buildActiveColor() {
    return Theme.of(context).colorScheme.tertiary;
  }

  EdgeInsetsGeometry _buildPadding() {
    return const EdgeInsets.only(left: 34, right: 22);
  }

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
      body: WillPopScope(
        // defines a Future that is called when the user leaves the current screen,
        // usually through the app or Android back button
        onWillPop: () async {
          // use pop() to forward data as a map to the next screen in the stack i.e. the TabsScreen
          // through the push() method used to add FiltersScreen to the stack
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeSet,
            Filter.lactoseFree: _lactoseFreeSet,
            Filter.vegetarian: _vegetarianSet,
            Filter.vegan: _veganSet
          });

          return false;
        },
        child: Column(
          children: [
            // seems key here to initialise SwitchListTile via its constructor to
            // be able to invoke setState; defining a function that returns a
            // SwitchListTile instance (with setState called within the function)
            // renders correctly on the UI but the filter toggle does not update on
            // request
            SwitchListTile(
              value: _glutenFreeSet,
              onChanged: (checked) {
                setState(() {
                  _glutenFreeSet = checked;
                });
              },
              title: Text(
                'Gluten-free',
                style: _buildTitleTheme(context),
              ),
              subtitle: Text(
                'List gluten-free meals only',
                style: _buildSubtitleTheme(),
              ),
              activeColor: _buildActiveColor(),
              contentPadding: _buildPadding(),
            ),
            SwitchListTile(
              value: _lactoseFreeSet,
              onChanged: (checked) {
                setState(() {
                  _lactoseFreeSet = checked;
                });
              },
              title: Text(
                'Lactose-free',
                style: _buildTitleTheme(context),
              ),
              subtitle: Text(
                'List lactose-free meals only',
                style: _buildSubtitleTheme(),
              ),
              activeColor: _buildActiveColor(),
              contentPadding: _buildPadding(),
            ),
            SwitchListTile(
              value: _vegetarianSet,
              onChanged: (checked) {
                setState(() {
                  _vegetarianSet = checked;
                });
              },
              title: Text(
                'Vegetarian',
                style: _buildTitleTheme(context),
              ),
              subtitle: Text(
                'List vegetarian meals only',
                style: _buildSubtitleTheme(),
              ),
              activeColor: _buildActiveColor(),
              contentPadding: _buildPadding(),
            ),
            SwitchListTile(
              value: _veganSet,
              onChanged: (checked) {
                setState(() {
                  _veganSet = checked;
                });
              },
              title: Text(
                'Vegan',
                style: _buildTitleTheme(context),
              ),
              subtitle: Text(
                'List vegan meals only',
                style: _buildSubtitleTheme(),
              ),
              activeColor: _buildActiveColor(),
              contentPadding: _buildPadding(),
            ),
          ],
        ),
      ),
    );
  }
}
