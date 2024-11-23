import 'dart:ui';
import 'package:artnet_app/models/node_info.dart';
import 'package:artnet_app/screens/home/widgets/glass_box.dart';
import 'package:artnet_app/screens/node_settings/node_settings_screen.dart';
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
        width: 0.95.sw,
        height: 0.08.sh,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NodeSettings(
                        artNetNode: artNetNode,
                      )),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.035.sw),
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
                          fontSize: 20.sp,
                        ),
                      ),
                      Text(
                        artNetNode.macAddress.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 18.sp,
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
                          fontSize: 20.sp,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: "DHCP: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 20.sp,
                          ),
                          children: [
                            TextSpan(
                              text: artNetNode.dhcpEnabled ? "ON" : "OFF",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20.sp,
                                color: artNetNode.dhcpEnabled
                                    ? Colors.green
                                    : Colors.red[700],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
