import 'package:artnet_app/data/models/node_light_configuration.dart';
import 'package:artnet_app/domain/repositories/solid_config_history_repository_impl.dart';
import 'package:artnet_app/screens/node_light_configuration/widgets/color_slider.dart';
import 'package:artnet_app/screens/node_light_configuration/widgets/solid_color_config/solid_color_history.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:interactive_slider/interactive_slider_controller.dart';

class SolidColorConfigWidget extends StatefulWidget {
  SolidColorConfigWidget({
    super.key,
    required this.solidColorConfigParameters,
    required this.onChanged,
    required this.historyList,
    required this.isSelected,
  });
  SolidColorConfigParameters solidColorConfigParameters;
  Function(SolidColorConfigParameters) onChanged;
  List<SolidColorConfigParameters> historyList;
  bool isSelected;
  @override
  State<SolidColorConfigWidget> createState() => _SolidColorConfigState();
}

class _SolidColorConfigState extends State<SolidColorConfigWidget> {
  ScrollController _scrollController = ScrollController();
  SolidColorHistortyRepositoryImpl solidColorHistortyRepository =
      SolidColorHistortyRepositoryImpl();
  InteractiveSliderController interactiveSliderControllerRed =
      InteractiveSliderController(0);
  InteractiveSliderController interactiveSliderControllerGreen =
      InteractiveSliderController(0);
  InteractiveSliderController interactiveSliderControllerBlue =
      InteractiveSliderController(0);
  bool _showPicker = false;
  @override
  void initState() {
    super.initState();
    interactiveSliderControllerRed = InteractiveSliderController(
        widget.solidColorConfigParameters.color.red.toDouble() / 256);
    interactiveSliderControllerGreen = InteractiveSliderController(
        widget.solidColorConfigParameters.color.green.toDouble() / 256);
    interactiveSliderControllerBlue = InteractiveSliderController(
        widget.solidColorConfigParameters.color.blue.toDouble() / 256);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 0.8.sh - 0.8.sw,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
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
          SolidColorHistory(
            historyList: widget.historyList,
            onConfigSelected: (newConfig) {
              widget.onChanged(
                  SolidColorConfigParameters(color: newConfig.color));
              setState(() {});
            },
          ),
          Expanded(
            child: SizedBox(
              width: 2.sw,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    controller: _scrollController,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 0.85.sw,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ColorSlider(
                                colorComponent: ColorComponent.red,
                                value:
                                    widget.solidColorConfigParameters.color.red,
                                onChenged: (newValue) {
                                  try {
                                    widget.onChanged(
                                      SolidColorConfigParameters(
                                        color: widget
                                            .solidColorConfigParameters.color
                                            .withRed(newValue),
                                      ),
                                    );
                                  } catch (e) {}

                                  setState(() {});
                                },
                              ),
                              ColorSlider(
                                colorComponent: ColorComponent.green,
                                value: widget
                                    .solidColorConfigParameters.color.green,
                                // interactiveSliderController:
                                //     interactiveSliderControllerGreen,
                                onChenged: (newValue) {
                                  try {
                                    widget.onChanged(
                                      SolidColorConfigParameters(
                                        color: widget
                                            .solidColorConfigParameters.color
                                            .withGreen(newValue),
                                      ),
                                    );
                                  } catch (e) {}

                                  setState(() {});
                                },
                              ),
                              ColorSlider(
                                colorComponent: ColorComponent.blue,
                                value: widget
                                    .solidColorConfigParameters.color.blue,
                                // interactiveSliderController:
                                //     interactiveSliderControllerBlue,
                                onChenged: (newValue) {
                                  try {
                                    widget.onChanged(
                                      SolidColorConfigParameters(
                                        color: widget
                                            .solidColorConfigParameters.color
                                            .withBlue(newValue),
                                      ),
                                    );
                                  } catch (e) {}
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: 0.15.sw,
                            child: GestureDetector(
                              onTap: () {
                                _showPicker = true;
                                setState(() {
                                  _scrollController.animateTo(
                                    1.sw,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeIn,
                                  );
                                });
                              },
                              child: Icon(
                                Icons.chevron_right_rounded,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.75),
                                size: 0.15.sw,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 0.15.sw,
                          child: Expanded(
                            child: GestureDetector(
                              onTap: () {
                                _showPicker = true;
                                setState(() {
                                  _scrollController.animateTo(
                                    0.sw,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeIn,
                                  );
                                });
                              },
                              child: Icon(
                                Icons.chevron_left_rounded,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.75),
                                size: 0.15.sw,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.7.sw,
                          child: SizedBox(
                            width: 0.6.sw,
                            child: ColorWheelPicker(
                              onWheel: (color) {},
                              shouldUpdate: true,
                              color: widget.solidColorConfigParameters.color,
                              onChanged: (newColor) {
                                widget.solidColorConfigParameters.color =
                                    newColor;
                                widget.onChanged(SolidColorConfigParameters(
                                    color: newColor));
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 0.15.sw,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 0.01.sh,
            width: 1.sw,
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? widget.solidColorConfigParameters.color
                  : Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: widget.isSelected
                      ? widget.solidColorConfigParameters.color
                      : Colors.transparent, // Glow color
                  blurRadius: 7,
                  spreadRadius: 5,
                ),
              ],
            ),
          ),
          // ),
        ],
      ),
    );
  }
}
