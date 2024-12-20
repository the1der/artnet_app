import 'package:artnet_app/models/node_info.dart';
import 'package:artnet_app/screens/node_light_configuration/widgets/light_style_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NodeLightConfigurationScreen extends StatelessWidget {
  NodeLightConfigurationScreen({
    super.key,
    required this.artNetNode,
  });
  ArtNetNode artNetNode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 0.1.sh,
              ),
              LightStyleSelector(),
            ],
          ),
        ),
      ),
    );
  }
}
