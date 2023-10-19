import 'package:flutter/material.dart';
import 'package:meals/screenwidgets/categories.dart';
import 'package:meals/screenwidgets/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const CategoriesScreen();
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      // with a null title, activePage is a Center widget (not a Scaffold) and...
      activePage = const MealsScreen(meals: []);
      // ...TabsScreen is responsible for setting the title
      activePageTitle = 'Favourites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      // the tabIndex is an int already part of Flutter's BottomNavigationBar
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