import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants/core/constants/data.dart';
import 'package:restaurants/features/home/model/restaurant_model.dart';
import 'package:restaurants/features/home/view/widget/sheet_type_options.dart';
import 'package:restaurants/features/home/view/widget/sheet_rating_options.dart';

part 'restaurant_store.g.dart';

class RestaurantStore = RestaurantStoreBase with _$RestaurantStore;

abstract class RestaurantStoreBase with Store {
  RestaurantStoreBase(BuildContext _);

  final dataSource = restaurants;
  @observable
  bool isSearchEnabled = false;
  double selectedRating = listOfRating.first;
  String selectedType = listOfCuisine.first;
  @observable
  ObservableList<RestaurantModel> searchResults = ObservableList.of([]);

  @action
  void searchByName(String name) {
    // Convert the dataSource list into a map for faster lookup
    Map<String, RestaurantModel> itemMap =
        Map.fromIterable(dataSource, key: (item) => item.name);

    // Filter the items based on the search criteria
    isSearchEnabled = true;
    searchResults.addAll(itemMap.values.where((item) {
      return item.name.toLowerCase().trim().contains(name);
    }));
  }

  @action
  void searchByType(String type) {
    selectedType = type;
    // Convert the dataSource list into a map for faster lookup
    searchResults.clear();
    Map<String, RestaurantModel> itemMap = Map.fromIterable(dataSource,
        key: (item) => "${item.cuisineType}${item.name}");

    // Filter the items based on the search criteria
    isSearchEnabled = true;
    searchResults.addAll(itemMap.values.where((item) => _filterByType(item)));
  }

  @action
  void searchByRating(double rating) {
    selectedRating = rating;
    searchResults.clear();
    // Convert the dataSource list into a map for faster lookup
    Map<double, RestaurantModel> itemMap =
        Map.fromIterable(dataSource, key: (item) => item.averageRating);

    // Filter the items based on the search criteria
    isSearchEnabled = true;
    searchResults.addAll(itemMap.values.where((item) => _filterByRating(item)));
  }

  bool _filterByRating(RestaurantModel item) {
    final cuisineType = item.cuisineType.toLowerCase().trim();

    if (selectedType != listOfCuisine.first) {
      return cuisineType.contains(selectedType.toLowerCase().trim()) &&
          item.averageRating >= selectedRating;
    } else {
      return item.averageRating >= selectedRating;
    }
  }

  bool _filterByType(RestaurantModel item) {
    final cuisineType = item.cuisineType.toLowerCase().trim();

    if (selectedRating != listOfRating.first) {
      return cuisineType.contains(selectedType.toLowerCase().trim()) &&
          item.averageRating >= selectedRating;
    } else {
      return cuisineType.contains(selectedType.toLowerCase().trim());
    }
  }

  @action
  void searchByPriceRange(int min, int max) {
    searchResults.clear();
    // Convert the dataSource list into a map for faster lookup
    Map<int, RestaurantModel> itemMap = Map.fromIterable(dataSource,
        key: (item) => item.maxPrice - item.minPrice);

    // Filter the items based on the search criteria
    isSearchEnabled = true;
    searchResults
        .addAll(itemMap.values.where((item) => _filterByPrice(item, min, max)));

    searchResults.addAll(itemMap.values.where((item) {
      return item.minPrice == min && item.maxPrice == max;
    }));
  }

  bool _filterByPrice(RestaurantModel item, int min, int max) {
    final cuisineType = item.cuisineType.toLowerCase().trim();

    if (selectedRating != listOfRating.first) {
      return item.averageRating >= selectedRating &&
          (item.minPrice == min && item.maxPrice == max);
    }
    if (selectedType != listOfCuisine.first) {
      return cuisineType.contains(selectedType.toLowerCase().trim()) &&
          (item.minPrice == min && item.maxPrice == max);
    }
    return item.minPrice == min && item.maxPrice == max;
  }

  @action
  void resetSearchResult() {
    searchResults.clear();
    isSearchEnabled = false;
  }
}

RestaurantStore getRestaurantStore(BuildContext context) =>
    Provider.of<RestaurantStore>(context, listen: false);
