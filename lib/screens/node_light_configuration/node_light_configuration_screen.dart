import 'dart:developer';

import 'package:artnet_app/data/models/node_info.dart';
import 'package:artnet_app/data/models/node_light_configuration.dart';
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
  List<SolidColorConfigParameters> solidConfigHistory = [];
  SolidColorConfigParameters solidColorConfigParameters =
      SolidColorConfigParameters(
    color: Colors.cyan,
  );
  GradientConfigParameters gradientConfigParameters =
      GradientConfigParameters();
  PatternConfigParameters patternConfigParameters = PatternConfigParameters();
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
        log(solidConfigHistory.length.toString());
      } else
        solidColorConfigParameters = SolidColorConfigParameters(
          color: Colors.cyan,
        );
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
        } else
          solidColorConfigParameters = SolidColorConfigParameters(
            color: Colors.cyan,
          );
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
          alignment: Alignment.center,
          child: _isLoadingHistory
              ? SizedBox(
                  width: 0.35.sw,
                  height: 0.35.sw,
                  child: const CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 0.05.sh,
                      ),
                      LightStyleSelector(
                        onModeChanged: (newMode) {
                          _oldMode = _selectedMode;
                          _selectedMode = newMode;
                          setState(() {});
                        },
                        onLightWrite: onLightWrite,
                      ),
                      SizedBox(height: 0.05.sh),
                      LightStyleConfigWidget(
                        selectedMode: _selectedMode,
                        oldMode: _oldMode,
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
