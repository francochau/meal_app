import 'package:flutter/material.dart';
import 'package:meal_app/screens/favorites_screen.dart';
import './dummy_data.dart';
import './models/meal.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';
import 'screens/catagory_meal_screen.dart';
import 'screens/catagories_screen.dart';
import 'screens/catagories_screen.dart';
import 'screens/tabs_screen.dart';
import 'dummy_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoritedMeals = [];

  void _toggleFavorites(String mealId) {
    final existingIndex =
        _favoritedMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoritedMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritedMeals
            .add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  void _setFilter(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] == true && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] == true && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] == true && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  bool _isMealFavorite(String id) {
    return _favoritedMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.teal,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              headline6: TextStyle(
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
              ))),
      home: TabScreen(_favoritedMeals),
      routes: {
        CategoryMealScreen.routeName: (context) =>
            CategoryMealScreen(_availableMeals),
        MaterialDetailScreen.routeName: (context) =>
            MaterialDetailScreen(_toggleFavorites, _isMealFavorite),
        FilterScreen.routeName: (context) => FilterScreen(_setFilter, _filters),
      },
      // onGenerateRoute: (setting){
      //   print(setting.arguments);
      //   return MaterialPageRoute(builder: (ctx)=>CategoryMealScreen())
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CatagoriesScreen());
      },
    );
  }
}
