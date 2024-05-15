import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:restaurants/core/helpers/utils.dart';
import 'package:restaurants/core/theme/color_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurants/core/theme/app_text_style.dart';
import 'package:restaurants/features/home/logic/restaurant_store.dart';
import 'package:restaurants/features/home/view/widget/sheet_price_range.dart';
import 'package:restaurants/features/home/view/widget/sheet_type_options.dart';
import 'package:restaurants/features/home/view/widget/sheet_rating_options.dart';

class FilterListSheetBody extends StatelessWidget {
  const FilterListSheetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.h,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Filters",
              style: AppTextStyles.font16WhiteSemiBold
                  .copyWith(color: ColorsManager.darkBlue, letterSpacing: 1.2),
            ),
            const SizedBox(
              height: 10,
            ),
            const SheetPriceRange(),
            const SizedBox(
              height: 30,
            ),
            const SheetRateOptions(),
            const SizedBox(
              height: 30,
            ),
            const SheetTypeOptions(),
            const SizedBox(
              height: 30,
            ),
            _filterSheetActionBtn(
              onTap: () {
                final resStore = getRestaurantStore(context);
                if (resStore.maxPrice == 0 &&
                    resStore.minPrice == 0 &&
                    resStore.selectedRating == 1.0 &&
                    resStore.selectedType == listOfCuisine.first) {
                  displayToastMsg(
                    context,
                    "There is no filter applied",
                    type: ToastificationType.warning,
                  );
                  Navigator.pop(context);
                } else if (resStore.maxPrice < resStore.minPrice) {
                  displayToastMsg(
                    context,
                    "Please ensure that the maximum price is greater than the minimum price",
                    type: ToastificationType.warning,
                  );
                } else {
                  resStore.searchByFilters();
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _filterSheetActionBtn({Function()? onTap}) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: 300.w,
        child: Card(
          color: ColorsManager.mainBlue,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Text(
                "Apply filter",
                textAlign: TextAlign.center,
                style: AppTextStyles.font16WhiteSemiBold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
