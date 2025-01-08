import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatternConfigWidget extends StatelessWidget {
  PatternConfigWidget({
    super.key,
    required this.isExpanded,
    this.onExpandedChanged,
  });
  bool isExpanded;
  Function(bool)? onExpandedChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 0.8.sh - 0.8.sw,
      color: Colors.amber.withOpacity(0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 0.05.sh,
              width: 1.sw,
              child: GestureDetector(
                onTap: () {
                  if (onExpandedChanged != null) {
                    onExpandedChanged!(!isExpanded);
                  }
                },
                child: Transform.rotate(
                  angle: isExpanded ? pi / 2 : -pi / 2,
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.75),
                    size: 0.05.sh,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Build your Pattern",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w100,
                letterSpacing: 10.sp,
                wordSpacing: 10.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
