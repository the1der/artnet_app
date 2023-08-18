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
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  List<Widget> createNodeList(List<ArtNetNode> nodeList) {
    List<NodeBox> nodeBoxList = [];
    for (int i = 0; i < nodeList.length; i++) {
      nodeBoxList.add(NodeBox(artNetNode: nodeList[i]));
    }
    return nodeBoxList;
  }

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
                    child: ShaderMask(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.01.sw),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.sort,
                              size: 0.07.sw,
                            ),
                            SizedBox(
                              width: 0.03.sw,
                            ),
                            Icon(
                              Icons.token_outlined,
                              size: 0.07.sw,
                            )
                          ],
                        ),
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
                  SizedBox(
                    height: state is HomeInitial ? 0 : 0.7.sh,
                    child: state is ArtNetScanning
                        ? Center(
                            child: GlassBoxTwo(
                              boxColor: Theme.of(context).colorScheme.primary,
                              boxHeight: 0.18.sh,
                              boxWidth: 0.6.sw,
                              child: ShaderMask(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 0.02.sh,
                                    horizontal: 0.02.sw,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Lottie.asset(
                                        'assets/lottie/search_radar.json',
                                        height: 0.1.sh,
                                        frameRate: FrameRate(120),
                                      ),
                                      Text(
                                        "Scanning".toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 47.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
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
                        : state is ArtNetNoFoundNodes
                            ? Center(
                                child: GlassBoxTwo(
                                  gradient: const [
                                    Color.fromARGB(255, 255, 203, 32),
                                    Color.fromARGB(255, 227, 128, 31),
                                  ],
                                  boxColor:
                                      const Color.fromARGB(225, 255, 203, 32),
                                  boxHeight: 0.18.sh,
                                  boxWidth: 0.6.sw,
                                  child: ShaderMask(
                                    child: Padding(
                                      padding: EdgeInsets.all(0.03.sh),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(
                                            Icons.wifi_tethering_error,
                                            size: 0.07.sh,
                                          ),
                                          Text(
                                            "No nodes found".toUpperCase(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 50.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    shaderCallback: (Rect bounds) {
                                      return const LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: <Color>[
                                          Color.fromARGB(255, 255, 203, 32),
                                          Color.fromARGB(255, 227, 128, 31),
                                        ],
                                      ).createShader(bounds);
                                    },
                                  ),
                                ),
                              )
                            : SingleChildScrollView(
                                child: state is ArtNetFoundNodes
                                    ? Column(
                                        children: createNodeList(
                                            ArtNetModule.scanResults),
                                      )
                                    : Container(),
                              ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: state is HomeInitial ? 0.7.sh : 0.15.sh,
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
                              // state is ArtNetScanning
                              //     ? Lottie.asset(
                              //         'assets/lottie/searching.json',
                              //         height: 0.04.sh,
                              //       )
                              //     :
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
