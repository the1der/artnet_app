import 'package:artnet_app/models/node_info.dart';
import 'package:artnet_app/screens/node_light_configuration/widgets/light_style_config.dart';
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
        child: SizedBox(
          width: 1.sw,
          height: 1.sh,
          child: SingleChildScrollView(
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
                ),
                SizedBox(height: 0.05.sh),
                LightStyleConfig(
                  selectedMode: _selectedMode,
                  oldMode: _oldMode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
