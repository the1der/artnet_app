import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LightStyleSelector extends StatefulWidget {
  LightStyleSelector({super.key});

  @override
  State<LightStyleSelector> createState() => _LightStyleSelectorState();
}

class _LightStyleSelectorState extends State<LightStyleSelector> {
  int _selectedMode = 1;

  List<Widget> gridWidgets = [];
  List<String> titlesList = [
    "Solid",
    "Pattern",
    "Gradient",
    "Advanced",
  ];
  List<IconData> iconsList = [
    Icons.palette_outlined,
    Icons.linear_scale_outlined,
    Icons.gradient_rounded,
    Icons.draw_outlined,
  ];
  void fillWidgets(BuildContext context) {
    gridWidgets = [];
    for (int i = 0; i < 4; i++) {
      gridWidgets.add(
        GestureDetector(
          onTap: () {
            _selectedMode = i;
            setState(() {});
          },
          child: Container(
            width: 0.4.sw,
            height: 0.4.sw,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: _selectedMode == i
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    titlesList[i],
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: _selectedMode == i
                          ? Theme.of(context).colorScheme.onPrimary
                          : null,
                    ),
                  ),
                ),
                _selectedMode == i
                    ? SizedBox(
                        child: Icon(
                          iconsList[i],
                          size: 0.4.sw,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.3),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    fillWidgets(context);
    return Container(
      width: 0.8.sw,
      height: 0.8.sw,
      padding: EdgeInsets.all(0.005.sw),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.primary,
        // color: Color(0xFF001515),
        // color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
            blurRadius: 15,
            spreadRadius: 2,
            blurStyle: BlurStyle.normal,
          )
        ],
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Stack(
          children: [
            GridView.count(
              crossAxisCount: 2,
              children: gridWidgets,
            ),
            Center(
              child: Container(
                width: 0.0025.sw,
                height: 0.7.sw,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              ),
            ),
            Center(
              child: Container(
                height: 0.0025.sw,
                width: 0.7.sw,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              ),
            ),
            Center(
              child: Container(
                width: 0.2.sw,
                height: 0.2.sw,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 0),
                      blurRadius: 5,
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Icon(
                  Icons.power_settings_new_rounded,
                  size: 0.1.sw,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
