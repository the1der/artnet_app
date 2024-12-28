import 'dart:developer';

import 'package:artnet_app/screens/home/widgets/glass_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:interactive_slider/interactive_slider.dart';

class ColorSlider extends StatefulWidget {
  ColorSlider({
    super.key,
    required this.colorComponent,
    required this.value,
    required this.onChenged,
  });
  ColorComponent colorComponent;
  int value;
  Function(int) onChenged;
  @override
  State<ColorSlider> createState() => _ColorSliderState();
}

class _ColorSliderState extends State<ColorSlider> {
  late int _value;

  late Color _baseColor;
  late String _label;
  TextEditingController _textEditingController = TextEditingController();
  late InteractiveSliderController _interactiveSliderController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _value = widget.value;
    _textEditingController.text =
        widget.value.toRadixString(16).padLeft(2, '0');
    _interactiveSliderController = InteractiveSliderController(_value / 256);

    switch (widget.colorComponent) {
      case ColorComponent.red:
        _baseColor = Colors.red.shade900;
        _label = "R";
        break;

      case ColorComponent.green:
        _baseColor = Colors.green;
        _label = "G";
        break;

      case ColorComponent.blue:
        _baseColor = Colors.blue;
        _label = "B";
        break;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // if (_value != widget.value) {
      if (true) {
        _value = widget.value;
        _textEditingController.text =
            widget.value.toRadixString(16).padLeft(2, '0');
        _interactiveSliderController.value = _value / 256;
        setState(() {});
        log("khra");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _value = widget.value;
    _textEditingController.text =
        widget.value.toRadixString(16).padLeft(2, '0').toUpperCase();
    _interactiveSliderController.value = _value / 256;
    return SizedBox(
      width: 0.95.sw,
      height: 0.075.sh,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _label,
            style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            width: 0.6.sw,
            height: 0.1.sh,
            child: InteractiveSlider(
              min: 0,
              max: 255,
              controller: _interactiveSliderController,
              backgroundColor: _baseColor.withOpacity(0.2),
              foregroundColor: _baseColor,
              onChanged: (newValue) {
                _value = newValue.toInt();
                _textEditingController.text = _value
                    .toRadixString(16)
                    .toString()
                    .toUpperCase()
                    .padLeft(2, '0');
                try {
                  widget.onChenged(_value);
                } catch (e) {}
                setState(() {});
              },
            ),
          ),
          GlassBoxTwo(
            height: 0.05.sh,
            width: 0.2.sw,
            boxGradient: LinearGradient(
              colors: [
                _baseColor.withOpacity(0.3),
                _baseColor.withOpacity(0.01),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.bottomRight,
            ),
            borderGradient: LinearGradient(
              colors: [
                _baseColor.withOpacity(0.5),
                _baseColor.withOpacity(0.5),
              ],
            ),
            borderRadius: BorderRadius.circular(15.r),
            child: TextField(
              controller: _textEditingController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9A-Fa-f]')),
              ],
              maxLength: 2,
              buildCounter: (context,
                  {required currentLength, required isFocused, maxLength}) {
                return null; // Hides the counter
              },
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
              decoration: InputDecoration(
                prefix: Text(
                  "0x",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.75),
                  ),
                ),
                border: InputBorder.none,
              ),
              onChanged: (newValue) {
                if (newValue.isNotEmpty) {
                  _value = int.parse(newValue, radix: 16);
                }
                _interactiveSliderController.value = _value / 256;
                _textEditingController.text =
                    _textEditingController.text.toUpperCase().padLeft(2, '0');
                widget.onChenged(_value);
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}

enum ColorComponent {
  red,
  green,
  blue,
}
