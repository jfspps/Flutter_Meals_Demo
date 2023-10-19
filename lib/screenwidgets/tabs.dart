import 'package:flutter/material.dart';
import 'package:meals/screenwidgets/categories.dart';
import 'package:meals/screenwidgets/meals.dart';

import '../model/meal.dart';

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

  // this is passed a couple of times in succession to child widgets
  void _toggleFavouriteStatus(Meal meal) {
    if (favouriteMeals.contains(meal)) {
      favouriteMeals.remove(meal);
    } else {
      favouriteMeals.add(meal);
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // set the defaults on startup
    Widget activePage = CategoriesScreen(
      toggleFavourite: _toggleFavouriteStatus,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      // with a null title, activePage is a Center widget (not a Scaffold) and...
      activePage = MealsScreen(
        meals: [],
        toggleFavourite: _toggleFavouriteStatus,
      );
      // ...TabsScreen is responsible for setting the title
      activePageTitle = 'Favourites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
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
