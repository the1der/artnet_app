import 'package:artnet_app/models/app_theme.dart';
import 'package:artnet_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const int primaryColorValue = 0xFF17f3ff;

  static const Map<int, Color> colorSwatch = {
    50: Color(0xFFE0F8FF),
    100: Color(0xFFB3E5FC),
    200: Color(0xFF81D4FA),
    300: Color(0xFF4FC3F7),
    400: Color(0xFF29B6F6),
    500: Color(primaryColorValue),
    600: Color(0xFF03A9F4),
    700: Color(0xFF039BE5),
    800: Color(0xFF0288D1),
    900: Color(0xFF0277BD),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2160),
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
              brightness: Brightness.dark,
            ),
            fontFamily: "Poppins",
            scaffoldBackgroundColor: const Color(0xFF151515),
            brightness: Brightness.dark,
          ),
          home: HomeScreen(),
        );
      },
    );
  }
}
