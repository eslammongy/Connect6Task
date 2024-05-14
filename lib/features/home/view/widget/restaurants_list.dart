import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:restaurants/core/helpers/utils.dart';
import 'package:restaurants/core/constants/data.dart';
import 'package:restaurants/core/helpers/debouncer.dart';
import 'package:restaurants/core/theme/color_manager.dart';
import 'package:restaurants/features/home/logic/restaurant_store.dart';
import 'package:restaurants/features/home/model/restaurant_model.dart';
import 'package:restaurants/features/home/view/widget/restaurant_list_item.dart';

class RestaurantsList extends StatefulWidget {
  const RestaurantsList({super.key});

  @override
  State<RestaurantsList> createState() => _RestaurantsListState();
}

class _RestaurantsListState extends State<RestaurantsList> {
  final ScrollController _scrollController = ScrollController();
  final Debounce _debounce = Debounce(delay: const Duration(milliseconds: 300));
  late final RestaurantStore resStore;

  List<RestaurantModel> restaurants = [];
  bool _isLoading = false; // Use priv

  @override
  void initState() {
    super.initState();
    resStore = getRestaurantStore(context);
    _fetchData();
    _listenToScrollController();
  }

  void _fetchData({int limit = 10}) async {
    // Simulate data fetching with delay
    await Future.delayed(const Duration(milliseconds: 300));

    final startIndex = restaurants.length;
    final endIndex = min(startIndex + limit, dataSource.length);

    if (restaurants.length >= dataSource.length) {
      Future(() => displayToastMsg(context, "Items are all loaded"));
    } else {
      restaurants.addAll(dataSource.sublist(startIndex, endIndex));
    }
    setState(() => _isLoading = false);
  }

  void _listenToScrollController() {
    _scrollController.addListener(() {
      if (resStore.isSearchEnabled) return;

      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        setState(() => _isLoading = true);
        _debounce.call(() => _fetchData());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Observer(builder: (_) {
        final data =
            resStore.isSearchEnabled ? resStore.searchResults : restaurants;

        return ListView.builder(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          itemCount: data.length + (_isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == data.length) {
              return displayLoadingIndicator();
            }
            return RestaurantListItem(restaurant: data[index]);
          },
        );
      }),
    );
  }

  Center displayLoadingIndicator() => const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(
            color: ColorsManager.mainBlue,
            strokeWidth: 5,
          ),
        ),
      );

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
