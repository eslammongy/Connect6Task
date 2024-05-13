import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';
import 'package:restaurants/core/helpers/utils.dart';
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
          style: AppTextStyles.font14BlueSemiBold,
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
              inputAction: TextInputAction.go,
            ),
            const SizedBox(
              width: 10,
            ),
            CustomizedTextField(
              controller: maxPriceController,
              isSearch: false,
              label: "max price",
              keyboardType: TextInputType.number,
              onSubmitted: (value) {
                if (value.isEmpty || minPriceController.text.isEmpty) {
                  displayToastMsg(
                    context,
                    "please must provide min and max price",
                    type: ToastificationType.error,
                  );
                  return;
                }
                final min = double.parse(minPriceController.text).toInt();
                final max = double.parse(value).toInt();
                _onSubmitted(context, min, max);
              },
            ),
          ],
        )
      ],
    );
  }

  void _onSubmitted(BuildContext context, int min, int max) {
    debugPrint("min: $min, max: $max");
    if (max <= min) {
      displayToastMsg(
        context,
        "Please provide a max price greater than min price",
        type: ToastificationType.error,
      );
      return;
    }

    getRestaurantStore(context).searchByPriceRange(min, max);
    Navigator.of(context).pop();
  }
}
