// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RestaurantStore on RestaurantStoreBase, Store {
  late final _$isSearchEnabledAtom =
      Atom(name: 'RestaurantStoreBase.isSearchEnabled', context: context);

  @override
  bool get isSearchEnabled {
    _$isSearchEnabledAtom.reportRead();
    return super.isSearchEnabled;
  }

  @override
  set isSearchEnabled(bool value) {
    _$isSearchEnabledAtom.reportWrite(value, super.isSearchEnabled, () {
      super.isSearchEnabled = value;
    });
  }

  late final _$searchResultsAtom =
      Atom(name: 'RestaurantStoreBase.searchResults', context: context);

  @override
  ObservableList<RestaurantModel> get searchResults {
    _$searchResultsAtom.reportRead();
    return super.searchResults;
  }

  @override
  set searchResults(ObservableList<RestaurantModel> value) {
    _$searchResultsAtom.reportWrite(value, super.searchResults, () {
      super.searchResults = value;
    });
  }

  late final _$RestaurantStoreBaseActionController =
      ActionController(name: 'RestaurantStoreBase', context: context);

  @override
  void searchByName(String name) {
    final _$actionInfo = _$RestaurantStoreBaseActionController.startAction(
        name: 'RestaurantStoreBase.searchByName');
    try {
      return super.searchByName(name);
    } finally {
      _$RestaurantStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void searchByFilters() {
    final _$actionInfo = _$RestaurantStoreBaseActionController.startAction(
        name: 'RestaurantStoreBase.searchByFilters');
    try {
      return super.searchByFilters();
    } finally {
      _$RestaurantStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetSearchResult() {
    final _$actionInfo = _$RestaurantStoreBaseActionController.startAction(
        name: 'RestaurantStoreBase.resetSearchResult');
    try {
      return super.resetSearchResult();
    } finally {
      _$RestaurantStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isSearchEnabled: ${isSearchEnabled},
searchResults: ${searchResults}
    ''';
  }
}
