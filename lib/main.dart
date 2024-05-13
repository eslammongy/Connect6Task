import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants/core/theme/color_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurants/features/home/view/home_screen.dart';
import 'package:restaurants/features/home/logic/restaurant_store.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    Provider(
      create: (context) {
        return RestaurantStore(context);
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        child: MaterialApp(
          title: 'Restaurants',
          theme: ThemeData(
            primaryColor: ColorsManager.mainBlue,
            scaffoldBackgroundColor: Colors.white,
          ),
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
        ));
  }
}
