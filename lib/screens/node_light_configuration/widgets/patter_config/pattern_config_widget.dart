import 'dart:math';

import 'package:artnet_app/data/models/node_light_configuration.dart';
import 'package:artnet_app/domain/repositories/pattern_config_history_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatternConfigWidget extends StatefulWidget {
  PatternConfigWidget({
    super.key,
    required this.isExpanded,
    this.onExpandedChanged,
    this.isSelected = true,
  });
  bool isExpanded;
  bool isSelected;
  Function(bool)? onExpandedChanged;

  @override
  State<PatternConfigWidget> createState() => _PatternConfigWidgetState();
}

class _PatternConfigWidgetState extends State<PatternConfigWidget> {
  List<PatternConfigParameters> history = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // history = PatternConfigHistoryRepositoryImpl()
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: widget.isExpanded ? (0.8.sh) : (0.8.sh - 0.8.sw),
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
                  if (widget.onExpandedChanged != null) {
                    widget.onExpandedChanged!(!widget.isExpanded);
                  }
                },
                child: Transform.rotate(
                  angle: widget.isExpanded ? pi / 2 : -pi / 2,
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
          SizedBox(
            height: 0.035.sh,
            child: Align(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.scaleDown,
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
            ),
          ),
          SizedBox(
            width: 1.sw,
            height: widget.isExpanded ? (0.715.sh) : (0.715.sh - 0.8.sw),
            child: SingleChildScrollView(
              child: Row(
                children: [
                  SizedBox(
                    width: 0.99.sw,
                  ),
                  Column(
                    children: [
                      Container(
                        height:
                            widget.isExpanded ? (0.71.sh) : (0.710.sh - 0.8.sw),
                        width: 0.01.sw,
                        decoration: BoxDecoration(
                          color: widget.isSelected
                              ? Colors.lightBlue
                              : Colors.transparent,
                          boxShadow: [
                            BoxShadow(
                              color: widget.isSelected
                                  ? Colors.lightBlue
                                  : Colors.transparent, // Glow color
                              blurRadius: 7,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
