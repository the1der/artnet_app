import 'dart:developer';

import 'package:artnet_app/data/models/node_info.dart';
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
            Expanded(
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
                            info: widget.artNetNode.ipAddress.address,
                          ),
                          NodeInfoBox(
                            title: "Netmask",
                            info: widget.artNetNode.netmask?.address ??
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
                              fontSize: 20.sp,
                            ),
                          ),
                          Text(
                            widget.artNetNode.dhcpCapable ? "ON" : "OFF",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20.sp,
                              color: widget.artNetNode.dhcpCapable
                                  ? Colors.green
                                  : Colors.red[700],
                            ),
                          ),
                          Text(
                            "DHCP enable: ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontWeight: FontWeight.w100,
                              fontSize: 20.sp,
                            ),
                          ),
                          Text(
                            widget.artNetNode.dhcpEnabled ? "ON" : "OFF",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20.sp,
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
      padding: EdgeInsets.only(bottom: 0.005.sh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title:',
            style: TextStyle(
              fontSize: 20.sp,
              color: Theme.of(context).colorScheme.secondary,
              // color: Colors.white.withOpacity(0.7),
              fontWeight: FontWeight.w100,
            ),
          ),
          Text(
            info,
            style: TextStyle(
              fontSize: 20.sp,
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
        top: 0.03.sh,
        bottom: 0.005.sh,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              // color: Colors.white.withOpacity(0.85),
              fontSize: 18.sp,
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
