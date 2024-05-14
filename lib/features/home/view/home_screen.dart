import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:restaurants/core/theme/color_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurants/core/theme/app_text_style.dart';
import 'package:restaurants/features/home/logic/restaurant_store.dart';
import 'package:restaurants/features/home/view/widget/restaurants_list.dart';
import 'package:restaurants/features/home/view/widget/customized_text_field.dart';
import 'package:restaurants/features/home/view/widget/filter_list_sheet_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final resStore = getRestaurantStore(context);
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Restaurants",
          style: AppTextStyles.font14BlueSemiBold,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
        child: Column(
          children: [
            Row(
              children: [
                CustomizedTextField(
                  controller: controller,
                  onSubmitted: (value) {
                    resStore.searchByName(value.toLowerCase().trim());
                  },
                ),
                SizedBox(width: 10.w),
                // This will show the cancel button if the search is enabled, so the user can delete the search result
                _buildCancelSearchBtn(resStore, controller),
                IconButton(
                  onPressed: () async {
                    await _displayFilterListSheet(context);
                  },
                  icon: const Icon(Icons.filter_list_rounded),
                )
              ],
            ),
            SizedBox(height: 20.h),
            const RestaurantsList()
          ],
        ),
      ),
    );
  }

  Observer _buildCancelSearchBtn(
      RestaurantStore resStore, TextEditingController controller) {
    return Observer(
      builder: (context) {
        if (!resStore.isSearchEnabled) {
          return const SizedBox.shrink();
        }
        return InkWell(
            onTap: () {
              controller.clear();
              resStore.resetSearchResult();
            },
            child: const Icon(Icons.cancel_outlined));
      },
    );
  }

  Future<void> _displayFilterListSheet(BuildContext context) async {
    const borderRadius = Radius.circular(20.0);

    await showModalBottomSheet(
      context: context,
      backgroundColor: ColorsManager.moreLightGray,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: borderRadius,
          topRight: borderRadius,
        ),
      ),
      builder: (BuildContext context) {
        return const FilterListSheetBody();
      },
    );
  }
}
