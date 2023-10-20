import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/nonscreenwidgets/main_drawer.dart';
import 'package:meals/screenwidgets/categories.dart';
import 'package:meals/screenwidgets/filters.dart';
import 'package:meals/screenwidgets/meals.dart';

import '../model/meal.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

/// A stateful widget that renders a page as a Scaffold widget based on the
/// selected page's index. The latter is updated via BottomNavigationBar.onTap.
class TabsScreen extends StatefulWidget {
  /// Composes a Scaffold widget
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> favouriteMeals = [];
  Map<Filter, bool> selectedFilters = kInitialFilters;

  // workaround for the star icon not reflecting the favourite status
  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // this is passed a couple of times in succession to child widgets;
  // necessary to update the state of the list called from other widgets
  void _toggleFavouriteStatus(Meal meal) {
    if (favouriteMeals.contains(meal)) {
      setState(() {
        favouriteMeals.remove(meal);
        _showInfoMessage('Removed meal from favourites');
      });
    } else {
      setState(() {
        favouriteMeals.add(meal);
        _showInfoMessage('Added meal to favourites');
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    // without this, the filters screen back button returns the user to the drawer;
    // if meals_categories was chosen then this just closes the drawer
    Navigator.of(context).pop();

    if (identifier == 'filters') {
      // a FiltersScreen WillPopScope pop() method can return a future and would then be
      // returned by this push() method; the Future<Map<Filter, bool>> is expected
      // (Filter as keys and bool values) so the push() generic
      // is classed
      final resultantMap = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            savedFilters: selectedFilters,
          ),
        ),
      );

      setState(() {
        selectedFilters = resultantMap ?? kInitialFilters;
      });
      log('Filter: $selectedFilters');
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredMeals = dummyMeals.where((meal) {
      if (selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    // set the defaults on startup
    Widget activePage = CategoriesScreen(
      toggleFavourite: _toggleFavouriteStatus,
      availableMeals: filteredMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      // with a null title, activePage is a Center widget (not a Scaffold) and...
      activePage = MealsScreen(
        meals: favouriteMeals,
        toggleFavourite: _toggleFavouriteStatus,
      );
      // ...TabsScreen is responsible for setting the title
      activePageTitle = 'Favourites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        // onTap expects an int, representing the BottomNavigationBar index; based on
        // _selectPage(), this eventually updates _selectedPageIndex
        onTap: _selectPage,
        // *keep currentIndex in sync with _selectedPageIndex
        currentIndex: _selectedPageIndex,
        items: const [
          // *by default, the first tab is selected regardless of currentIndex
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}
