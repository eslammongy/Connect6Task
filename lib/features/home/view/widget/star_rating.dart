import 'package:flutter/material.dart';
import 'package:restaurants/core/theme/color_manager.dart';

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;

  const StarRating({
    super.key,
    this.starCount = 5,
    this.rating = .0,
  });

  Widget buildStar(BuildContext context, int index) {
    if (index >= rating) {
      return const Icon(
        Icons.star_border,
        color: ColorsManager.gray,
      );
    } else if (index > rating - 1 && index < rating) {
      return const Icon(
        Icons.star_half,
        color: ColorsManager.mainBlue,
      );
    } else {
      return const Icon(
        Icons.star,
        color: ColorsManager.mainBlue,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children:
            List.generate(starCount, (index) => buildStar(context, index)));
  }
}
