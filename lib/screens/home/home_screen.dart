import 'dart:io';

import 'package:artnet_app/models/node_info.dart';
import 'package:artnet_app/screens/home/home_bloc.dart';
import 'package:artnet_app/screens/home/home_event.dart';
import 'package:artnet_app/screens/home/home_state.dart';
import 'package:artnet_app/screens/home/widgets/glass_box.dart';
import 'package:artnet_app/screens/home/widgets/gradient_box.dart';
import 'package:artnet_app/screens/home/widgets/netmask_separator.dart';
import 'package:artnet_app/screens/home/widgets/node_box.dart';
import 'package:artnet_app/services/artnet_module.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
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
                    // height: state is HomeInitial ? 0.1 : 0.7.sh,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          NodeBox(artNetNode: artNetNode),
                          NodeBox(artNetNode: artNetNode1),
                          NodeBox(artNetNode: artNetNode2),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 0.15.sh,
                    child: InkWell(
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
                      onTap: () {
                        context.read<HomeBloc>().add(ArtNetStartScan());
                      },
                    ),
                  )
                ],
              ),
            ),
          ));
        },
      ),
    );
  }
}
