import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurants/core/theme/color_manager.dart';
import 'package:restaurants/core/theme/app_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurants/core/theme/font_weight_helper.dart';
import 'package:restaurants/core/constants/app_assets_manager.dart';
import 'package:restaurants/features/home/model/restaurant_model.dart';
import 'package:restaurants/features/home/view/widget/star_rating.dart';

class RestaurantListItem extends StatelessWidget {
  const RestaurantListItem({super.key, required this.restaurant});
  final RestaurantModel restaurant;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: Card(
        color: ColorsManager.moreLightGray,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                restaurant.logo ?? AppAssetsManager.crapImg,
                width: 50.w,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      restaurant.name,
                      style: AppTextStyles.font14BlueSemiBold
                          .copyWith(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildCuisineType(restaurant.cuisineType),
                        StarRating(
                          rating: restaurant.averageRating,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCuisineType(String type) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: ColorsManager.moreLightGray,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Text(restaurant.cuisineType,
            style: AppTextStyles.font14DarkBlueMedium.copyWith(
                color: ColorsManager.darkBlue,
                letterSpacing: 1.3,
                fontWeight: FontWeightHelper.bold)),
      ),
    );
  }
}
