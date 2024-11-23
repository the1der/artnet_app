import 'dart:io';

import 'package:artnet_app/models/node_info.dart';
import 'package:artnet_app/screens/home/home_bloc.dart';
import 'package:artnet_app/screens/home/home_state.dart';
import 'package:artnet_app/screens/home/widgets/glass_box.dart';
import 'package:artnet_app/screens/home/widgets/node_box.dart';
import 'package:artnet_app/screens/node_settings/node_settings_screen.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  ArtNetNode artNetNode = ArtNetNode(
    nodeIp: InternetAddress("192.168.1.2"),
    longName: "Node longName",
    netMask: InternetAddress("255.255.255.0"),
    shortName: "Node short Name",
    macAddress: "9F:1A:3D:AB:C4:22",
    dhcpCapable: false,
    dhcpEnabled: true,
  );
  ArtNetNode artNetNode1 = ArtNetNode(
      nodeIp: InternetAddress("192.168.1.10"),
      longName: "Node longName",
      netMask: InternetAddress("255.255.255.0"),
      shortName: "ESP32 Node two",
      macAddress: "9F:4A:3C:AF:C4:75",
      dhcpCapable: false,
      dhcpEnabled: true);

  ArtNetNode artNetNode2 = ArtNetNode(
      nodeIp: InternetAddress("192.168.1.21"),
      longName: "Node longName",
      shortName: "Hello Node one one",
      macAddress: "9A:1C:3A:CB:DF:12",
      netMask: InternetAddress("255.255.255.0"),
      dhcpCapable: false,
      dhcpEnabled: false);
  List<ArtNetNode> nodeList = [];

  List<Widget> createNodeList(List<ArtNetNode> nodeList) {
    List<NodeBox> nodeBoxList = [];
    for (int i = 0; i < nodeList.length; i++) {
      nodeBoxList.add(NodeBox(artNetNode: nodeList[i]));
    }
    return nodeBoxList;
  }

  @override
  Widget build(BuildContext context) {
    nodeList.add(artNetNode);
    nodeList.add(artNetNode1);
    nodeList.add(artNetNode2);

    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                height: 1.sh,
                padding: EdgeInsets.symmetric(
                  horizontal: 0.01.sw,
                  vertical: 0.01.sh,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 1.sw,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 0.025.sw,
                          vertical: 0.05.sh,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: "Network: ",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  // color: Colors.white.withOpacity(0.7),
                                  fontWeight: FontWeight.w400,
                                ),
                                children: [
                                  TextSpan(
                                    text: "DJAWEB_DB71B",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      // color: Theme.of(context)
                                      //     .colorScheme
                                      //     .secondary,
                                      color: Colors.white.withOpacity(0.7),
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: "IP: ",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  // color: Colors.white.withOpacity(0.7),
                                  fontWeight: FontWeight.w400,
                                ),
                                children: [
                                  TextSpan(
                                    text: "192.186.133.56",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      // color: Theme.of(context)
                                      //     .colorScheme
                                      //     .secondary,
                                      color: Colors.white.withOpacity(0.7),
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: "Gateway: ",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  // color: Colors.white.withOpacity(0.7),
                                  fontWeight: FontWeight.w400,
                                ),
                                children: [
                                  TextSpan(
                                    text: "192.168.1.1",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      // color: Theme.of(context)
                                      //     .colorScheme
                                      //     .secondary,
                                      color: Colors.white.withOpacity(0.7),
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: "Netmask: ",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  // color: Colors.white.withOpacity(0.7),
                                  fontWeight: FontWeight.w400,
                                ),
                                children: [
                                  TextSpan(
                                    text: "255.255.255.0",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      // color: Theme.of(context)
                                      //     .colorScheme
                                      //     .secondary,
                                      color: Colors.white.withOpacity(0.7),
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: GlassBoxTwo(
                            height: 0.6.sw,
                            width: 0.6.sw,
                            shape: BoxShape.circle,
                            borderGradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 197, 255, 255),
                                Colors.cyan,
                              ],
                            ),
                            boxGradient: RadialGradient(
                              colors: [
                                Colors.white.withOpacity(0.15),
                                Colors.white.withOpacity(0.01),
                              ],
                              center: Alignment.bottomLeft,
                              radius: 1,
                            ),
                            child: Container(
                              child: Text(
                                "Start".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 45.sp,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 0.65.sw,
                            width: 0.65.sw,
                            child: const CircularProgressIndicator(
                              color: Colors.cyan,
                              value: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Make sure your devices are in same Network",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w200,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.75),
                      ),
                    ),
                    // SizedBox(
                    //   height: 0.11.sh,
                    //   width: 0.85.sw,
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           GlassBoxTwo(
                    //             height: 0.05.sh,
                    //             width: 0.4.sw,
                    //             borderRadius: BorderRadius.circular(15.r),
                    //             borderGradient: const LinearGradient(
                    //               colors: [
                    //                 Color.fromARGB(255, 197, 255, 255),
                    //                 Colors.cyan,
                    //               ],
                    //               begin: Alignment.topCenter,
                    //               end: Alignment.bottomLeft,
                    //             ),
                    //             child: Text(
                    //               "Cancel",
                    //               style: TextStyle(
                    //                 fontSize: 20.sp,
                    //               ),
                    //             ),
                    //           ),
                    //           GlassBoxTwo(
                    //             height: 0.05.sh,
                    //             width: 0.4.sw,
                    //             borderRadius: BorderRadius.circular(15.r),
                    //             borderGradient: const LinearGradient(
                    //               colors: [
                    //                 Color.fromARGB(255, 197, 255, 255),
                    //                 Colors.cyan,
                    //               ],
                    //               begin: Alignment.topCenter,
                    //               end: Alignment.bottomLeft,
                    //             ),
                    //             child: Text(
                    //               "Start",
                    //               style: TextStyle(
                    //                 fontSize: 20.sp,
                    //               ),
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //       GlassBoxTwo(
                    //         height: 0.05.sh,
                    //         width: 0.85.sw,
                    //         borderRadius: BorderRadius.circular(15.r),
                    //         borderGradient: const LinearGradient(
                    //           colors: [
                    //             Color.fromARGB(255, 197, 255, 255),
                    //             Colors.cyan,
                    //           ],
                    //           begin: Alignment.topCenter,
                    //           end: Alignment.bottomLeft,
                    //         ),
                    //         child: Text(
                    //           "Next",
                    //           style: TextStyle(
                    //             fontSize: 20.sp,
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
