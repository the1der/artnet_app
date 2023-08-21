import 'package:artnet_app/models/node_info.dart';
import 'package:artnet_app/screens/node_settings/widgets/glass_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NodeIpSettings extends StatelessWidget {
  String? newShortName, newLongName;
  NodeIpSettings({
    super.key,
    required this.artNetNode,
  });
  bool startUniverseFilter(String text) {
    int startUniverse = int.tryParse(text) ?? -1;
    if (startUniverse < 0 || startUniverse > 9999) {
      return false;
    }
    return true;
  }

  void shortNameGetter(String text) {
    newShortName = text;
  }

  ArtNetNode artNetNode;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GLassTextField(
            title: "IP",
            errorText: "too short",
            oldValue: artNetNode.shortName,
            textGetter: shortNameGetter,
            maxLength: 18,
          ),
          GLassTextField(
            title: "Netmaks",
            errorText: "not value",
            oldValue: artNetNode.longName,
            textGetter: shortNameGetter,
            maxLength: 64,
          ),
          GLassTextField(
            title: "gateway",
            errorText: "Start universe should be between 0 and 9999",
            textInputType: TextInputType.number,
            textGetter: shortNameGetter,
            oldValue: 533.toString(),
            textFilter: startUniverseFilter,
          ),
        ],
      ),
    );
  }
}
