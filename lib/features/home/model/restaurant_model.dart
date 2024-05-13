class RestaurantModel {
  final String name;
  final String cuisineType;
  final int maxPrice;
  final int minPrice;
  final double averageRating;
  final String? logo;

  RestaurantModel({
    required this.name,
    required this.cuisineType,
    required this.maxPrice,
    required this.minPrice,
    required this.averageRating,
    this.logo,
  });
}
