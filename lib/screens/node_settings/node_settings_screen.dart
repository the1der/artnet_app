import 'dart:developer';

import 'package:artnet_app/models/node_info.dart';
import 'package:artnet_app/screens/home/widgets/glass_box.dart';
import 'package:artnet_app/screens/home/widgets/gradient_box.dart';
import 'package:artnet_app/screens/node_settings/node_artnet_settings/node_artnet_settings_screen.dart';
import 'package:artnet_app/screens/node_settings/node_ip_settings/node_ip_settings_screen.dart';
import 'package:artnet_app/screens/node_settings/widgets/glass_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:tab_container/tab_container.dart';

class NodeSettings extends StatefulWidget {
  NodeSettings({
    super.key,
    required this.artNetNode,
  });
  ArtNetNode artNetNode;

  @override
  State<NodeSettings> createState() => _NodeSettingsState();
}

class _NodeSettingsState extends State<NodeSettings> {
  String? newShortName, newLongName;

  ScrollController? scrollController;

  double scrollPosition = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Node details",
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // SizedBox(
            //   height: scrollPosition < 60
            //       ? (0.02 - (0.02 / 60) * scrollPosition).sh
            //       : 0.sh,
            // ),
            //  scrollPosition < 60
            //       ? (0.02 - (0.02 / 60) * scrollPosition).sh
            //       : 0.sh,
            // Container(
            //   height: scrollPosition < 60
            //       ? (0.15 - (0.08 / 60) * scrollPosition).sh
            //       : 0.07.sh,
            //   width: 1.sw,
            //   decoration: BoxDecoration(
            //     border: Border(
            //         bottom: BorderSide(
            //       width: 0.002.sh,
            //       color: Theme.of(context).colorScheme.secondary.withOpacity(
            //             scrollPosition < 60
            //                 ? ((0.3 / 60) * scrollPosition)
            //                 : 0.3,
            //           ),
            //       // color: Colors.white.withOpacity(0.2),
            //     )),
            //     gradient: LinearGradient(
            //       colors: [
            //         Theme.of(context).colorScheme.secondary.withOpacity(
            //               scrollPosition < 60
            //                   ? ((0.32 / 60) * scrollPosition)
            //                   : 0.32,
            //             ),
            //         Theme.of(context).colorScheme.secondary.withOpacity(
            //               scrollPosition < 60
            //                   ? ((0.12 / 60) * scrollPosition)
            //                   : 0.12,
            //             ),
            //       ],
            //     ),
            //   ),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Padding(
            //         padding: EdgeInsets.only(left: 0.1.sw),
            //         child: Text(
            //           "Node details",
            //           style: TextStyle(
            //             // fontWeight: FontWeight.w00,
            //             fontSize: scrollPosition < 60
            //                 ? (75 - (15 / 60) * scrollPosition).sp
            //                 : 60.sp,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              // height: 0.89.sh,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DetailsSeparator(title: "Art-Net configuration"),
                          NodeInfoBox(
                            title: "Short name",
                            info: widget.artNetNode.shortName,
                          ),
                          NodeInfoBox(
                            title: "Long name",
                            info: widget.artNetNode.longName,
                          ),
                          DetailsSeparator(title: "IP configuration"),
                          NodeInfoBox(
                            title: "Mac address",
                            info: widget.artNetNode.macAddress.toUpperCase(),
                          ),
                          NodeInfoBox(
                            title: "IP address",
                            info: widget.artNetNode.nodeIp.address,
                          ),
                          NodeInfoBox(
                            title: "Netmask",
                            info: widget.artNetNode.netMask?.address ??
                                "XXX.XXX.XXX.XXX",
                          ),
                          NodeInfoBox(
                            title: "Gateway",
                            info: widget.artNetNode.gateWay?.address ??
                                "XXX.XXX.XXX.XXX",
                          ),
                          Text(
                            "DHCP enabled: ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontWeight: FontWeight.w100,
                              fontSize: 40.sp,
                            ),
                          ),
                          Text(
                            widget.artNetNode.dhcpCapable ? "ON" : "OFF",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 50.sp,
                              color: widget.artNetNode.dhcpCapable
                                  ? Colors.green
                                  : Colors.red[700],
                            ),
                          ),
                          SizedBox(
                            height: 0.025.sh,
                          ),
                          Text(
                            "DHCP enable: ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontWeight: FontWeight.w100,
                              fontSize: 40.sp,
                            ),
                          ),
                          Text(
                            widget.artNetNode.dhcpEnabled ? "ON" : "OFF",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 50.sp,
                              color: widget.artNetNode.dhcpEnabled
                                  ? Colors.green
                                  : Colors.red[700],
                            ),
                          ),
                          SizedBox(
                            height: 0.02.sh,
                          ),
                          DetailsSeparator(title: "Addtional configuration"),
                          NodeInfoBox(
                            title: "Number of LEDs",
                            info: 129.toString(),
                          ),
                          NodeInfoBox(
                            title: "Colors",
                            info: "RGBW",
                          ),
                          NodeInfoBox(
                            title: "Controller",
                            info: "RGBW",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NodeInfoBox extends StatelessWidget {
  NodeInfoBox({
    super.key,
    required this.title,
    required this.info,
  });
  String title, info;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0.025.sh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title:',
            style: TextStyle(
              fontSize: 40.sp,
              color: Theme.of(context).colorScheme.secondary,
              // color: Colors.white.withOpacity(0.7),
              fontWeight: FontWeight.w100,
            ),
          ),
          Text(
            info,
            style: TextStyle(
              fontSize: 50.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsSeparator extends StatelessWidget {
  DetailsSeparator({super.key, required this.title});
  String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 0.01.sh,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              // color: Colors.white.withOpacity(0.85),
              fontSize: 35.sp,
              // fontWeight: FontWeight.w100,
            ),
          ),
          SizedBox(
            width: 0.02.sw,
          ),
          Expanded(
            child: Container(
              height: 1,
              color: Colors.white.withOpacity(0),
              // color: Colors.white.withOpacity(0.85),
            ),
          ),
          SizedBox(
            width: 0.02.sw,
          ),
          // Text(
          //   "edit",
          //   style: TextStyle(
          //     color: Theme.of(context).colorScheme.primary,
          //     fontSize: 40.sp,
          //     fontWeight: FontWeight.w100,
          //   ),
          // ),
        ],
      ),
    );
  }
}
