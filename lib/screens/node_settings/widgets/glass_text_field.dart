import 'dart:developer';

import 'package:artnet_app/screens/home/widgets/glass_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GLassTextField extends StatefulWidget {
  GLassTextField({
    super.key,
    required this.title,
    required this.oldValue,
    required this.errorText,
    required this.textGetter,
    this.maxLength,
    this.textFilter,
    this.textInputType,
    this.width,
  });
  String title, oldValue, errorText;
  Function textGetter;
  double? width;
  int? maxLength;
  Function? textFilter;
  TextInputType? textInputType;
  // int max
  @override
  State<GLassTextField> createState() => _GLassTextFieldState();
}

class _GLassTextFieldState extends State<GLassTextField> {
  // bool isFieldActive = false;
  FocusNode focusNode = FocusNode();
  bool isCorrect = true;
  List<Color> errorGradient = [
    Colors.red,
    Colors.orangeAccent,
  ];
  List<Color> disbaleGradient = [
    Colors.white.withOpacity(0.6),
    Colors.white.withOpacity(0.6),
  ];
  @override
  void initState() {
    super.initState();
    focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.removeListener(_onFocusChange);
    focusNode.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 0.02.sw),
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 35.sp,
                fontWeight: FontWeight.w100,
                color: focusNode.hasFocus
                    ? isCorrect
                        ? Theme.of(context).colorScheme.primary.withOpacity(0.9)
                        : Colors.orange[900]
                    : Colors.white.withOpacity(0.8),
              ),
            ),
          ),
          GlassBoxTwo(
            boxHeight: 0.07.sh,
            boxWidth: widget.width ?? 0.9.sw,
            boxBorder: 50.sp,
            boxColor: focusNode.hasFocus
                ? isCorrect
                    ? Theme.of(context).colorScheme.primary
                    : Colors.orange[900]
                : null,
            gradient: focusNode.hasFocus
                ? isCorrect
                    ? null
                    : errorGradient
                : disbaleGradient,
            child: Container(
              alignment: Alignment.center,
              child: TextField(
                keyboardType: widget.textInputType,
                maxLength: widget.maxLength,
                style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w100,
                  color: isCorrect
                      ? Colors.white.withOpacity(0.90)
                      : Colors.orange[900],
                ),
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 0.02.sw,
                  ),
                  border: InputBorder.none,
                  hintText: widget.oldValue,
                  hintStyle: TextStyle(
                    fontSize: 40.sp,
                  ),
                ),
                focusNode: focusNode,
                onChanged: (value) {
                  if (widget.textFilter != null) {
                    isCorrect = widget.textFilter!(value);
                  }
                  if (isCorrect) {
                    widget.textGetter(value);
                  }
                  setState(() {});
                },
              ),
            ),
          ),
          SizedBox(
            height: 0.03.sh,
            width: widget.width,
            child: Center(
              child: isCorrect
                  ? Container()
                  : Text(
                      "* ${widget.errorText} *",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.sp,
                        color: Colors.orange[700],
                        fontWeight: FontWeight.w100,
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
