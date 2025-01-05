import 'dart:developer';

import 'package:artnet_app/screens/node_light_configuration/widgets/color_slider.dart';
import 'package:artnet_app/screens/node_light_configuration/widgets/solid_color_history.dart';
import 'package:artnet_app/screens/node_settings/widgets/glass_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:interactive_slider/interactive_slider_controller.dart';

class SolidColorConfig extends StatefulWidget {
  SolidColorConfig({super.key});

  @override
  State<SolidColorConfig> createState() => _SolidColorConfigState();
}

class _SolidColorConfigState extends State<SolidColorConfig> {
  Color currentColor = Color(0xFFF43AC9);
  bool _historyLoaded = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  InteractiveSliderController interactiveSliderController1 =
      InteractiveSliderController(0);
  InteractiveSliderController interactiveSliderController2 =
      InteractiveSliderController(0);
  InteractiveSliderController interactiveSliderController3 =
      InteractiveSliderController(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Pick your color",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w100,
            letterSpacing: 10.sp,
            wordSpacing: 15.sp,
          ),
        ),
        !_historyLoaded
            ? Container(
                height: 0.075.sh,
                width: 0.95.sw,
                alignment: Alignment.center,
                child: SizedBox(
                  height: 0.005.sh,
                  width: 0.85.sw,
                  child: const LinearProgressIndicator(),
                ),
              )
            : SolidColorHistory(
                onConfigSelected: (newConfig) {
                  currentColor = newConfig.color;
                  setState(() {});
                },
              ),
        ColorSlider(
          colorComponent: ColorComponent.red,
          value: currentColor.red,
          onChenged: (newValue) {
            currentColor = currentColor.withRed(newValue);
            setState(() {});
          },
          interactiveSliderController: interactiveSliderController1,
        ),
        ColorSlider(
          colorComponent: ColorComponent.green,
          value: currentColor.green,
          onChenged: (newValue) {
            currentColor = currentColor.withGreen(newValue);
            setState(() {});
          },
          interactiveSliderController: interactiveSliderController2,
        ),
        ColorSlider(
          colorComponent: ColorComponent.blue,
          value: currentColor.blue,
          onChenged: (newValue) {
            currentColor = currentColor.withBlue(newValue);
            setState(() {});
          },
          interactiveSliderController: interactiveSliderController3,
        ),
        GestureDetector(
          onTap: () {
            showDialog(
              builder: (context) => AlertDialog(
                title: const Text('Pick a color!'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    paletteType: PaletteType.hueWheel,
                    pickerColor: currentColor,
                    enableAlpha: false,
                    onColorChanged: (newColor) {
                      currentColor = newColor;
                      setState(() {});
                    },
                  ),
                ),
                actions: <Widget>[
                  Center(
                    child: ElevatedButton(
                      child: const Text('Done'),
                      onPressed: () {
                        currentColor = currentColor;
                        Navigator.of(context).pop();
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              context: context,
            );
          },
          child: Container(
            width: 0.75.sw,
            height: 0.075.sh,
            decoration: BoxDecoration(
                color: currentColor,
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(
                  width: 0.005.sw,
                  color: currentColor.computeLuminance() < 0.5
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(context).colorScheme.surface,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Color picker".toUpperCase(),
                  style: TextStyle(
                    fontSize: 20.sp,
                    letterSpacing: 5.sp,
                    fontWeight: FontWeight.w500,
                    color: currentColor.computeLuminance() < 0.5
                        ? Theme.of(context).colorScheme.onSurface
                        : Theme.of(context).colorScheme.surface,
                  ),
                ),
                Icon(
                  Icons.colorize_outlined,
                  color: currentColor.computeLuminance() < 0.5
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(context).colorScheme.surface,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
