import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:restaurants/core/helpers/utils.dart';
import 'package:restaurants/core/constants/data.dart';
import 'package:restaurants/core/helpers/debouncer.dart';
import 'package:restaurants/core/theme/color_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final Debounce _debounce = Debounce(delay: const Duration(milliseconds: 500));
  late final RestaurantStore resStore;
  final List<RestaurantModel> restaurantList = [];
  bool isLoading = false;

  @override
  void initState() {
    resStore = getRestaurantStore(context);
    restaurantList.addAll(restaurants.sublist(0, 10)); // Load initial 10 items
    _listenToScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Observer(
        builder: (_) {
          final data = resStore.searchResults.isNotEmpty
              ? resStore.searchResults
              : restaurantList;
          return ListView.builder(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            itemCount: isLoading ? data.length + 1 : data.length,
            itemExtent: 120.h,
            itemBuilder: (context, index) {
              if (index == data.length) {
                return displayLoadingIndicator();
              }
              return RestaurantListItem(
                restaurant: data[index],
              );
            },
          );
        },
      ),
    );
  }

  Center displayLoadingIndicator() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          color: ColorsManager.mainBlue,
          strokeWidth: 5,
        ),
      ),
    );
  }

  void _listenToScrollController() {
    _scrollController.addListener(() {
      if (resStore.isSearchEnabled) return;
      if (!isLoading &&
          _scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200) {
        setState(() {
          isLoading = true;
        });
        //prevent multiple rapid calls to fetchMoreData() by debouncing
        _debounce.call(() {
          fetchMoreData();
        });
      }
    });
  }

  Future<void> fetchMoreData() async {
    await Future.delayed(const Duration(seconds: 1), () {
      int start = restaurantList.length;
      int end = start + 10;
      if (end > restaurants.length) {
        end = restaurants.length;
      }
      // in-case all the data are loaded
      if (restaurantList.length >= restaurants.length) {
        terminateDataLoading();
      }
      setState(() {
        restaurantList.addAll(restaurants.sublist(start, end));
        isLoading = false;
      });
    });
  }

  void terminateDataLoading() {
    // in-case all the data are loaded
    displayToastMsg(context, "Items are all loaded");
    setState(() {
      isLoading = false;
    });
    return;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
