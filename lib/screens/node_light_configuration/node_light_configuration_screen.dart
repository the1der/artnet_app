import 'dart:developer';

import 'package:artnet_app/data/models/node_info.dart';
import 'package:artnet_app/data/models/node_light_configuration.dart';
import 'package:artnet_app/domain/repositories/pattern_config_history_repository_impl.dart';
import 'package:artnet_app/domain/repositories/solid_config_history_repository_impl.dart';
import 'package:artnet_app/screens/node_light_configuration/widgets/light_style_config_widget.dart';
import 'package:artnet_app/screens/node_light_configuration/widgets/light_style_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NodeLightConfigurationScreen extends StatefulWidget {
  NodeLightConfigurationScreen({
    super.key,
    required this.artNetNode,
  });
  ArtNetNode artNetNode;
  @override
  State<NodeLightConfigurationScreen> createState() =>
      _NodeLightConfigurationScreenState();
}

class _NodeLightConfigurationScreenState
    extends State<NodeLightConfigurationScreen> {
  int _selectedMode = 0;
  int _oldMode = 0;
  bool _isLoadingHistory = true;
  bool isConfigExpanded = false;
  ScrollController _scrollController = ScrollController();
  List<SolidColorConfigParameters> solidConfigHistory = [];
  List<PatternConfigParameters> patternConfigHistory = [];
  SolidColorConfigParameters solidColorConfigParameters =
      SolidColorConfigParameters(
    color: Colors.cyan,
  );
  GradientConfigParameters gradientConfigParameters =
      GradientConfigParameters();
  PatternConfigParameters patternConfigParameters = PatternConfigParameters(
    pattern: [],
  );
  Future<void> onLightWrite() async {
    log('ddb action');
    switch (_selectedMode) {
      case 0:
        SolidColorHistortyRepositoryImpl()
            .addConfig(solidColorConfigParameters);
        log(solidColorConfigParameters.color.toString());
        break;

      case 1:
        break;

      case 2:
        break;
      default:
        break;
    }
    await Future.delayed(const Duration(seconds: 2));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      log('get history');
      solidConfigHistory =
          await SolidColorHistortyRepositoryImpl().fetchHistory();
      if (solidConfigHistory.isNotEmpty) {
        solidColorConfigParameters.color = solidConfigHistory.last.color;
      } else {
        solidColorConfigParameters = SolidColorConfigParameters(
          color: Colors.cyan,
        );
      }
      _isLoadingHistory = false;
      setState(() {});
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_isLoadingHistory) {
        solidConfigHistory =
            await SolidColorHistortyRepositoryImpl().fetchHistory();
        if (solidConfigHistory.isNotEmpty) {
          solidColorConfigParameters.color = solidConfigHistory.last.color;
        } else {
          solidColorConfigParameters = SolidColorConfigParameters(
            color: Colors.cyan,
          );
        }

        patternConfigHistory =
            await PatternConfigHistoryRepositoryImpl().fetchHistory();
        if (patternConfigHistory.isNotEmpty) {
          patternConfigParameters.pattern = [];
          patternConfigParameters.id = patternConfigHistory.last.id;
          for (var slice in patternConfigHistory.last.pattern) {
            patternConfigParameters.pattern.add(slice);
          }
        } else {
          patternConfigParameters = PatternConfigParameters(
            pattern: [
              PatternSlice(color: Colors.cyan, length: 100),
              PatternSlice(color: Colors.pink, length: 100),
              PatternSlice(color: Colors.green, length: 100),
            ],
          );
        }
        _isLoadingHistory = false;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Light Configuration",
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: 1.sw,
          height: 1.sh,
          alignment: Alignment.topCenter,
          child: _isLoadingHistory
              ? SizedBox(
                  width: 0.35.sw,
                  height: 0.35.sw,
                  child: const CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 0.05.sh,
                      ),
                      LightStyleSelector(
                        isReduced: isConfigExpanded,
                        onModeChanged: (newMode) {
                          _oldMode = _selectedMode;
                          _selectedMode = newMode;
                          setState(() {});
                        },
                        onLightWrite: onLightWrite,
                      ),
                      SizedBox(
                        height: isConfigExpanded ? 0 : 0.025.sh,
                      ),
                      LightStyleConfigWidget(
                        selectedMode: _selectedMode,
                        oldMode: _oldMode,
                        isExpanded: isConfigExpanded,
                        onExpandedChanged: (isExpanded) {
                          isConfigExpanded = isExpanded;
                          _scrollController.animateTo(
                            isConfigExpanded ? 0.8.sw : 0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeOut,
                          );
                          setState(() {});
                        },
                        allConfigHistoryList: [
                          solidConfigHistory,
                        ],
                        allConfigList: [
                          solidColorConfigParameters,
                          patternConfigParameters,
                          gradientConfigParameters,
                        ],
                        onConfigChange: (newConfigList) {
                          solidColorConfigParameters =
                              newConfigList[0] as SolidColorConfigParameters;
                          patternConfigParameters =
                              newConfigList[1] as PatternConfigParameters;
                          gradientConfigParameters =
                              newConfigList[2] as GradientConfigParameters;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
