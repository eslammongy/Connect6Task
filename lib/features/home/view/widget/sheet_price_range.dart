import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:restaurants/core/theme/app_text_style.dart';
import 'package:restaurants/features/home/logic/restaurant_store.dart';
import 'package:restaurants/features/home/view/widget/customized_text_field.dart';

class SheetPriceRange extends StatelessWidget {
  const SheetPriceRange({super.key});

  @override
  Widget build(BuildContext context) {
    final minPriceController = TextEditingController();
    final maxPriceController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "Price",
          style: AppTextStyles.font14BlueSemiBold.copyWith(fontSize: 14),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            CustomizedTextField(
              controller: minPriceController,
              isSearch: false,
              label: "min price",
              keyboardType: TextInputType.number,
              initialValue:
                  setInitialValue(getRestaurantStore(context).minPrice),
              onChanged: (min) {
                double minPrice = double.tryParse(min) ?? 0;
                getRestaurantStore(context).minPrice = minPrice.toInt();
              },
            ),
            const SizedBox(
              width: 10,
            ),
            CustomizedTextField(
              controller: maxPriceController,
              isSearch: false,
              label: "max price",
              initialValue:
                  setInitialValue(getRestaurantStore(context).maxPrice),
              keyboardType: TextInputType.number,
              onChanged: (max) {
                final maxPrice = double.tryParse(max) ?? 0;
                getRestaurantStore(context).maxPrice = maxPrice.toInt();
              },
            ),
          ],
        )
      ],
    );
  }

  setInitialValue(int num) {
    if (num > 0) {
      return "$num";
    }
    return null;
  }
}
