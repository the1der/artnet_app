import 'dart:io';

import 'package:artnet_app/models/node_info.dart';
import 'package:artnet_app/screens/home/widgets/glass_box.dart';
import 'package:artnet_app/screens/home/widgets/gradient_box.dart';
import 'package:artnet_app/screens/home/widgets/netmask_separator.dart';
import 'package:artnet_app/screens/home/widgets/node_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  ArtNetNode artNetNode1 = ArtNetNode(
      nodeIp: InternetAddress("192.168.1.33"),
      longName: "ESP32 node A long name",
      shortName: "ESP32 node B short",
      macAddress: "3A:3B:3C:47:AB:42",
      dhcpCapable: false,
      dhcpEnabled: false);

  ArtNetNode artNetNode2 = ArtNetNode(
      nodeIp: InternetAddress("192.168.1.45"),
      longName: "Art-Net node long name",
      shortName: "Art-Net B short",
      macAddress: "5A:3D:4C:47:AF:52",
      dhcpCapable: false,
      dhcpEnabled: true);

  ArtNetNode artNetNode3 = ArtNetNode(
      nodeIp: InternetAddress("192.168.1.124"),
      longName: "LED strip 23 ESP32 node",
      shortName: "LED strip 23",
      macAddress: "6A:41:3E:77:DB:52",
      dhcpCapable: true,
      dhcpEnabled: false);
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
              height: 0.10.sh,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ShaderMask(
                    child: Icon(
                      Icons.token_outlined,
                      size: 0.1.sw,
                      color: Colors.white,
                    ),
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[
                          Theme.of(context).colorScheme.primary,
                          const Color(0xFF9EC474),
                        ],
                      ).createShader(bounds);
                    },
                  ),
                  SizedBox(
                    width: 0.025.sw,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 0.7.sh,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    NetMaskSeparator(
                      netMask: InternetAddress("255.255.255.0"),
                    ),
                    NodeBox(artNetNode: artNetNode1),
                    NodeBox(artNetNode: artNetNode2),
                    NodeBox(artNetNode: artNetNode3),
                    NetMaskSeparator(
                      netMask: InternetAddress("255.255.255.128"),
                    ),
                    NodeBox(artNetNode: artNetNode3),
                    NetMaskSeparator(
                      netMask: InternetAddress("255.255.255.128"),
                    ),
                    NodeBox(artNetNode: artNetNode1),
                    NodeBox(artNetNode: artNetNode3),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 0.15.sh,
              child: GlassBoxTwo(
                boxWidth: 0.4.sw,
                boxHeight: 0.07.sh,
                boxColor: Theme.of(context).colorScheme.primary,
                child: ShaderMask(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "SCAN",
                        style: TextStyle(
                          // color: Theme.of(context).colorScheme.primary,
                          fontSize: 70.sp,
                        ),
                      ),
                      Icon(
                        Icons.wifi_find,
                        size: 0.065.sw,
                        // color: Theme.of(context).colorScheme.primary,
                      )
                    ],
                  ),
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[
                        Theme.of(context).colorScheme.primary,
                        const Color(0xFF9EC474),
                      ],
                    ).createShader(bounds);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
