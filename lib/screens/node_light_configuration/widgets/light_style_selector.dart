import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LightStyleSelector extends StatefulWidget {
  LightStyleSelector({
    super.key,
    required this.onModeChanged,
    required this.onLightWrite,
    this.isReduced = false,
  });
  Function(int) onModeChanged;
  Future<void> Function() onLightWrite;
  bool isReduced;
  @override
  State<LightStyleSelector> createState() => _LightStyleSelectorState();
}

class _LightStyleSelectorState extends State<LightStyleSelector> {
  int _selectedMode = 0;
  List<Widget> gridWidgets = [];
  bool _isWriting = false;
  late ScrollController _scrollController;
  List<String> titlesList = [
    "Solid",
    "Pattern",
    "Gradient",
    "Library",
  ];
  List<IconData> iconsList = [
    Icons.palette_outlined,
    Icons.linear_scale_outlined,
    Icons.gradient_rounded,
    Icons.folder_special_outlined,
  ];

  void fillWidgets(BuildContext context) {
    gridWidgets = [];
    for (int i = 0; i < 4; i++) {
      gridWidgets.add(
        GestureDetector(
          onTap: () {
            _selectedMode = i;
            widget.onModeChanged(_selectedMode);
            setState(() {});
          },
          child: Container(
            width: 0.36.sw,
            height: 0.36.sw,
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
                      fontSize: 17.sp,
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
                          size: 0.36.sw,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.2),
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
  void initState() {
    super.initState();

    _scrollController = ScrollController();
  }

  @override
  void didUpdateWidget(covariant LightStyleSelector oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if `isReduced` has changed
    if (oldWidget.isReduced != widget.isReduced) {
      _scrollToPosition(widget.isReduced);
    }
  }

  void _scrollToPosition(bool isReduced) {
    log(isReduced.toString());
    if (isReduced) {
      _scrollController.animateTo(
        0.8.sw + 0.1.sh,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInBack,
      );
    } else {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInBack,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    fillWidgets(context);
    return Container(
      height: 0.8.sw,
      width: 1.sw,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
              height: 0.8.sw,
              width: 1.sw,
              alignment: Alignment.center,
              child: Container(
                width: 0.72.sw,
                height: 0.72.sw,
                padding: EdgeInsets.all(0.005.sw),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.5),
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
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 0.0025.sw,
                          width: 0.7.sw,
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5),
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: !_isWriting
                              ? () async {
                                  _isWriting = true;
                                  setState(() {});
                                  await widget.onLightWrite();
                                  _isWriting = false;
                                  setState(() {});
                                }
                              : null,
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
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  Icons.upgrade_rounded,
                                  size: 0.1.sw,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                _isWriting
                                    ? SizedBox(
                                        width: 0.2.sw,
                                        height: 0.2.sw,
                                        child: CircularProgressIndicator(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.5),
                                          strokeWidth: 0.03.sw,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 0.1.sh),
            GestureDetector(
              child: Container(
                height: 0.1.sh,
                width: 0.7.sw,
                color: Colors.cyan,
                child: Text("reduce"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
