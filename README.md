# meals

Introducing multiscreen apps with Flutter

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Google fonts

Google fonts were added with the command ```flutter pub add google_fonts```, which retrieves the
package from [pub.dev](https://pub.dev/). This command automatically updates the [pubspec.yaml](pubspec.yaml)
dependencies list.

### Transparent Image

The [transparent image plugin](https://pub.dev/packages/transparent_image) is used as part of the
[meal item](./lib/nonscreenwidgets/meal_item.dart) transition (onTap). Use the command
```flutter pub add transparent_image```.

### Stack oof pages

The Navigator push() method adds to the stack of pages and preserves the sequence of pages viewed,
making the back button behave as normal.

The Navigator pushReplacement() method removes the current page from the stack and adds the new
page. The back button behaviour then differs.
