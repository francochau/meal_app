enum Complexity { Simple, Challenging, Hard }
enum Affordability { Affordable, Pricey, Luxurious }

class Meal {
  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  const Meal(
      {this.id,
      this.title,
      this.categories,
      this.complexity,
      this.affordability,
      this.duration,
      this.imageUrl,
      this.ingredients,
      this.isGlutenFree,
      this.isLactoseFree,
      this.isVegan,
      this.isVegetarian,
      this.steps});
}
