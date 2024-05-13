import 'package:flutter/widgets.dart';
import 'package:restaurants/core/theme/color_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurants/core/theme/app_text_style.dart';
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
            const SheetTypeOptions()
          ],
        ),
      ),
    );
  }
}
