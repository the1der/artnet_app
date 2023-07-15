import 'dart:ui';
import 'package:artnet_app/models/node_info.dart';
import 'package:artnet_app/screens/home/widgets/glass_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NodeBox extends StatelessWidget {
  ArtNetNode artNetNode;
  NodeBox({super.key, required this.artNetNode});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0.01.sh),
      child: GlassBox(
        boxWidth: 0.95.sw,
        boxHeight: 0.08.sh,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  artNetNode.shortName,
                  style: TextStyle(
                    fontSize: 45.sp,
                  ),
                ),
                Text(
                  artNetNode.macAddress.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 40.sp,
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  artNetNode.netMask?.address ?? "XX.XX.XX.XX",
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 40.sp,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: "DHCP: ",
                    style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 40.sp,
                    ),
                    children: [
                      artNetNode.dhcpEnabled
                          ? TextSpan(
                              text: "ON",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 40.sp,
                                color: Colors.green,
                              ),
                            )
                          : TextSpan(
                              text: "OFF",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 40.sp,
                                color: Colors.red[700],
                              ),
                            ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
