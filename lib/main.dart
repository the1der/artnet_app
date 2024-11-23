import 'package:artnet_app/screens/home/home_screen.dart';
import 'package:artnet_app/services/artnet_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const int primaryColorValue = 0xFF17f3ff;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // primaryColor: const MaterialColor(primaryColorValue, colorSwatch),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF00deeb),
              surface: const Color(0xFF00080A),
              brightness: Brightness.dark,
            ),
            fontFamily: "Roboto",
            // scaffoldBackgroundColor: const Color(0xFF151515),
            brightness: Brightness.dark,
          ),
          home: HomeScreen(),
        );
      },
    );
  }
}
