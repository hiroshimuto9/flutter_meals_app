import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../dummy_data.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayMeals;
  bool _loadedInitDate = false;

  @override
  void initState() {
    
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitDate) {
      final routeArgs = 
        ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayMeals = DUMMY_MEALS.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitDate = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayMeals.removeWhere((meal) => meal.id == mealId);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle)
      ),
      body: ListView.builder(itemBuilder: (ctx, index) {
        return MealItem(
          id: displayMeals[index].id,
          title: displayMeals[index].title,
          imageUrl: displayMeals[index].imageUrl,
          duration: displayMeals[index].duration,
          complexity: displayMeals[index].complexity,
          affordability: displayMeals[index].affordability,
          removeItem: _removeMeal,
        );
      }, itemCount: displayMeals.length,)
    );
  }
}