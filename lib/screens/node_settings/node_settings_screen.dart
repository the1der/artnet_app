import 'package:artnet_app/models/node_info.dart';
import 'package:artnet_app/screens/home/widgets/gradient_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NodeSettings extends StatelessWidget {
  NodeSettings({
    super.key,
    required this.artNetNode,
  });
  ArtNetNode artNetNode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GradientBox(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 0.025.sh,
            ),
            Text(
              artNetNode.shortName,
              style: TextStyle(
                fontSize: 70.sp,
              ),
            ),
            Text(
              artNetNode.macAddress.toUpperCase(),
              style: TextStyle(
                fontSize: 45.sp,
                fontWeight: FontWeight.w100,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
