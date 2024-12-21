import 'package:artnet_app/screens/node_light_configuration/widgets/solid_color_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LightStyleConfig extends StatelessWidget {
  LightStyleConfig({
    super.key,
    required this.selectedMode,
    required this.oldMode,
  });
  List<Widget> widgetsList = [];
  int selectedMode;
  int oldMode;
  List<String> titlesList = [
    "Solid",
    "Pattern",
    "Gradient",
    "Advanced",
  ];
  void fillWidgets() {
    widgetsList = [];
    for (int i = 0; i < 4; i++) {
      widgetsList.add(AnimatedPositioned(
        duration: Duration(milliseconds: 200 * (selectedMode - oldMode).abs()),
        left: (i - selectedMode).sw,
        right: (selectedMode - i).sw,
        top: 0,
        bottom: 0,
        child: Center(
          child: i == 0
              ? SolidColorConfig()
              : Text(
                  titlesList[i],
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ));
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    fillWidgets();
    return Container(
      width: 1.sw,
      height: 0.4.sh,
      child: Stack(
        children: widgetsList,
      ),
    );
  }
}
