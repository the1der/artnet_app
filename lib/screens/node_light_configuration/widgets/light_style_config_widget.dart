import 'package:artnet_app/data/models/node_light_configuration.dart';
import 'package:artnet_app/screens/node_light_configuration/widgets/solid_color_config_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LightStyleConfigWidget extends StatelessWidget {
  LightStyleConfigWidget({
    super.key,
    required this.selectedMode,
    required this.oldMode,
    required this.allConfigList,
    required this.allConfigHistoryList,
    required this.onConfigChange,
  });
  List<NodeLightConfiguration> allConfigList;
  List<List<NodeLightConfiguration>> allConfigHistoryList;
  List<Widget> widgetsList = [];
  int selectedMode;
  int oldMode;
  Function(List<NodeLightConfiguration>) onConfigChange;
  List<String> titlesList = [
    "Solid",
    "Pattern",
    "Gradient",
    "Library",
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
              ? SolidColorConfigWidget(
                  solidColorConfigParameters:
                      allConfigList[0] as SolidColorConfigParameters,
                  historyList: allConfigHistoryList[0]
                      as List<SolidColorConfigParameters>,
                  onChanged: (newSolidColorConfig) {
                    (allConfigList[0] as SolidColorConfigParameters).color =
                        newSolidColorConfig.color;
                    onConfigChange(allConfigList);
                  },
                )
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
    return SizedBox(
      width: 1.sw,
      height: 0.8.sh - 0.8.sw,
      child: Stack(
        children: widgetsList,
      ),
    );
  }
}
