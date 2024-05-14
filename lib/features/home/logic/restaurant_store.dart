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

  @observable
  bool isSearchEnabled = false;
  double selectedRating = listOfRating.first;
  String selectedType = listOfCuisine.first;
  int minPrice = 0;
  int maxPrice = 0;
  @observable
  ObservableList<RestaurantModel> searchResults = ObservableList.of([]);

  void setPriceRange({required int min, required int max}) {
    minPrice = min;
    maxPrice = max;
  }

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
  void searchByFilters() {
    // Convert the dataSource list into a map for faster lookup
    searchResults.clear();
    Map<String, RestaurantModel> mapModel =
        Map.fromIterable(dataSource, key: (item) => "${item.name}");

    // Filter the items based on the search criteria
    isSearchEnabled = true;
    searchResults.addAll(mapModel.values.where((item) => _filterByAll(item)));
  }

  /// Function to filter a RestaurantModel based on cuisine type, rating, and price range.
  bool _filterByAll(RestaurantModel item) {
    final cuisineType = item.cuisineType.toLowerCase().trim();
    final hasSameType = cuisineType.contains(selectedType.toLowerCase().trim());
    final hasSameRating = item.averageRating >= selectedRating;

    if (minPrice == 0 && maxPrice == 0) {
      return hasSameRating && hasSameType;
    } else {
      final isInPriceRange =
          item.minPrice >= minPrice && item.maxPrice <= maxPrice;
      return hasSameType && hasSameRating && isInPriceRange;
    }
  }

  @action
  void resetSearchResult() {
    searchResults.clear();
    selectedRating = listOfRating.first;
    selectedType = listOfCuisine.first;
    minPrice = 0;
    maxPrice = 0;
    isSearchEnabled = false;
  }
}

RestaurantStore getRestaurantStore(BuildContext context) =>
    Provider.of<RestaurantStore>(context, listen: false);
