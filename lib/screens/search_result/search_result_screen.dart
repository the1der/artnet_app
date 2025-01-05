import 'dart:io';

import 'package:artnet_app/data/models/node_light_configuration.dart';
import 'package:artnet_app/data/models/node_info.dart';
import 'package:artnet_app/screens/home/widgets/glass_box.dart';
import 'package:artnet_app/screens/home/widgets/node_box.dart';
import 'package:artnet_app/services/artnet_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  List<Widget> nodeWidgetsList = [];
  List<ArtNetNode> nodesList =
      []; // TODO : replace by ArtnetModule.searchResult
  ArtNetNode artNetNode = ArtNetNode(
    ipAddress: InternetAddress("192.168.1.2"),
    longName: "Node longName",
    netmask: InternetAddress("255.255.255.0"),
    shortName: "Node short Name",
    macAddress: "9F:1A:3D:AB:C4:22",
    isAvailable: true,
    dhcpCapable: false,
    dhcpEnabled: true,
  );

  ArtNetNode artNetNode1 = ArtNetNode(
    ipAddress: InternetAddress("192.168.1.10"),
    longName: "Node longName",
    netmask: InternetAddress("255.255.255.0"),
    shortName: "ESP32 Node two",
    macAddress: "9F:4A:3C:AF:C4:75",
    dhcpCapable: false,
    dhcpEnabled: true,
    isAvailable: true,
    nodeLightConfiguration: NodeLightConfiguration(),
  );

  ArtNetNode artNetNode2 = ArtNetNode(
    ipAddress: InternetAddress("192.168.1.21"),
    longName: "Node longName",
    shortName: "Hello Node one one",
    macAddress: "9A:1C:3A:CB:DF:12",
    netmask: InternetAddress("255.255.255.0"),
    dhcpCapable: false,
    dhcpEnabled: false,
  );

  List<Widget> createNodesList(List<ArtNetNode> nodesList) {
    List<NodeBox> nodeBoxList = [];
    nodesList.forEach((artNetNode) {
      nodeBoxList.add(NodeBox(artNetNode: artNetNode));
    });
    return nodeBoxList;
  }

  @override
  void initState() {
    super.initState();

    nodesList.add(artNetNode);
    nodesList.add(artNetNode1);
    nodesList.add(artNetNode2);

    nodeWidgetsList = createNodesList(nodesList);
  }

  @override
  Widget build(BuildContext context) {
    nodeWidgetsList = createNodesList(nodesList);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Available nodes",
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: 1.sh,
          width: 1.sw,
          child: Column(
            children: [
              SizedBox(
                height: 0.075.sh,
                width: 0.95.sw,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GlassBoxTwo(
                      height: 0.05.sh,
                      width: 0.05.sh,
                      borderRadius: BorderRadius.circular(10.r),
                      padding: EdgeInsets.zero,
                      borderGradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.75),
                          Colors.white.withOpacity(0.3),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxGradient: LinearGradient(
                        colors: [
                          Colors.red.withOpacity(0.1),
                          Colors.white.withOpacity(0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      child: Icon(
                        Icons.filter_alt_outlined,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    SizedBox(
                      width: 0.01.sw,
                    ),
                    GlassBoxTwo(
                      height: 0.05.sh,
                      width: 0.05.sh,
                      borderRadius: BorderRadius.circular(10.r),
                      padding: EdgeInsets.zero,
                      borderGradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.75),
                          Colors.white.withOpacity(0.3),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxGradient: LinearGradient(
                        colors: [
                          Colors.red.withOpacity(0.1),
                          Colors.white.withOpacity(0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      child: Icon(
                        Icons.sort_outlined,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: nodeWidgetsList,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
