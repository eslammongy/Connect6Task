import 'package:flutter/material.dart';
import 'package:restaurants/core/helpers/utils.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:restaurants/core/theme/color_manager.dart';
import 'package:restaurants/core/theme/app_text_style.dart';
import 'package:restaurants/features/home/logic/restaurant_store.dart';

const List<String> listOfCuisine = [
  "All",
  "Japanese",
  "Chinese",
  "Italian",
  "French",
  "Mexican",
  "American",
  "Indian",
];

class SheetTypeOptions extends StatefulWidget {
  const SheetTypeOptions({
    super.key,
  });

  @override
  State<SheetTypeOptions> createState() => _SheetTypeOptionsState();
}

class _SheetTypeOptionsState extends State<SheetTypeOptions> {
  String? type;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cuisine Type",
          style: AppTextStyles.font14BlueSemiBold,
        ),
        const Spacer(),
        SizedBox(
          width: 230,
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              items: listOfCuisine
                  .map<DropdownMenuItem<String>>(
                      (String item) => _buildDropDownItem(item))
                  .toList(),
              value: type ?? getRestaurantStore(context).selectedType,
              onChanged: (value) {
                setState(() {
                  type = value ?? listOfCuisine.first;
                });
                getRestaurantStore(context).selectedType = type!;
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

  DropdownMenuItem<String> _buildDropDownItem(String item) {
    return DropdownMenuItem<String>(
      value: item,
      child: Text(item,
          style: AppTextStyles.font14BlueSemiBold
              .copyWith(color: ColorsManager.mainBlue)),
    );
  }
}
