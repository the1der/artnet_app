import 'dart:io';
import 'dart:developer';

import 'package:artnet_app/models/node_info.dart';
import 'package:artnet_app/screens/home/home_bloc.dart';
import 'package:artnet_app/screens/home/home_event.dart';
import 'package:artnet_app/screens/home/home_state.dart';
import 'package:artnet_app/screens/home/widgets/glass_box.dart';
import 'package:artnet_app/screens/home/widgets/node_box.dart';
import 'package:artnet_app/services/artnet_module.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
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
  bool isWiFiConnected = false;
  late AnimationController _controller;
  WifiInfo wifiInfo = WifiInfo();
  String wifiSSID = "";
  String wifiIP = "";
  bool _isWifiConnected = false;
  List<Widget> createNodeList(List<ArtNetNode> nodeList) {
    List<NodeBox> nodeBoxList = [];
    for (int i = 0; i < nodeList.length; i++) {
      nodeBoxList.add(NodeBox(artNetNode: nodeList[i]));
    }
    return nodeBoxList;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      log(result.length.toString());
      if (result.contains(ConnectivityResult.wifi)) {
        log("here");
        wifiIP = await wifiInfo.getWifiIP() ?? "";
        wifiSSID = await wifiInfo.getWifiName() ?? "";
        _isWifiConnected = true;
      } else {
        _isWifiConnected = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    nodeList = [];
    nodeList.add(artNetNode);
    nodeList.add(artNetNode1);
    nodeList.add(artNetNode2);

    wifiInfo = WifiInfo();

    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is ArtNetScanning) {
            _controller.forward();
          }
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
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                    text: wifiSSID,
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
                                    text: wifiIP,
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
                          ],
                        ),
                      ),
                    ),
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(
                        begin: 0.65.sw,
                        end: state is ArtNetScanning ? 0.85.sw : 0.65.sw,
                      ),
                      duration: const Duration(milliseconds: 300),
                      builder: (context, size, child) {
                        return SizedBox(
                          height: size,
                          width: size,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: size,
                                  width: size,
                                  child: AnimatedBuilder(
                                    animation: _controller,
                                    builder: (context, child) {
                                      return CircularProgressIndicator(
                                        value: _controller.value,
                                        color: state is ArtNetScanning
                                            ? Colors.cyan
                                            : state is ArtNetNoFoundNodes
                                                ? const Color(0x3FF50057)
                                                : state is ArtNetFoundNodes
                                                    ? const Color(0x3F69F0AE)
                                                    : Colors.transparent,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: InkWell(
                                  customBorder: const CircleBorder(),
                                  onTap: state is HomeInitial
                                      ? () {
                                          context
                                              .read<HomeBloc>()
                                              .add(ArtNetStartScan());
                                        }
                                      : null,
                                  child: GlassBoxTwo(
                                    height: size - 0.05.sw,
                                    width: size - 0.05.sw,
                                    shape: BoxShape.circle,
                                    borderGradient: const LinearGradient(
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
                                    child: state is ArtNetScanning
                                        ? TweenAnimationBuilder<double>(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            tween: Tween<double>(
                                                begin: 0.0,
                                                end: state.scanState ==
                                                        ScanState.firstScan
                                                    ? 0
                                                    : 7),
                                            builder:
                                                (context, fontSize, child) {
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Scanning for Devices",
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface
                                                          .withOpacity(state
                                                                      .scanState ==
                                                                  ScanState
                                                                      .firstScan
                                                              ? 1
                                                              : 0.6),
                                                      fontSize:
                                                          (25 - fontSize).sp,
                                                      fontWeight:
                                                          state.scanState ==
                                                                  ScanState
                                                                      .firstScan
                                                              ? FontWeight.w500
                                                              : FontWeight.w300,
                                                    ),
                                                  ),
                                                  SizedBox(height: 0.05.sh),
                                                  Text(
                                                    "Getting IP information",
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface
                                                          .withOpacity(state
                                                                      .scanState ==
                                                                  ScanState
                                                                      .getIpInfo
                                                              ? 1
                                                              : 0.6),
                                                      fontSize:
                                                          (18 + fontSize).sp,
                                                      fontWeight:
                                                          state.scanState ==
                                                                  ScanState
                                                                      .getIpInfo
                                                              ? FontWeight.w500
                                                              : FontWeight.w300,
                                                    ),
                                                  )
                                                ],
                                              );
                                            },
                                          )
                                        : (state is ArtNetFoundNodes ||
                                                state is ArtNetNoFoundNodes)
                                            ? RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(
                                                  text: "Done".toUpperCase(),
                                                  style: TextStyle(
                                                    fontSize: 45.sp,
                                                    fontWeight: FontWeight.w100,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          "\n${ArtNetModule.scanResults.length} device found",
                                                      style: TextStyle(
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Text(
                                                "Start".toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: 45.sp,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                              ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(
                        height: 0.15.sh,
                        child: Stack(
                          children: [
                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 300),
                              // top: state is ArtNetScanning ? 0 : -0.3.sh,
                              // left: 0,
                              right: 0,
                              bottom: 0,
                              left: state is ArtNetScanning ? 0 : 2.sw,
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                      text: state is ArtNetScanning
                                          ? state.foundDevices.toString()
                                          : "",
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: " devices found",
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w200,
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            ),
                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 300),
                              // bottom: (state is ArtNetFoundNodes ||
                              //         state is ArtNetNoFoundNodes)
                              //     ? 0
                              //     : -0.3.sh,
                              // left: 0,
                              bottom: 0,
                              left: (state is ArtNetFoundNodes ||
                                      state is ArtNetNoFoundNodes)
                                  ? 0
                                  : -2.sw,
                              right: 0,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      borderRadius: BorderRadius.circular(20.r),
                                      child: GlassBoxTwo(
                                        width: 0.3.sw,
                                        height: 0.06.sh,
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        borderGradient: LinearGradient(
                                          colors: state is ArtNetNoFoundNodes
                                              ? [
                                                  Colors.red.withOpacity(0.75),
                                                  Colors.red.withOpacity(0.2),
                                                ]
                                              : [
                                                  const Color(0xFF69F0AE)
                                                      .withOpacity(0.75),
                                                  const Color(0xFF69F0AE)
                                                      .withOpacity(0.2),
                                                ],
                                        ),
                                        boxGradient: RadialGradient(
                                          colors: [
                                            Colors.cyan.withOpacity(0.75),
                                            Theme.of(context)
                                                .colorScheme
                                                .surface
                                                .withOpacity(0.75)
                                          ],
                                          center: Alignment.bottomLeft,
                                          radius: 1,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "Restart",
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                              ),
                                            ),
                                            const Icon(
                                              Icons.restart_alt,
                                            )
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        _controller.reset();

                                        context
                                            .read<HomeBloc>()
                                            .add(ArtNetStartScan());
                                      },
                                    ),
                                    SizedBox(
                                      width: 0.05.sw,
                                    ),
                                    InkWell(
                                      borderRadius: BorderRadius.circular(20.r),
                                      onTap: state is ArtNetFoundNodes
                                          ? () {}
                                          : null,
                                      child: GlassBoxTwo(
                                        width: 0.3.sw,
                                        height: 0.06.sh,
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        borderGradient: LinearGradient(
                                          colors: state is ArtNetNoFoundNodes
                                              ? [
                                                  Colors.white
                                                      .withOpacity(0.75),
                                                  Colors.white.withOpacity(0.2),
                                                ]
                                              : [
                                                  const Color(0xFF69F0AE)
                                                      .withOpacity(0.75),
                                                  const Color(0xFF69F0AE)
                                                      .withOpacity(0.2),
                                                ],
                                        ),
                                        boxGradient: RadialGradient(
                                          colors: state is ArtNetNoFoundNodes
                                              ? [
                                                  Colors.white.withOpacity(0.5),
                                                  Colors.white
                                                      .withOpacity(0.05),
                                                ]
                                              : [
                                                  Colors.cyan.withOpacity(0.75),
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .surface
                                                      .withOpacity(0.75)
                                                ],
                                          center: Alignment.bottomLeft,
                                          radius: 1,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "Next",
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                              ),
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
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
