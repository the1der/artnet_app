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
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          child: Text(
            "Pick your color",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w100,
              letterSpacing: 10.sp,
              wordSpacing: 15.sp,
            ),
          ),
        ),

        GLassTextField(
          title: "HEX",
          oldValue: currentColor.toString(),
          errorText: "test",
          textGetter: (s) {},
        ),
        // Container(
        //   width: 0.5.sw,
        //   height: 0.3.sh,
        //   color: currentColor,
        //   child: GestureDetector(
        //     onTap: () {
        //       showDialog(
        //         builder: (context) => AlertDialog(
        //           title: const Text('Pick a color!'),
        //           content: SingleChildScrollView(
        //               // child: ColorPicker(
        //               //   pickerColor: pickerColor,
        //               //   onColorChanged: (newColor) {
        //               //     pickerColor = newColor;
        //               //     setState(() {});
        //               //   },
        //               // ),
        //               // Use Material color picker:
        //               //
        //               // child: MaterialPicker(
        //               //   pickerColor: pickerColor,
        //               //   onColorChanged: changeColor,
        //               //   // showLabel: true, // only on portrait mode
        //               // ),
        //               //
        //               // Use Block color picker:
        //               //
        //               // child: BlockPicker(
        //               //   pickerColor: currentColor,
        //               //   onColorChanged: changeColor,
        //               // ),
        //               //

        //               ),
        //           actions: <Widget>[
        //             ElevatedButton(
        //               child: const Text('Got it'),
        //               onPressed: () {
        //                 setState(() => currentColor = pickerColor);
        //                 Navigator.of(context).pop();
        //               },
        //             ),
        //           ],
        //         ),
        //         context: context,
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
