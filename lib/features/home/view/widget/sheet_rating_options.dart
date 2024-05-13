import 'package:flutter/material.dart';
import 'package:restaurants/core/helpers/utils.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:restaurants/core/theme/color_manager.dart';
import 'package:restaurants/core/theme/app_text_style.dart';
import 'package:restaurants/features/home/logic/restaurant_store.dart';
import 'package:restaurants/features/home/view/widget/star_rating.dart';

const List<double> listOfRating = [
  1.0,
  2.0,
  3.0,
  4.0,
  5.0,
];

class SheetRateOptions extends StatefulWidget {
  const SheetRateOptions({
    super.key,
  });

  @override
  State<SheetRateOptions> createState() => _SheetRateOptionsState();
}

class _SheetRateOptionsState extends State<SheetRateOptions> {
  double? rate;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Rating",
          style: AppTextStyles.font14BlueSemiBold,
        ),
        const Spacer(),
        SizedBox(
          width: 230,
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<double>(
              isExpanded: true,
              items: listOfRating
                  .map<DropdownMenuItem<double>>(
                      (double item) => _buildDropDownItem(item))
                  .toList(),
              value: rate ?? getRestaurantStore(context).selectedRating,
              onChanged: (value) {
                setState(() {
                  rate = value ?? listOfRating.first;
                });
                getRestaurantStore(context).searchByRating(rate!);
                Navigator.of(context).pop();
              },
              style: AppTextStyles.font14BlueSemiBold,
              buttonStyleData: buttonStyleData(),
              dropdownStyleData: dropdownStyleData(),
              iconStyleData: const IconStyleData(
                iconEnabledColor: ColorsManager.mainBlue,
                openMenuIcon: Icon(Icons.arrow_drop_up),
              ),
            ),
          ),
        ),
      ],
    );
  }

  DropdownMenuItem<double> _buildDropDownItem(double item) {
    return DropdownMenuItem<double>(
        value: item,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$item"),
            StarRating(
              rating: item,
            ),
            Text("& Up",
                style: AppTextStyles.font14BlueSemiBold
                    .copyWith(color: ColorsManager.gray)),
          ],
        ));
  }
}
