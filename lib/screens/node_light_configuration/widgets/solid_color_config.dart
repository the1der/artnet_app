import 'dart:developer';

import 'package:artnet_app/screens/node_light_configuration/widgets/color_slider.dart';
import 'package:artnet_app/screens/node_settings/widgets/glass_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SolidColorConfig extends StatefulWidget {
  SolidColorConfig({super.key});

  @override
  State<SolidColorConfig> createState() => _SolidColorConfigState();
}

class _SolidColorConfigState extends State<SolidColorConfig> {
  Color currentColor = Color(0xff443a49);

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
        ColorSlider(
          colorComponent: ColorComponent.red,
          value: currentColor.red,
          onChenged: (newValue) {
            currentColor = currentColor.withRed(newValue);
            setState(() {});
          },
        ),
        ColorSlider(
          colorComponent: ColorComponent.green,
          value: currentColor.green,
          onChenged: (newValue) {
            currentColor = currentColor.withGreen(newValue);
            setState(() {});
          },
        ),
        ColorSlider(
          colorComponent: ColorComponent.blue,
          value: currentColor.blue,
          onChenged: (newValue) {
            currentColor = currentColor.withBlue(newValue);
            setState(() {});
          },
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
            ),
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
